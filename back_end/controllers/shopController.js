const Shop = require('../models/shopModel');
const factory = require('./handlerFactory');
const AppError = require('../utils/appError');
const catchAsync = require('../utils/catchAsync');

// Middleware to restrict access to shop owners only
exports.restrictToOwner = catchAsync(async (req, res, next) => {
    //Query shop from database
    const shop = await Shop.findById(req.body.shop);
    // console.log(shop);
    // console.log(`shop owner id: ${shop.owner}`);
    // console.log(`user id: ${req.user.id}`);
    // console.log(req.user);
    // console.log("Check types");
    // console.log(typeof shop.owner.toString());
    // console.log(typeof req.user.id);

    //Check if user is the owner of the shop
    console.log(`Condition: ${req.user.id !== shop.owner}`);
    if (req.user.id !== shop.owner.toString()) {
        return next(new AppError('You are not the owner of this shop.', 403));
    }
    next();
});
exports.checkIfShopExists = catchAsync(async (req, res, next) => {
    const existingShop = await Shop.findOne({ owner: req.user.id });
    if (existingShop) {
        return next(
            new AppError('You already own a shop. You cannot create more than one.', 409)
        );
    }
    next();
});
exports.setShopUserIds = (req, res, next) => {
    //Allow nested routes
    console.log(req.user);
    if (!req.body.owner) req.body.owner = req.user.id;
    next();
};
exports.getShop = factory.getOne(Shop, { path: 'products' });
// exports.createShop = factory.createOne(Shop);
exports.createShop = catchAsync(async (req, res, next) => {
    const owner = req.user.id;
    const { name, description } = req.body;
    const newShop = await Shop.create(
        {
            name,
            description,
            owner,
        },
    );
    res.status(201).json({
        status: 'success',
        data: {
            data: newShop
        }
    });
});

exports.updateShop = factory.updateOne(Shop);

