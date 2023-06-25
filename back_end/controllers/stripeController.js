const catchAsync = require('../utils/catchAsync');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const User = require('../models/userModel');
const Transaction = require('../models/transactionModel');

exports.craeteCheckoutSession = catchAsync(async (req, res, next) => {
    const { products, amount } = req.body;
    const customer = req.user.stripeId;

    const lineItems = products.map(product => ({
        price_data: {
            currency: 'thb',
            product_data: {
                name: product.name,
                images: [product.imageCover],
            },
            unit_amount: product.price * 100,
        },
        quantity: product.quantity,
    }));

    const session = await stripe.checkout.sessions.create({
        payment_method_types: ['card'],
        line_items: lineItems,
        customer: customer,
        success_url: 'https://checkout.stripe.dev/success',
        cancel_url: 'https://checkout.stripe.dev/cancel',
    });

    if (!session) {
        return next(new AppError('The session is not created', 400));
    }

    log(session);

    const transaction = await Transaction.create({
        user: req.user.id,
        products: products.map(product => product.id),
        amount: amount,
        paymentIntentId: session.payment_intent,
        sessionId: session.id,
        checkoutUrl: session.url,
    });

    if (!transaction) {
        return next(new AppError('The transaction is not created', 400));
    }

    res.status(200).json({
        status: 'success',
        sessionId: session.id,
        transaction,
    });

});