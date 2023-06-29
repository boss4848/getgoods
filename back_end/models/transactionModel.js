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
    quantity: [
        {
            type: Number,
        },
    ],
    // stripeId: {
    //     type: String,
    //     required: [true, 'A transaction must have a stripeId'],
    // },// refer to stripe payment intent id
    status: {
        type: String,
        enum: ['unpaid', 'paid', 'cancelled', 'shipped', 'received', 'completed', 'rated'],
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

transactionSchema.pre(/^find/, function (next) {
    this.populate({
        path: 'user',
        select: 'name email phone address'
    }).populate({
        path: 'shop',
        //filter out owner
        select: 'name'
    }).populate({
        path: 'products',
        select: 'name price quantity imageCover'
    });
    next();
});

module.exports = mongoose.model('Transaction', transactionSchema);