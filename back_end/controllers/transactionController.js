const catchAsync = require('../utils/catchAsync');
const AppError = require('../utils/appError');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const Transaction = require('../models/transactionModel');
const { default: Stripe } = require('stripe');

exports.updateTransaction = catchAsync(async (req, res, next) => {
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
    const transaction = await Transaction.findById(req.params.id);

    if (!transaction) {
        return next(new AppError('No transaction found with that ID', 404));
    }

    res.status(200).json({
        status: 'success',
        transaction,
    });
});

// exports.getTransaction = catchAsync(async (req, res, next) => {
//     const transaction = await stripe.paymentIntents.retrieve(
//         // 'pi_3NMpVAI5fmkNEzwd0pd5h7lC'
//         req.params.piId,

//     );

//     res.status(200).json({
//         status: 'success',
//         transaction,
//     })
// })

