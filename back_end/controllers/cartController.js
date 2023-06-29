const Cart = require('../models/cartModel');
const CartItem = require('../models/cartItemsModel');
const Product = require('../models/productModel');
const catchAsync = require('../utils/catchAsync');
const AppError = require('../utils/appError');
const Shop = require('../models/shopModel');

exports.addToCart = catchAsync(async (req, res, next) => {
    console.log('params', req.params);
    console.log('user', req.user);
    const cart = await Cart.findOne({ user: req.user.id });

    if (!cart) {
        return next(new AppError('No cart found with that ID', 404));
    }

    const cartItem = await CartItem.create({
        shop: req.params.shopId,
        product: req.params.productId,
        quantity: req.body.quantity,
    });


    const updatedCart = await Cart.findByIdAndUpdate(
        cart.id,
        {
            $push: { cartItems: cartItem.id },
        },
        { new: true, runValidators: true }
    );

    if (!updatedCart) {
        return next(new AppError('No cart found with that ID', 404));
    }

    res.status(200).json({
        status: 'success',
        data: {
            cart: updatedCart,
            cartItem: cartItem,
        },
    });
});

exports.removeFromCart = catchAsync(async (req, res, next) => {
    console.log('params', req.params);
    console.log('user', req.user);
    const cart = await Cart.findOne({ user: req.user.id });

    if (!cart) {
        return next(new AppError('No cart found with that ID', 404));
    }

    const cartItemId = req.params.cartItemId;

    // Remove the cart item from the cartItems array
    const updatedCart = await Cart.findByIdAndUpdate(
        cart.id,
        {
            $pull: { cartItems: cartItemId },
        },
        { new: true }
    );

    if (!updatedCart) {
        return next(new AppError('No cart found with that ID', 404));
    }

    // Remove the cart item document
    await CartItem.findByIdAndDelete(cartItemId);

    res.status(200).json({
        status: 'success',
        data: {
            cart: updatedCart,
            cartItemId: cartItemId,
        },
    });
});

exports.updateCartItem = catchAsync(async (req, res, next) => {
    const { cartItemId } = req.params;
    const { quantity } = req.body;

    // Validate request body
    if (!quantity || typeof quantity !== 'number') {
        return next(new AppError('Invalid quantity', 400));
    }

    const cartItem = await CartItem.findById(cartItemId);

    if (!cartItem) {
        return next(new AppError('No cart item found with that ID', 404));
    }

    // Update cart item quantity
    cartItem.quantity = quantity;
    await cartItem.save();

    res.status(200).json({
        status: 'success',
        data: {
            cartItem,
        },
    });
});


exports.getAllCartItems = catchAsync(async (req, res, next) => {
    const cart = await Cart.findOne({ user: req.user.id }).populate({
        path: 'cartItems',
        populate: {
            path: 'product',
            path: 'shop',
        },
        select: 'product name quantity',

    });

    if (!cart) {
        return next(new AppError('No cart found with that ID', 404));
    }

    res.status(200).json({
        status: 'success',
        data: {
            cart: cart,
        },
    });
});


exports.getCart = catchAsync(async (req, res, next) => {
    const cart = await Cart.findOne({ user: req.user.id }).populate({
        path: 'cartItems',
        populate: [
            {
                path: 'product',
                select: 'name description price discount imageCover quantity',
            },
            {
                path: 'shop',
                select: 'name',
            },
        ],
        select: 'product quantity imageCover',
    });

    if (!cart) {
        return next(new AppError('No cart found with that ID', 404));
    }

    const formattedCart = [];
    const shopMap = new Map();

    for (const item of cart.cartItems) {
        const shopId = item.shop._id.toString();

        if (!shopMap.has(shopId)) {
            const shopObj = {
                shop: {
                    name: item.shop.name,
                    products: [
                        {
                            cartItemId: item._id,
                            productId: item.product._id,
                            name: item.product.name,
                            description: item.product.description,
                            price: item.product.price,
                            discount: item.product.discount,
                            quantity: item.quantity,
                            stock: item.product.quantity,
                            imageCover: `https://getgoods.blob.core.windows.net/product-photos/${item.product.imageCover}`,
                        },
                    ],
                },
            };
            formattedCart.push(shopObj);
            shopMap.set(shopId, shopObj);
        } else {
            const shopObj = shopMap.get(shopId);
            shopObj.shop.products.push({
                cartItemId: item._id,
                productId: item.product._id,
                name: item.product.name,
                description: item.product.description,
                price: item.product.price,
                discount: item.product.discount,
                quantity: item.quantity,
                stock: item.product.quantity,
                imageCover: `https://getgoods.blob.core.windows.net/product-photos/${item.product.imageCover}`,
            });
        }
    }
    const totalItems = formattedCart.reduce((acc, curr) => {
        return acc + curr.shop.products.length;
    }, 0);

    res.status(200).json({
        status: 'success',
        data: {
            cart: formattedCart,
            totalItems,
        },
    });
});
