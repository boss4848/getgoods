const express = require('express');
const router = express.Router();

//Shop routes
//Controllers
const shopController = require('../controllers/shopController');
const authController = require('../controllers/authController');
const productRouter = require('./productRoute');

//Nested routes
router.use('/:shopId/products', productRouter);


router
    .route('/')
    .post(
        authController.protect,
        shopController.setShopUserIds,
        shopController.createShop
    );
// Routes
router.route('/:id')
    .get(shopController.getShop)



module.exports = router;