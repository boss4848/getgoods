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
    .get(productController.getAllProducts)
    .post(
        authController.protect,
        productController.setShopIds,
        shopController.restrictToOwner,
        productController.createProduct
    );

router
    .route('/:id')
    .get(productController.getProduct)
    .patch(
        authController.protect,
        productController.setShopIds,
        shopController.restrictToOwner,
        productController.uploadProductImages,
        productController.resizeProductImages,
        productController.updateProduct
    )
    .delete(productController.deleteProduct);

module.exports = router;