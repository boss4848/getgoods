const mongoose = require('mongoose');
const validator = require('validator');
const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'A user must have a name'],
        trim: true,
        maxlength: [20, 'A user name must have less or equal then 20 characters'],
        minlength: [4, 'A user name must have more or equal then 4 characters'],
    },
    email: {
        type: String,
        required: [true, 'A user must have an email'],
        trim: true,
        unique: true,
        lowercase: true,
        validate: [validator.isEmail, 'Please provide a valid email']
    },
    password: {
        type: String,
        required: [true, 'A user must have a password'],
        trim: true,
        maxlength: [20, 'A user password must have less or equal then 20 characters'],
        minlength: [8, 'A user password must have more or equal then 8 characters'],
    },
    // role: {
    //     type: String,
    //     enum: ['user', 'admin'],
    //     default: 'user'
    // },
    avatar: {
        type: String,
        default: 'https://res.cloudinary.com/dxkufsejm/image/upload/v1620078033/avatars/default_avatar.png'
    },
    phone: {
        type: String,
        required: [true, 'A user must have a phone number'],
        trim: true,
        maxlength: [10, 'A user phone number must have less or equal then 10 characters'],
        minlength: [10, 'A user phone number must have more or equal then 10 characters'],
    },
    address: {
        type: String,
        required: [true, 'A user must have an address'],
        trim: true,
        maxlength: [100, 'A user address must have less or equal then 100 characters'],
        minlength: [10, 'A user address must have more or equal then 10 characters'],
    },
    cart: {
        type: Array,
        default: []
    },
    history: {
        type: Array,
        default: []
    },
    resetPasswordLink: {
        data: String,
        default: ''
    }
},
    { timestamps: true },
    this.collection = 'users'
);

module.exports = mongoose.model('User', userSchema);