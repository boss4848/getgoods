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

reviewSchema.pre('save', async function (next) {
    // Check if the review is new or being modified
    if (!this.isNew) {
        return next();
    }

    try {
        // Check if there is already a review with the same product and user
        const existingReview = await this.constructor.findOne({
            product: this.product,
            user: this.user,
        });

        if (existingReview) {
            // If a duplicate review is found, throw an error
            throw new Error('You have already reviewed this product.');
        }

        next();
    } catch (error) {
        next(error);
    }
});

reviewSchema.statics.calcAverageRatings = async function (productId) {
    const stats = await this.aggregate([
        {
            $match: { product: productId }
        },
        {
            $group: {
                _id: '$product',
                nRating: { $sum: 1 },
                avgRating: { $avg: '$rating' }
            }
        }
    ]);
    console.log(stats);
    if (stats.length > 0) {
        await this.model('Product').findByIdAndUpdate(productId, {
            ratingsQuantity: stats[0].nRating,
            ratingsAverage: stats[0].avgRating
        });
    } else {
        await this.model('Product').findByIdAndUpdate(productId, {
            ratingsQuantity: 0,
            ratingsAverage: 0,
        });
    }
};

reviewSchema.post('save', function () {
    // this points to current review
    this.constructor.calcAverageRatings(this.product);
});

// Reverse populate with virtuals
reviewSchema.virtual('users', {
    ref: 'User',
    foreignField: 'users', // field in the Review model
    localField: '_id' // field in the Product model
});

module.exports = mongoose.model('Review', reviewSchema);