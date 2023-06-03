const mongoose = require('mongoose');

const reviewSchema = new mongoose.Schema({
    review: {
        type: String,
        required: [true, 'A review must have a review'],
        trim: true,
        maxlength: [200, 'A review must have less or equal then 200 characters'],
        // minlength: [10, 'A review must have more or equal then 10 characters']
    },
    rating: {
        type: Number,
        required: [true, 'A review must have a rating'],
        min: [1, 'Rating must be above 1'],
        max: [5, 'Rating must be below 5']
    },
    product: {
        type: mongoose.Schema.ObjectId,
        ref: 'Product',
        required: [true, 'A review must belong to a product']
    },
    user: {
        type: mongoose.Schema.ObjectId,
        ref: 'User',
        required: [true, 'A review must belong to a user']
    },
},
    {
        timestamps: true,
        toJSON: { virtuals: true },
        toObject: { virtuals: true }
    },
    this.collection = 'reviews'
);

reviewSchema.index({ product: 1, user: 1 }, { unique: true });
reviewSchema.pre(/^find/, function (next) {
    this.populate({
        path: 'user',
        select: 'name'
    });
    next();
});

module.exports = mongoose.model('Review', reviewSchema);