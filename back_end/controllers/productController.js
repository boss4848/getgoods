const Product = require('../models/productModel');

exports.getAllProducts = async (req, res) => {
    try {
        const products = await Product.find();

        res.status(200).json({
            status: 'success',
            results: products.length,
            data: {
                products
            }
        });
    }
    catch (err) {
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