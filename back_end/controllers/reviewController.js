const Review = require('../models/reviewModel');
const catchAsync = require('../utils/catchAsync');
const factory = require('./handlerFactory');
const APIFeatures = require('../utils/apiFeatures');
const { options } = require('../app');

exports.setProductUserIds = (req, res, next) => {
    //Allow nested routes
    console.log(req.user);
    if (!req.body.product) req.body.product = req.params.productId;
    if (!req.body.user) req.body.user = req.user.id;
    next();
};
exports.getAllReviews = catchAsync(async (req, res, next) => {
    //Allow nested routes
    let filter = {};
    if (req.params.productId) filter = { product: req.params.productId };

    const features = new APIFeatures(Review.find(filter), req.query)
        .filter()
        .sort()
        .limitFields()
        .paginate();

    //Execute query
    const reviews = await features.query.populate(
        'user',
        'name photo'
    );
    // https://getgoods.blob.core.windows.net/user-photos/
    const filesUrl = reviews.map((review) => {
        return `https://getgoods.blob.core.windows.net/user-photos/${review.user.photo}`;
    });
    // Replace the imageCover property with the file URL
    reviews.forEach((review, i) => {
        review.user.photo = filesUrl[i];
    });

    res.status(200).json({
        status: 'success',
        results: reviews.length,
        data: {
            reviews
        }
    });
})

exports.getReview = factory.getOne(Review);
exports.createReview = factory.createOne(Review);
exports.deleteReview = factory.deleteOne(Review);