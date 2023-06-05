const Shop = require('../models/shopModel');
const factory = require('./handlerFactory');

exports.setShopUserIds = (req, res, next) => {
    //Allow nested routes
    console.log(req.user);
    if (!req.body.owner) req.body.owner = req.user.id;
    next();
};
exports.getShop = factory.getOne(Shop, { path: 'products' });
exports.createShop = factory.createOne(Shop);

