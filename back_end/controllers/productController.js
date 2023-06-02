const Product = require('../models/productModel');
const APIFeatures = require('../utils/apiFeatures');
exports.getAllProducts = async (req, res) => {
    try {
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
    } catch (err) {
        res.status(404).json({
            status: 'fail',
            message: err.message
        });
    }
}
exports.getProduct = async (req, res) => {
    try {
        const product = await Product.findById(req.params.id);

        res.status(200).json({
            status: 'success',
            data: {
                product
            }
        });
    } catch (err) {
        res.status(404).json({
            status: 'fail',
            message: err.message
        });
    }
}

exports.updateProduct = async (req, res) => {
    try {
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
    } catch (err) {
        res.status(404).json({
            status: 'fail',
            message: err.message
        });
    }
}



exports.createProduct = async (req, res) => {
    try {
        const newProduct = await Product.create(req.body);

        res.status(201).json({
            status: 'success',
            data: {
                product: newProduct
            }
        });
    } catch (err) {
        res.status(400).json({
            status: 'fail',
            message: err.message
        });
    }
}

exports.deleteProduct = async (req, res) => {
    try {
        await Product.findByIdAndDelete(req.params.id);

        res.status(204).json({
            status: 'success',
            message: 'Product deleted',
        });
    } catch (err) {
        res.status(404).json({
            status: 'fail',
            message: err.message
        });
    }
}