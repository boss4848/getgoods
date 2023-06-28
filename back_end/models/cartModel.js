const mongoose = require('mongoose');

const cartSchema = new mongoose.Schema({
    user: {
        type: mongoose.Schema.ObjectId,
        ref: 'User',
        required: [true, 'A cart must have an user'],
    },
    cartItems: [{
        type: mongoose.Schema.ObjectId,
        ref: 'CartItem',
    }],
}, {
    timestamps: true,
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
});

// cartSchema.pre(/^find/, function (next) {
//     this.populate({
//         path: 'cartItems',
//         populate: {
//             path: 'product',
//             select: 'name price images',
//         }
//     });
//     next();
// }
// );

module.exports = mongoose.model('Cart', cartSchema);
