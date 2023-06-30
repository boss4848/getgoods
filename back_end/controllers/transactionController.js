const catchAsync = require('../utils/catchAsync');
const AppError = require('../utils/appError');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const Transaction = require('../models/transactionModel');
const { default: Stripe } = require('stripe');
const Product = require('../models/productModel');

const mongoose = require('mongoose');
const ObjectId = mongoose.Types.ObjectId;
const moment = require('moment');
const Shop = require('../models/shopModel');


exports.updateSold = catchAsync(async (req, res, next) => {
    const products = req.body.products;
    console.log('products', products);

    for (let i = 0; i < products.length; i++) {
        console.log('product id', products[i].id);

        const productStockQuery = Product.updateMany(
            { _id: products[i].id },
            { $inc: { quantity: -products[i].quantity } },
            { new: true }
        ).exec();

        const soldProductQuery = Product.updateMany(
            { _id: products[i].id },
            { $inc: { sold: +products[i].quantity } },
            { new: true }
        ).exec();

        const [productStock, soldProduct] = await Promise.all([
            productStockQuery,
            soldProductQuery,
        ]);

    }


    res.status(200).json({
        status: 'success',
        products
    });

});


exports.getStatss = async (req, res, next) => {
    console.log(req.user);
    const shop = await Shop.findOne({ owner: req.user.id });
    console.log('shop', shop);
    // console.log('req.params', req.params);
    const shopId = req.params.shopId;
    // console.log('shopId', shopId);
    const pipeline = [
        // Filter documents with payStatus = 'paid' and matching shopId
        {
            $match: {
                payStatus: 'paid',
                shop: shop._id,
                // shop: shopId,
                // shop: ObjectId(shopId),
                // shop: req.params.shopId.toString(),
            },
        },
        // Calculate the total number of sold items
        {
            $group: {
                _id: null,
                sold: {
                    $sum: {
                        $sum: '$quantity',
                    },
                },
                revenue: {
                    $sum: {
                        $multiply: ['$amount', { $arrayElemAt: ['$quantity', 0] }],
                    },
                },
            },
        },
        // Calculate the net income based on sold items
        {
            $addFields: {
                netIncome: {
                    $cond: {
                        if: { $lt: ['$sold', 150] },
                        then: { $multiply: ['$revenue', 0.85] }, // Deduct 15% if sold items are less than 150
                        else: {
                            $multiply: [
                                '$revenue',
                                { $add: [1, { $divide: [{ $subtract: ['$sold', 150] }, 70] }] },
                            ], // Increase by 2% for every 70 additional sold items
                        },
                    },
                },
            },
        },
        // Project the desired fields
        {
            $project: {
                _id: 0,
                sold: 1,
                income: '$revenue',
                totalNetIncome: '$netIncome',
            },
        },
    ];



    const result = await Transaction.aggregate(pipeline);
    res.status(200).json({
        status: 'success',
        data: {
            ...result[0],
            email: req.user.email,
            shopName: shop.name,
        },
    });

};



exports.getStats = async (req, res, next) => {
    try {
        // Calculate the start and end dates for the past 7 days
        const endDate = moment().endOf('day');
        const startDate = moment().subtract(7, 'days').startOf('day');

        // Find transactions with status "paid" and within the date range
        const transactions = await Transaction.find({
            payStatus: 'paid',
            createdAt: { $gte: startDate, $lte: endDate }
        });

        // Calculate the total revenue and sold quantity
        let totalRevenue = 0;
        let totalSold = 0;

        transactions.forEach(transaction => {
            transaction.products.forEach((product, index) => {
                const quantity = transaction.quantity[index];
                totalRevenue += product.price * quantity;
                totalSold += quantity;
            });
        });

        res.status(200).json({
            status: 'success',
            data: {
                revenue: totalRevenue,
                sold: totalSold
            }
        });
    } catch (error) {
        next(error);
    }
};



exports.updateTransaction = catchAsync(async (req, res, next) => {
    // console.log(req.params)

    const updatedTransaction = await Transaction.findByIdAndUpdate(
        req.params.id,
        req.body,
        {
            new: true,
            runValidators: true,
        }
    );

    if (!updatedTransaction) {
        return next(new AppError('No transaction found with that ID', 404));
    }

    res.status(200).json({
        status: 'success',
        updatedTransaction,
    });
});

exports.test = catchAsync(async (req, res, next) => {
    //find session
    const checkout = await stripe.checkout.sessions.retrieve(
        // 'cs_test_b1mX6M1MZ5iFyz0ehLoYTuDr6jyZU7evd2xyl4Y879rUQkAnHHrKZClov2'
        'cs_test_b12FXT9OLulJ6SNjBu7kD9sFHQRXm6XpBtmRBplEcw7yCycMU6DPfMzuZM'
    );
    //find payment intent
    // const paymentIntent = await stripe.paymentIntents.retrieve(
    //     'pi_3NMvA9I5fmkNEzwd1tIhvioZ'
    // );
    // //find charge
    // const charge = await stripe.charges.retrieve(
    //     'ch_3NMvA9I5fmkNEzwd1Ch4FprK'
    // );
    res.status(200).json({
        status: 'success',
        checkout,
        paymentIntent,
        charge,
    });
});



exports.getTransaction = catchAsync(async (req, res, next) => {
    const transactions = await Transaction.findById(req.params.id);

    if (!transactions) {
        return next(new AppError('No transaction found with that ID', 404));
    }
    // Replace image URL with image file
    // const newTransactions = transactions.map((transaction) => {
    //     transaction.products.map((product) => {
    //         let imageUrl = `https://getgoods.blob.core.windows.net/product-photos/${product.imageCover}`;
    //         product.image = imageUrl;
    //     });
    //     return transaction;
    // });


    res.status(200).json({
        status: 'success',
        // transactions: newTransactions,
        transactions,
    });
});

exports.getAllTransactions = catchAsync(async (req, res, next) => {
    // find by user id
    const transactions = await Transaction.find({ user: req.user.id });
    // Replace image URL with image file
    // const newTransactions = transactions.map((transaction) => {
    //     transaction.products.map((product) => {
    //         let imageUrl = `https://getgoods.blob.core.windows.net/product-photos/${product.imageCover}`;
    //         product.image = imageUrl;
    //     });
    //     return transaction;
    // });

    res.status(200).json({
        status: 'success',
        // transactions: newTransactions,
        transactions,
    });
});

