const mongoose = require('mongoose');

const transactionSchema = new mongoose.Schema({
    amount: {
        type: Number,
        required: [true, 'A transaction must have an amount'],
    },
    shippingFee: {
        type: Number,
    },
    user: {
        type: mongoose.Schema.ObjectId,
        ref: 'User',
    },
    shop: {
        type: mongoose.Schema.ObjectId,
        ref: 'Shop',
    },
    products: [{
        type: mongoose.Schema.ObjectId,
        ref: 'Product',
    }],
    // stripeId: {
    //     type: String,
    //     required: [true, 'A transaction must have a stripeId'],
    // },// refer to stripe payment intent id
    status: {
        type: String,
        enum: ['unpaid', 'paid', 'cancelled', 'delivered', 'received', 'completed'],
        default: 'unpaid',
    },
    paymentIntentId: {
        type: String,
    },
    sessionId: {
        type: String,
        required: [true, 'A transaction must have a sessionId'],
    },
    receiptUrl: {
        type: String,
    },
    checkoutUrl: {
        type: String,
    },
    chargeId: {
        type: String,
    },
}, {
    timestamps: true,
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
});

module.exports = mongoose.model('Transaction', transactionSchema);