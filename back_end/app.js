const express = require('express');
const app = express();
const chalk = require('chalk');
const AppError = require('./utils/appError');
const globalErrorHandler = require('./controllers/errorController');
const cors = require('cors');
const logDataOperation = require('./middlewares/logDataOperation');

app.use(express.json());
// Enable CORS
app.use(cors());

//Middleware
//Log request method, url, and time
app.use((req, res, next) => {
    console.log(` ${chalk.yellowBright("|")} ${chalk.blue.bold(req.method)} ${req.url} - ${chalk.yellowBright(new Date().toLocaleTimeString())}`);
    next();
});

// Register the logDataOperation middleware
app.use(logDataOperation);

//Routes
app.use('/api/v1/users', require('./routes/userRoute'));
app.use('/api/v1/shops', require('./routes/shopRoute'));
app.use('/api/v1/products', require('./routes/productRoute'));
app.use('/api/v1/reviews', require('./routes/reviewRoute'));
app.use('/api/v1/payments', require('./routes/paymentRoute'));

//Handle undefined routes
app.all('*', (req, res, next) => {
    next(new AppError(`Can't find ${req.originalUrl} on this server!`, 404));
});

//Error handling middleware
app.use(globalErrorHandler);

module.exports = app;