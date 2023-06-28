const mongoose = require('mongoose');

const CartItem = new mongoose.Schema({
    shop: {
        type: mongoose.Schema.ObjectId,
        ref: 'Shop',
        required: [true, 'A cart item must have a shop'],
    },
    product: {
        type: mongoose.Schema.ObjectId,
        ref: 'Product',
        required: [true, 'A cart item must have a product'],
    },
    quantity: {
        type: Number,
        default: 1,
    },
}, {
    timestamps: true,
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
});

module.exports = mongoose.model('CartItem', CartItem);