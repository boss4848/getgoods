const catchAsync = require('../utils/catchAsync');
const AppError = require('../utils/appError');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const Transaction = require('../models/transactionModel');
const { default: Stripe } = require('stripe');

exports.createIntent = catchAsync(async (req, res, next) => {
    const { amount } = req.body;
    // console.log('user: ' + req.user);
    //customer id user.stripeId
    const customer = req.user.stripeId;
    // console.log('customer: ' + customer);
    const paymentIntent = await stripe.paymentIntents.create({
        amount: amount * 100,
        customer: customer,
        currency: 'thb',
    });
    const newTransaction = await Transaction.create({
        amount: amount,
        user: req.user.id,
        shop: '6491a0449c0b5000073308a7',
        products: [
            '649283217350b7d00571b334',
            '64941380c008b08ccc4668b2',
        ],
        stripeId: paymentIntent.id,
        status: 'unpaid',
    })
    res.status(200).json({
        status: 'success',
        amount: amount * 100,
        currency: 'thb',
        paymentIntent: paymentIntent.client_secret,
        paymentIntentData: paymentIntent,
        paymentIntent,

    });
});

exports.createTransaction = catchAsync(async (req, res, next) => {
    const { amount, sessionId } = req.body;
    // const customer = req.user.stripeId;

    const newTransaction = await Transaction.create({
        amount: amount,
        user: req.user.id,
        shop: '6491a0449c0b5000073308a7',
        products: [
            '649283217350b7d00571b334',
            '64941380c008b08ccc4668b2',
        ],
        stripeId: sessionId,
        status: 'unpaid',
    });

    res.status(200).json({
        status: 'success',
        transaction: newTransaction,
    });
});

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

exports.updateCharge = catchAsync(async (req, res, next) => {
    const sessionID = req.body.sessionId;
    const session = await stripe.checkout.sessions.retrieve(
        sessionID,
    );
    const paymentIntent = await stripe.paymentIntents.retrieve(
        session.payment_intent,
    );
    const chargeID = paymentIntent.latest_charge;
    const charge = await stripe.charges.retrieve(chargeID);
    // Update the transaction with the charge ID
    const updatedTransaction = await Transaction.findByIdAndUpdate(
        req.params.id,
        {
            chargeId: charge.id,
            status: 'paid',
            receiptUrl: charge.receipt_url,
            // checkoutUrl: session.url,
        },
        { new: true, runValidators: true }
    );

    res.status(200).json({
        status: 'success',
        charge,
        updatedTransaction,
    });
});

exports.cancelPayment = catchAsync(async (req, res, next) => {
    const sessionID = req.body.sessionId;
    const session = await stripe.checkout.sessions.retrieve(
        sessionID,
    );
    // const paymentIntent = await stripe.paymentIntents.retrieve(
    //     session.payment_intent,
    // );
    // const chargeID = paymentIntent.latest_charge;
    // const charge = await stripe.charges.retrieve(chargeID);
    // Update the transaction with the charge ID
    const updatedTransaction = await Transaction.findByIdAndUpdate(
        req.params.id,
        {
            // chargeId: charge.id,
            status: 'cancelled',
            // receiptUrl: charge.receipt_url,
            checkoutUrl: session.url,
        },
        { new: true, runValidators: true }
    );
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


