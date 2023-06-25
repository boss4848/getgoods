const { BlobServiceClient } = require('@azure/storage-blob');
const User = require('../models/userModel');
const catchAsync = require('../utils/catchAsync');
const multer = require('multer');
const sharp = require('sharp');
const dotenv = require('dotenv');
dotenv.config({ path: './config.env' });
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const AppError = require('../utils/appError');

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

exports.uploadUserPhoto = upload.single('photo');

exports.resizeUserPhoto = catchAsync(async (req, res, next) => {
    if (!req.file) return next();
    req.file.filename = `user-${req.user.id}-${Date.now()}.jpeg`;

    // Resize the image to 400x400
    const resizedImageBuffer = await sharp(req.file.buffer)
        .resize(400, 400)
        .toBuffer();

    // Upload the resized image to Azure Blob Storage
    const containerClient = blobServiceClient.getContainerClient('user-photos');
    const blockBlobClient = containerClient.getBlockBlobClient(req.file.filename);

    await blockBlobClient.uploadData(resizedImageBuffer, {
        blobHTTPHeaders: {
            blobContentType: 'image/jpeg',
        },
    });

    next();
});


const filterObj = (obj, ...allowedFields) => {
    const newObj = {};
    Object.keys(obj).forEach(el => {
        if (allowedFields.includes(el)) newObj[el] = obj[el];
    });
    return newObj;
};

exports.updateMe = catchAsync(async (req, res, next) => {
    // Create error if user POSTs password data
    if (req.body.password || req.body.passwordConfirm) {
        return next(
            new AppError(
                'This route is not for password updates. Please use /updateMyPassword.',
                400
            )
        );
    }

    // Filtered out unwanted fields names that are not allowed to be updated
    const filteredBody = filterObj(
        req.body,
        'name',
        'email',
        'phone',
        'address',
    );
    if (req.file) filteredBody.photo = req.file.filename;

    // Update to stripe
    const user = await User.findById(req.user.id);
    // console.log(user)
    if (!user.stripeId) {
        return next(new AppError('Cannot find stripe id', 400));

    }
    const updatedCustomer = await stripe.customers.update(user.stripeId, {
        name: req.body.name,
        email: req.body.email,
        phone: req.body.phone,
        address: {
            line1: req.body.address.detail,//ที่อยู่
            state: req.body.address.province_en, //จังหวัด
            city: req.body.address.district_en,//อำเภอ
            line2: req.body.address.sub_district_en,//ตำบล
            country: 'th',//ประเทศ
            postal_code: req.body.address.post_code,//รหัสไปรษณีย์
        },
    });
    // console.log(updatedCustomer);
    console.log(filteredBody);

    // Update user document and location
    const updatedUser = await User.findByIdAndUpdate(
        req.user.id,
        filteredBody,
        {
            new: true,
            runValidators: true
        }
    );
    res.status(200).json({
        status: 'success',
        data: {
            user: updatedUser,
            customer: updatedCustomer,
        }
    });
});

exports.getMe = catchAsync(async (req, res, next) => {
    // Get the current user
    const user = await User.findById(req.user.id).populate('shop');

    // Retrieve the file URL from Azure Blob Storage
    const fileUrl = `https://getgoods.blob.core.windows.net/user-photos/${user.photo}`;

    res.status(200).json({
        status: 'success',
        data: {
            user: {
                id: user._id,
                name: user.name,
                email: user.email,
                photo: fileUrl, // Add the file URL to the response
                shop: user.shop,
            }
        }
    });
});
