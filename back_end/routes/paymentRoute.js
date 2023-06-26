const express = require('express');
const router = express.Router({ mergeParams: true });

//Controllers
const stripeController = require('../controllers/stripeController');
const authController = require('../controllers/authController');

//Routes
router
    .route('/')
    .post(
        authController.protect,
        stripeController.createCheckoutSession,
    );

router.route('/updatecharge')
    .post(
        authController.protect,
        stripeController.updateCharge,
    );

router.route('/cancelCheckoutSession')
    .post(
        authController.protect,
        stripeController.cancelCheckoutSession,
    );


module.exports = router;
