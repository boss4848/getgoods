const Product = require('../models/productModel');
const factory = require('./handlerFactory');
const multer = require('multer');
const { BlobServiceClient } = require('@azure/storage-blob');
const dotenv = require('dotenv');
const catchAsync = require('../utils/catchAsync');
const sharp = require('sharp');
const AppError = require('../utils/appError');
const APIFeatures = require('../utils/apiFeatures');
dotenv.config({ path: './config.env' });

const multerStorage = multer.memoryStorage();
const multerFilter = (req, file, cb) => {
    //Only accept image files
    if (file.mimetype.startsWith('image')) {
        cb(null, true);
    } else {
        cb(new AppError('Not an image! Please upload only images.', 400), false);
    }
};

const upload = multer({
    storage: multerStorage,
    fileFilter: multerFilter
});



const blobServiceClient = BlobServiceClient.fromConnectionString(process.env.AZURE_STORAGE_CONNECTION_STRING);

exports.uploadProductImage = upload.single('imageCover');

exports.resizeProductImage = catchAsync(async (req, res, next) => {
    if (!req.file) return next();
    req.file.filename = `product-${req.params.id}-${Date.now()}-cover.jpeg`;

    // Resize the image to 400x400
    const resizedImageBuffer = await sharp(req.file.buffer)
        .resize(600, 600)
        .toBuffer();

    // Upload the resized image to Azure Blob Storage
    const containerClient = blobServiceClient.getContainerClient('product-photos');
    const blockBlobClient = containerClient.getBlockBlobClient(req.file.filename);

    await blockBlobClient.uploadData(resizedImageBuffer, {
        blobHTTPHeaders: {
            blobContentType: 'image/jpeg',
        },
    });

    req.body.imageCover = req.file.filename;

    next();
});


// exports.uploadProductImages = upload.fields([
//     { name: 'imageCover', maxCount: 1 },
//     { name: 'images', maxCount: 3 }
// ]);
// exports.resizeProductImages = catchAsync(async (req, res, next) => {
//     if (!req.files.imageCover || !req.files.images) return next();
//     // console.log(req.files);

//     // 1) Cover image
//     req.body.imageCover = `product-${req.params.id}-cover.jpeg`;

//     // Resize the image to 600x600
//     const resizedImageBuffer = await sharp(req.files.imageCover[0].buffer)
//         .resize(600, 600)
//         .toBuffer();

//     // Upload the resized image to Azure Blob Storage
//     const containerClient = blobServiceClient.getContainerClient('product-photos');
//     const blockBlobClient = containerClient.getBlockBlobClient(req.body.imageCover);

//     await blockBlobClient.uploadData(resizedImageBuffer, {
//         blobHTTPHeaders: {
//             blobContentType: 'image/jpeg',
//         },
//     });

//     // 2) Images
//     req.body.images = [];

//     await Promise.all(
//         req.files.images.map(async (file, i) => {
//             const fileName = `product-${req.params.id}-${Date.now()}-${i + 1}.jpeg`;

//             // Resize the image to 600x600
//             const resizedImageBuffer = await sharp(file.buffer)
//                 .resize(600, 600)
//                 .toBuffer();

//             // Upload the resized image to Azure Blob Storage
//             const containerClient = blobServiceClient.getContainerClient('product-photos');
//             const blockBlobClient = containerClient.getBlockBlobClient(fileName);

//             await blockBlobClient.uploadData(resizedImageBuffer, {
//                 blobHTTPHeaders: {
//                     blobContentType: 'image/jpeg',
//                 },
//             });

//             req.body.images.push(fileName);
//         })
//     );

//     next();
// });

exports.setShopIds = async (req, res, next) => {
    // Allow nested routes
    console.log(req.params);
    if (!req.body.shop) req.body.shop = req.params.shopId;
    console.log(req.body.shop);
    next();
};

exports.getAllProducts = catchAsync(async (req, res, next) => {
    // const products = await Product.find();
    const features = new APIFeatures(Product.find(), req.query)
        .filter()
        .sort()
        .limitFields()
        .paginate();
    const products = await features.query;

    // Retrieve the image from Azure Blob Storage
    // https://getgoods.blob.core.windows.net/product-photos/product-647e11342c024208eb1d9a15-cover.jpeg
    // if (products.imageCover === undefined) {
    //     products.imageCover = `https://getgoods.blob.core.windows.net/product-photos/default-product-cover.jpeg`;
    // }
    const filesUrl = products.map((product) => {
        return `https://getgoods.blob.core.windows.net/product-photos/${product.imageCover}`;
    });
    // Replace the imageCover property with the file URL
    products.forEach((product, i) => {
        product.imageCover = filesUrl[i];
    });

    res.status(200).json({
        status: 'success',
        results: products.length,
        data: {
            products
        }
    });
});

exports.getProduct = catchAsync(async (req, res, next) => {
    const product = await Product.findById(req.params.id)
        .populate('reviews')
        //populate the shop field with the name and location
        .populate({
            path: 'shop',
            select: 'name location'
        });

    // Retrieve the image from Azure Blob Storage
    // https://getgoods.blob.core.windows.net/product-photos/product-647e11342c024208eb1d9a15-cover.jpeg
    const fileUrl = `https://getgoods.blob.core.windows.net/product-photos/${product.imageCover}`;

    const filesUrl = product.images.map((image) => {
        return `https://getgoods.blob.core.windows.net/product-photos/${image}`;
    });
    // Replace the imageCover property with the file URL
    product.imageCover = fileUrl;
    product.images = filesUrl;

    res.status(200).json({
        status: 'success',
        data: {
            product
        }
    });
});
exports.updateProduct = factory.updateOne(Product);

exports.createProduct = factory.createOne(Product);
exports.deleteProduct = factory.deleteOne(Product);

exports.searchProductByName = catchAsync(async (req, res, next) => {
    const name = req.params.name;

    const products = await Product.find({
        name: { $regex: new RegExp(name, 'i') }
    });

    // Retrieve the image from Azure Blob Storage
    const filesUrl = products.map((product) => {
        return `https://getgoods.blob.core.windows.net/product-photos/${product.imageCover}`;
    });

    // Replace the imageCover property with the file URL
    products.forEach((product, i) => {
        product.imageCover = filesUrl[i];
    });

    res.status(200).json({
        status: 'success',
        results: products.length,
        data: {
            products
        }
    });
});
