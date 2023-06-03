const AppError = require('../utils/appError');
const handleCastErrorDB = err => {
    const message = `Invalid ${err.path}: ${err.value}.`;
    return new AppError(message, 400);
}

const sendErrorDev = (err, res) => {
    res.status(err.statusCode).json({
        status: err.status,
        message: err.message,
        stack: err.stack //stack trace
    });
}
const sendErrorProd = (err, res) => {
    //Operational, trusted error: send message to client
    if (err.isOperational) {
        res.status(err.statusCode).json({
            status: err.status,
            message: err.message
        });
    }
    //Programming or other unknown error: don't leak error details
    else {
        //1) Log error
        console.error('ERROR', err);

        //2) Send generic message
        res.status(500).json({
            status: 'error',
            message: 'Something went wrong!'
        });
    }
}
module.exports = (err, req, res, next) => {
    err.statusCode = err.statusCode || 500;//500 is internal server error
    err.status = err.status || 'error';

    if (process.env.NODE_ENV === 'development') {
        sendErrorDev(err, res);
    } else if (process.env.NODE_ENV === 'production') {
        let error = { ...err }; //create a copy of err object
        if (err.name === 'CastError') error = handleCastErrorDB(err);

        sendErrorProd(error, res);
    }
}