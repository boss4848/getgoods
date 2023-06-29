const express = require('express');
const router = express.Router({ mergeParams: true });

//Controllers
const productController = require('../controllers/productController');
const authController = require('../controllers/authController');
const cartController = require('../controllers/cartController');
//Routes
router
    .route('/')
    .get(
        authController.protect,
        cartController.getCart,
        // cartController.getAllCartItems,
    ).post(
        authController.protect,
        cartController.addToCart,
    );

router
    .route('/:cartItemId')
    .patch(
        authController.protect,
        cartController.updateCartItem,
    )
    .delete(
        authController.protect,
        cartController.removeFromCart,
    );

// router
//     .route('/:productId')


module.exports = router;