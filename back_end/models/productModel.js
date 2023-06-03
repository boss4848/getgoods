const mongoose = require('mongoose');
const { toThaiSlug } = require('../utils/toThaiSlug');

const productSchema = new mongoose.Schema({
    shop_id: {
        type: String,
        required: [true, 'A product must have a shop id']
    },
    discount: {
        type: Number,
        default: 0
    },
    name: {
        type: String,
        required: [true, 'A product must have a name'],
        trim: true,
        maxlength: [40, 'A product name must have less or equal then 40 characters'],
        // minlength: [10, 'A product name must have more or equal then 10 characters']
    },
    slug: String,
    price: {
        type: Number,
        required: [true, 'A product must have a price']
    },
    description: {
        type: String,
        trim: true,
        required: [true, 'A product must have a description']
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
    sold: {
        type: Number,
        default: 0
    },
    images: {
        type: Array,
        default: []
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
        default: 0
    }
},
    { timestamps: true },
    this.collection = 'products',

);

// Convert name to slug
// Craete middleware
productSchema.pre('save', function (next) {
    this.slug = toThaiSlug(this.name);
    next();
});

module.exports = mongoose.model('Product', productSchema);
