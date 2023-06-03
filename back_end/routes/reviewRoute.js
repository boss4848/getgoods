const reviewController = require('../controllers/reviewController');
const authController = require('../controllers/authController');
const express = require('express');
const router = express.Router();

router.route('/')
    .get(reviewController.getAllReviews)
    .post(authController.protect, reviewController.createReview);

router.route('/:id')
    .get(reviewController.getReview);

module.exports = router;
