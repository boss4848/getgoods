const Product = require('../models/productModel');
const factory = require('./handlerFactory');

exports.setShopIds = async (req, res, next) => {
    // Allow nested routes
    console.log(req.params);
    if (!req.body.shop) req.body.shop = req.params.shopId;
    console.log(req.body.shop);
    next();
};

exports.getAllProducts = factory.getAll(Product);
exports.getProduct = factory.getOne(Product, { path: 'reviews' });
exports.updateProduct = factory.updateOne(Product);
exports.createProduct = factory.createOne(Product);
exports.deleteProduct = factory.deleteOne(Product);
