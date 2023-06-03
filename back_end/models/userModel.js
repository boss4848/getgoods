const mongoose = require('mongoose');
const validator = require('validator');
const bcrypt = require('bcryptjs');
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
        select: false
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
},
    { timestamps: true },
    this.collection = 'users'
);

userSchema.pre('save', function (next) {
    // Only run this function if password was actually modified
    if (!this.isModified('password')) return next();

    // Hash the password with cost of 10
    this.password = bcrypt.hashSync(this.password, 10);
    next();
});

userSchema.methods.correctPassword = function (candidatePassword, userPassword) {
    return bcrypt.compareSync(candidatePassword, userPassword);
};

module.exports = mongoose.model('User', userSchema);