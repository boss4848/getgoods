const express = require('express');
const router = express.Router();

//Controllers
const transactionController = require('../controllers/transactionController');
const authController = require('../controllers/authController');
//Routes
// router.
//     route('/stats')
//     .get(
//         authController.protect,
//         transactionController.getStats,
//     );

router.
    route('/stats/:shopId')
    .get(
        authController.protect,
        transactionController.getStatss,
    );

router
    .route('/updateSold')
    .patch(
        authController.protect,
        transactionController.updateSold,
    );

router
    .route('/')
    .get(
        authController.protect,
        transactionController.getAllTransactions,
    );

router.route('/:id')
    .patch(
        authController.protect,
        transactionController.updateTransaction,
    )



module.exports = router;