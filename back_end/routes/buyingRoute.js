const express = require('express');
const buyingController = require('../controllers/buyingController');
const authController = require('../controllers/authController');

const router = express.Router();

router.get('/checkout-session/:productId',
    authController.protect,
    buyingController.getCheckoutSession
);

router.get('/craete-payment-intent',
    // authController.protect,
    buyingController.createPaymentIntent
);

module.exports = router;