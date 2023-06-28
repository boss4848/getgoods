const express = require('express');
const router = express.Router({ mergeParams: true });

//Controllers
const productController = require('../controllers/productController');
const authController = require('../controllers/authController');
const reviewRouter = require('./reviewRoute');
const shopController = require('../controllers/shopController');
const cartRouter = require('./cartRoute');
//Nested routes
router.use('/:productId/reviews', reviewRouter);
router.use('/:productId/cart', cartRouter);

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
        // shopController.restrictToOwner,
        productController.uploadProductImage,
        (req, res, next) => {
            console.log(req.body);
            console.log(req.file);
            next();
        },
        productController.resizeProductImage,
        (req, res, next) => {
            console.log(req.body);
            console.log(req.file);
            next();
        },
        productController.updateProduct
    )
    .delete(
        authController.protect,
        productController.setShopIds,
        shopController.restrictToOwner,
        productController.deleteProduct,
    );

module.exports = router;