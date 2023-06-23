const catchAsync = require('../utils/catchAsync');

const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const Product = require('../models/productModel');


exports.getCheckoutSession = catchAsync(async (req, res, next) => {
    // 1) Get the currently bought product
    const product = await Product.findById(req.params.productId);
    console.log('image: ' + product.imageCover)
    product.imageCover = `https://getgoods.blob.core.windows.net/product-photos/${product.imageCover}`
    // 2) Create checkout session
    const session = await stripe.checkout.sessions.create({
        line_items: [
            {
                // name: `${product.name}`,
                // description: product.description,
                // images: [`${product.imageCover}`],
                // amount: product.price * 100,
                // currency: 'thb',
                price_data: {
                    currency: 'thb',
                    unit_amount: product.price * 100,
                    product_data: {
                        name: `${product.name}`,
                        description: product.description,
                        images: [`${product.imageCover}`],
                    },
                },
                quantity: 1
            },
            {
                // name: `${product.name}`,
                // description: product.description,
                // images: [`${product.imageCover}`],
                // amount: product.price * 100,
                // currency: 'thb',
                price_data: {
                    currency: 'thb',
                    unit_amount: product.price * 100,
                    product_data: {
                        name: `${product.name}`,
                        description: product.description,
                        images: [`${product.imageCover}`],
                    },
                },
                quantity: 1
            },
        ],
        mode: 'payment',
        success_url: `http://127.0.0.1:8000/api/v1/products`,
        cancel_url: `http://127.0.0.1:8000/api/v1/products`,
        customer_email: req.user.email,
        client_reference_id: req.params.productId
    });
    // const session = await stripe.checkout.sessions.create({
    //     payment_method_types: ['card'],
    //     // success_url: `${req.protocol}://${req.get('host')}/?product=${
    //     //     req.params.productId
    //     // }&user=${req.user.id}&price=${product.price}`,
    //     success_url: `${req.protocol}://${req.get('host')}/`,
    //     cancel_url: `${req.protocol}://${req.get('host')}/product/${product.slug}`,
    //     customer_email: req.user.email,
    //     client_reference_id: req.params.productId,
    //     line_items: [
    //         {
    //             name: `${product.name}`,
    //             description: product.description,
    //             images: [`https://natours-ecommerce.herokuapp.com/img/products/${product.imageCover}`],
    //             amount: product.price * 100,
    //             currency: 'thb',
    //             quantity: 1
    //         }
    //     ]
    // });

    // 3) Create session as response
    res.status(200).json({
        status: 'success',
        session
    });
});

exports.createPaymentIntent = catchAsync(async (req, res, next) => {
    const paymentIntent = await stripe.paymentIntents.create({
        amount: parseInt(req.query.amount) * 100,
        currency: 'thb',
        //product


        // payment_method_types: ['card'],
        // receipt_email: req.body.email,
        // metadata: { integration_check: 'accept_a_payment' },
    });

    res.status(200).json({
        paymentIntent: paymentIntent.client_secret,

        paymentIntentData: paymentIntent,
        amount: req.query.amount,
        currency: 'thb',
        status: 'success',

        paymentIntent

    });
});



exports.createCheckoutSession = catchAsync(async (req, res, next) => {
    const session = await stripe.checkout.sessions.create({
        payment_method_types: ['card'],
        success_url: `${req.protocol}://${req.get('host')}/`,
        cancel_url: `${req.protocol}://${req.get('host')}/`,
        customer_email: req.user.email,
        line_items: req.body.line_items
    });

    res.status(200).json({
        status: 'success',
        session
    });
});

