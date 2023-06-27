const express = require('express');
const router = express.Router();

//Controllers
const transactionController = require('../controllers/transactionController');
const authController = require('../controllers/authController');
//Routes
router
    .route('/')
    .get(
        authController.protect,
        transactionController.getAllTransactions,
    );

module.exports = router;