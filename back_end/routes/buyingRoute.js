const express = require('express');
const buyingController = require('../controllers/buyingController');
const authController = require('../controllers/authController');
const transactionController = require('../controllers/transactionController');
const router = express.Router();

router.get('/checkout-session/:productId',
    authController.protect,
    buyingController.getCheckoutSession
);

router.get('/craete-payment-intent',
    // authController.protect,
    buyingController.createPaymentIntent
);

// router.get('/transactions/:customerId',
//     // authController.protect,
//     buyingController.getTransactions
// );

// router.get('/customer/:email',
//     // authController.protect,
//     buyingController.getCustomerByEmail
// );

// router.post('/transactions',
//     (req, res, next) => {
//         console.log('req.body: ' + req.body);
//         next();
//     },
//     authController.protect,
//     transactionController.createIntent,
// );
// router.get('/transactions',
//     authController.protect,
//     transactionController.getTransactions,
// );
// router.get('/transactions/:piId',
//     transactionController.getTransaction,
// )



module.exports = router;