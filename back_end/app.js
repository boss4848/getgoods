const express = require('express');
const app = express();
const chalk = require('chalk');

app.use(express.json());

//Middleware
//Log request method, url, and time
app.use((req, res, next) => {
    console.log(` ${chalk.yellowBright("|")} ${chalk.blue.bold(req.method)} ${req.url} - ${chalk.yellowBright(new Date().toLocaleTimeString())}`);
    next();
});


//Routes
app.use('/api/v1/products', require('./routes/productRoute'));

//Handle undefined routes
app.all('*', (req, res, next) => {
    console.log(` ${chalk.yellowBright("|")} ${chalk.red.bold(req.method)} ${req.url} - ${chalk.yellowBright(new Date().toLocaleTimeString())}`);
    res.status(404).json({
        status: 'fail',
        message: `Can't find ${req.originalUrl} on this server!`
    });
});
module.exports = app;