const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({

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
        required: [true, 'A product must belong to a category']
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

module.exports = mongoose.model('Product', productSchema);
