const express = require('express');
const router = express.Router();

//Shop routes
//Controllers
const shopController = require('../controllers/shopController');
const authController = require('../controllers/authController');
const productRouter = require('./productRoute');

//Nested routes
router.use('/:shopId/products', productRouter);

//After this middleware, all routes will be protected
router.use(authController.protect);
router
    .route('/')
    .post(
        shopController.setShopUserIds,
        shopController.createShop
    );
// Routes
router.route('/:id')
    .get(shopController.getShop)



module.exports = router;