const express = require('express');
const router = express.Router({ mergeParams: true });

//Controllers
const productController = require('../controllers/productController');
const authController = require('../controllers/authController');
const reviewRouter = require('./reviewRoute');
const shopController = require('../controllers/shopController');

//Nested routes
router.use('/:productId/reviews', reviewRouter);

//Routes
router
    .route('/')
    .get(authController.protect, productController.getAllProducts)
    .post(
        authController.protect,
        productController.setShopIds,
        shopController.restrictToOwner,
        productController.createProduct
    );

router.use(authController.protect);
router.use(shopController.restrictToOwner);

router
    .route('/:id')
    .get(productController.getProduct)
    .patch(productController.updateProduct)
    .delete(productController.deleteProduct);

module.exports = router;