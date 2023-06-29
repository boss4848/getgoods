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
        shopController.checkIfShopExists,
        shopController.createShop
    );
// Routes
router.route('/:id')
    .get(shopController.getShop)
    .patch(
        authController.protect,
        // shopController.checkIfShopExists,
        shopController.updateShop

    )

router.route('/getShopName/:id').get(
    authController.protect,
    shopController.getShopName);



module.exports = router;