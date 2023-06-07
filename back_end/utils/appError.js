class AppError extends Error {
    constructor(message, statusCode) {
        super(message);
        this.statusCode = statusCode;
        this.status = `${statusCode}`.startsWith('4') ? 'fail' : 'error';
        this.isOperational = true; // this property is used to determine if the error is operational or programming error

        Error.captureStackTrace(this, this.constructor);
    }
}

module.exports = AppError;