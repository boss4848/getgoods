const Review = require('../models/reviewModel');
const factory = require('./handlerFactory');


exports.setProductUserIds = (req, res, next) => {
    //Allow nested routes
    console.log(req.user);
    if (!req.body.product) req.body.product = req.params.productId;
    if (!req.body.user) req.body.user = req.user.id;
    next();
};
exports.getAllReviews = factory.getAll(Review);
exports.getReview = factory.getOne(Review);
exports.createReview = factory.createOne(Review);
exports.deleteReview = factory.deleteOne(Review);