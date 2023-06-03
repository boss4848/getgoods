const reviewController = require('../controllers/reviewController');
const authController = require('../controllers/authController');
const express = require('express');
const router = express.Router({ mergeParams: true }); //mergeParams: true is to allow access to params from other routes


router.route('/')
    .get(reviewController.getAllReviews)
    .post(
        authController.protect,
        reviewController.createReview
    );

// router.route('/:id')
//     .get(reviewController.getReview);

module.exports = router;
