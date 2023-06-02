const express = require('express');
const app = express();
const chalk = require('chalk');
const morgan = require('morgan');


app.use(express.json());

//Middleware
//Log request method, url, and time
app.use((req, res, next) => {
    console.log(` ${chalk.yellowBright("|")} ${chalk.blue.bold(req.method)} ${req.url} - ${chalk.yellowBright(new Date().toLocaleTimeString())}`);
    next();
});


//Routes
app.use('/api/v1/products', require('./routes/productRoute'));

module.exports = app;