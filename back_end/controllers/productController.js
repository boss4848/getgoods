const Product = require('../models/productModel');
const APIFeatures = require('../utils/apiFeatures');
const catchAsync = require('../utils/catchAsync');
const AppError = require('../utils/appError');

exports.getAllProducts = catchAsync(async (req, res, next) => {
    const features = new APIFeatures(
        Product.find(),
        req.query
    )
        .filter()
        .sort()
        .limitFields()
        .paginate();

    //Execute query
    const products = await features.query;

    res.status(200).json({
        status: 'success',
        results: products.length,
        data: {
            products
        }
    });

});

exports.getProduct = catchAsync(async (req, res, next) => {
    const product = await Product.findById(req.params.id);

    if (!product) {
        return next(new AppError('No product found with that ID', 404));
    }
    res.status(200).json({
        status: 'success',
        data: {
            product
        }
    });

});

exports.updateProduct = catchAsync(async (req, res, next) => {
    const product = await Product.findByIdAndUpdate(
        req.params.id,
        req.body,
        {
            new: true, // return the new updated product
            // runValidators: true // run the validator on the new value
        }
    )

    res.status(200).json({
        status: 'success',
        data: {
            product
        }
    });

});



exports.createProduct = catchAsync(async (req, res, next) => {
    const newProduct = await Product.create(req.body);

    res.status(201).json({
        status: 'success',
        data: {
            product: newProduct
        }
    });
});

exports.deleteProduct = catchAsync(async (req, res, next) => {
    await Product.findByIdAndDelete(req.params.id);

    res.status(204).json({
        status: 'success',
        message: 'Product deleted',
    });
});