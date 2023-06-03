const mongoose = require('mongoose');
const { toThaiSlug } = require('../utils/toThaiSlug');

const productSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'A product must have a name'],
        trim: true,
        maxlength: [40, 'A product name must have less or equal then 40 characters'],
        // minlength: [10, 'A product name must have more or equal then 10 characters']
    },
    images: {
        type: Array,
        default: []
    },
    slug: String,


    description: {
        type: String,
        trim: true,
        required: [true, 'A product must have a description'],
        maxlength: [200, 'A product description must have less or equal then 200 characters'],
    },
    category: {
        type: String,
        enum: ["processed", "otop", "medicinalPlant", "driedGood"],
        required: [true, 'A product must have a category']
    },
    quantity: {
        type: Number,
        required: [true, 'A product must have a quantity']
    },
    price: {
        type: Number,
        required: [true, 'A product must have a price'],
        min: [0, 'Price must be above 0']
    }, discount: {
        type: Number,
        default: 0,
        min: [0, 'Discount must be above 0'],
        max: [100, 'Discount must be below 100']
    },
    sold: {
        type: Number,
        default: 0,
        min: [0, 'Sold must be above 0']
    },

    // shipping: {
    //     type: String,
    //     enum: ['Yes', 'No']
    // },
    // color: {
    //     type: String,
    //     enum: ['Black', 'Brown', 'Silver', 'White', 'Blue']
    // },
    // brand: {
    //     type: String,
    //     enum: ['Apple', 'Samsung', 'Microsoft', 'Lenovo', 'ASUS']
    // },
    ratings: {
        type: Number,
        default: 0,
        min: [0, 'Rating must be above 0'],
        max: [5, 'Rating must be below 5'],
    },
    // reviews: [
    //     {
    //         type: mongoose.Schema.Types.ObjectId,
    //         ref: 'Review'
    //     }
    // ],

},
    {
        timestamps: true,
        toJSON: { virtuals: true },
        toObject: { virtuals: true }
    },
    this.collection = 'products',
);

// Convert name to slug
// Craete middleware
productSchema.pre('save', function (next) {
    this.slug = toThaiSlug(this.name);
    next();
});


// Reverse populate with virtuals
productSchema.virtual('reviews', {
    ref: 'Review',
    foreignField: 'product', // field in the Review model
    localField: '_id' // field in the Product model
});



module.exports = mongoose.model('Product', productSchema);
