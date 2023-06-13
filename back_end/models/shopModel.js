const mongoose = require('mongoose');
const { toThaiSlug } = require('../utils/toThaiSlug');

//Shop model
const shopSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'A shop must have a name'],
        trim: true,
        maxlength: [40, 'A shop name must have less or equal then 40 characters'],
        // minlength: [10, 'A shop name must have more or equal then 10 characters']
    },
    slug: String,
    description: {
        type: String,
        trim: true,
        required: [true, 'A shop must have a description'],
        maxlength: [200, 'A shop description must have less or equal then 200 characters'],
    },
    location: {
        type: String,
        // required: [true, 'A shop must have a location']
    },
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: [true, 'A shop must have an owner'],
    },
    // products: [
    //     {
    //         type: mongoose.Schema.Types.ObjectId,
    //         ref: 'Product',
    //     },
    // ],
    // bankAccount: {
    //     type: String,
    //     trim: true,
    //     required: [true, 'A shop must have a bank account'],
    //     maxlength: [20, 'A shop bank account must have less or equal then 20 characters'],

},
    {
        timestamps: true,
        toJSON: { virtuals: true },
        toObject: { virtuals: true }
    },
    this.collection = 'shops'
);

shopSchema.pre('save', function (next) {
    this.slug = toThaiSlug(this.name);
    next();
});

shopSchema.virtual('products', {
    ref: 'Product',
    foreignField: 'shop',
    localField: '_id'
});

module.exports = mongoose.model('Shop', shopSchema);