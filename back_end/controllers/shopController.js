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
    // console.log(`Condition: ${req.user.id !== shop.owner}`);
    console.log('User ID: ' + req.user.id);
    console.log('Shop owner ID: ' + shop.owner.id);
    if (req.user.id !== shop.owner.id.toString()) {
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

// exports.getShop = factory.getOne(Shop, { path: 'products' });
exports.getShop = catchAsync(async (req, res, next) => {
    const shop = await Shop.findById(req.params.id)
        .populate(
            'products',
            // 'name price quantity',
        );
    if (!shop) {
        return next(new AppError('No shop found for this user', 404));
    }

    // Replace image URLs in products
    shop.products.forEach(product => {
        product.imageCover = `https://getgoods.blob.core.windows.net/product-photos/${product.imageCover}`;
        product.images = product.images.map(image => `https://getgoods.blob.core.windows.net/product-photos/${image}`);
    });


    res.status(200).json({
        status: 'success',
        data: {
            data: shop
        }
    });
});

exports.createShop = catchAsync(async (req, res, next) => {
    const owner = req.user.id;
    const { name, description, location } = req.body;
    const newShop = await Shop.create(
        {
            name,
            description,
            owner,
            location,
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

