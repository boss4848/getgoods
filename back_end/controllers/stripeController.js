const catchAsync = require('../utils/catchAsync');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const User = require('../models/userModel');
const Transaction = require('../models/transactionModel');

exports.createCheckoutSession = catchAsync(async (req, res, next) => {
    const { products, amount, coupons, shopId, shippingFee } = req.body;
    const customer = req.user && req.user.stripeId;
    let subTotal = 0;
    const lineItems = products.map((product) => {
        // console.log(product.shop);
        subTotal += product.price * product.quantity;
        console.log('product: ' + product.images);
        return {
            price_data: {
                currency: 'thb',
                product_data: {
                    name: product.name,
                    images: [product.images == 'default.jpg' ? 'https://getgoods.blob.core.windows.net/product-photos/https://getgoods.blob.core.windows.net/product-photos/default.jpeg' : product.images],
                },
                unit_amount: product.price * 100,
            },
            quantity: product.quantity,
        };
    });

    // const couponsList = coupons.map((coupon) => {
    //     return {
    //         coupon: coupon,
    //     };
    // });

    const shipping_options = [
        {
            shipping_rate_data: {
                type: 'fixed_amount',
                fixed_amount: {
                    amount: 0,
                    currency: 'thb',
                },
                display_name: 'Free shipping',
                delivery_estimate: {
                    minimum: {
                        unit: 'business_day',
                        value: 3,
                    },
                    maximum: {
                        unit: 'business_day',
                        value: 7,
                    },
                },
            },
        },
        {
            shipping_rate_data: {
                type: 'fixed_amount',
                fixed_amount: {
                    amount: 40 * 100,
                    currency: 'thb',
                },
                display_name: 'Fast shipping',
                delivery_estimate: {
                    minimum: {
                        unit: 'business_day',
                        value: 1,
                    },
                    maximum: {
                        unit: 'business_day',
                        value: 2,
                    },
                },
            },
        },
    ];

    const session = await stripe.checkout.sessions.create({
        payment_method_types: ['card'],
        line_items: lineItems,
        customer: customer,
        mode: 'payment',
        success_url: 'https://checkout.stripe.dev/success',
        cancel_url: 'https://checkout.stripe.dev/cancel',
        shipping_options: shipping_options,
        // discounts: [{
        //     coupon: 'L4kZomF5',
        // }],

    });

    if (!session) {
        return next(new AppError('The session is not created', 400));
    }

    console.log(session);
    console.log(products[0].shop);

    const transaction = await Transaction.create({
        user: req.user.id,
        products: products.map(product => product.id),
        quantity: products.map(product => product.quantity),
        shop: shopId,
        amount: subTotal,
        paymentIntentId: session.payment_intent,
        sessionId: session.id,
        checkoutUrl: session.url,
        shippingFee: shippingFee,
    });

    if (!transaction) {
        return next(new AppError('The transaction is not created', 400));
    }

    res.status(200).json({
        status: 'success',
        sessionId: session.id,
        transactionId: transaction.id,
    });

});

exports.updateCharge = catchAsync(async (req, res, next) => {
    console.log('req.body: ' + req.body);
    const { sessionId, transactionId } = req.body;

    const session = await stripe.checkout.sessions.retrieve(sessionId);
    const paymentIntentId = session.payment_intent;
    const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);
    const chargeId = paymentIntent.latest_charge;
    const charge = await stripe.charges.retrieve(chargeId);

    const updatedTransaction = await Transaction.findByIdAndUpdate(
        transactionId,
        {
            status: 'paid',
            chargeId: chargeId,
            receiptUrl: charge.receipt_url,
            shippingFee: session.total_details.amount_shipping / 100 ?? 0,
            amount: charge.amount / 100,

        },
        {
            new: true,
            runValidators: true,
        },
    );
    res.status(200).json({
        status: 'success',
        updatedTransaction,
        charge,
        session,
        paymentIntent,
    });
});

exports.cancelCheckoutSession = catchAsync(async (req, res, next) => {
    const { transactionId } = req.body;

    const transaction = await Transaction.findByIdAndUpdate(transactionId,
        {
            status: 'cancelled',
        },
        {
            new: true,
            runValidators: true,
        },
    );

    if (!transaction) {
        return next(new AppError('The transaction is not found', 400));
    }

    res.status(200).json({
        status: 'success',
        transaction,
    });
});

