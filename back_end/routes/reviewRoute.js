const reviewController = require('../controllers/reviewController');
const authController = require('../controllers/authController');
const express = require('express');
const router = express.Router({ mergeParams: true }); //mergeParams: true is to allow access to params from other routes


router.route('/')
    .get(reviewController.getAllReviews)
    .post(
        authController.protect,
        reviewController.setProductUserIds,
        reviewController.createReview,
    );

router.route('/:id')
    .delete(reviewController.deleteReview);

module.exports = router;
