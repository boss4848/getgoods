const User = require('../models/userModel');
const catchAsync = require('../utils/catchAsync');
const jwt = require('jsonwebtoken');
const AppError = require('../utils/appError');
const { promisify } = require('util');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const Cart = require('../models/cartModel');

const signToken = id => {
    return jwt.sign({ id },
        process.env.JWT_SECRET, {
        expiresIn: process.env.JWT_EXPIRES_IN
    });
}

exports.signup = catchAsync(async (req, res, next) => {
    //create stripe customer
    const customer = await stripe.customers.create({
        email: req.body.email,
        name: req.body.name,
    });
    console.log(customer);
    //handle error
    if (!customer) {
        return next(new AppError('Creating customer on stripe error', 401));
    }
    //create user
    const newUser = await User.create({
        name: req.body.name,
        email: req.body.email,
        password: req.body.password,
        // address: req.body.address,
        // phone: req.body.phone,
        stripeId: customer.id,
        // passwordConfirm: req.body.passwordConfirm
    });
    //create cart
    const newCart = await Cart.create({
        user: newUser._id,
    });
    const token = signToken(newUser._id);

    res.status(201).json({
        status: 'success',
        token,
        data: {
            user: newUser,
            stripe: customer,
        }
    });
});
exports.login = catchAsync(async (req, res, next) => {
    const email = req.body.email;
    const password = req.body.password;
    //Check if email and password exist
    if (!email || !password) {
        return next(new AppError('Please provide email and password!', 400));
    }
    //Check if user exists && password is correct
    const user = await User.findOne({ email }).select('+password');

    if (!user) {
        return next(new AppError('Incorrect email or password', 401));
    }

    const correct = await user.correctPassword(password, user.password);

    if (!correct) {
        return next(new AppError('Incorrect email or password', 401));
    }
    //If everything ok, send token to client
    const token = signToken(user._id);
    res.status(200).json({
        status: 'success',
        token,
        data: {
            user
        }
    });
});


exports.protect = catchAsync(async (req, res, next) => {
    //Getting token and check if it's there
    let token;
    // console.log(req.headers);
    if (req.headers.authorization &&
        req.headers.authorization.startsWith('Bearer')) {
        token = req.headers.authorization.split(' ')[1];
    }
    if (!token) {
        return next(new AppError('You are not logged in! Please log in to get access.', 401));
    }
    //Verification token
    const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);
    //Check if user still exists
    const freshUser = await User.findById(decoded.id);
    if (!freshUser) {
        return next(
            new AppError('The user belonging to this token does no longer exist.',
                401
            )
        );
    }
    //Check if user changed password after the token was issued
    if (freshUser.changedPasswordAfter(decoded.iat)) {
        return next(new AppError('User recently changed password! Please log in again.', 401));
    }
    //Grant access to protected route
    req.user = freshUser;
    next();
});
