const chalk = require('chalk');
const logDataOperation = (req, res, next) => {
    const lineLength = process.stdout.columns;
    const line = '-'.repeat(lineLength);
    // Save the original response JSON method
    const originalJson = res.json;

    // Override the response JSON method to log the result
    res.json = function (data) {
        // Log the result of the data operation  
        console.log(chalk.yellowBright(line));
        console.log(chalk.yellowBright('Data Operation Result:'), data);
        console.log(chalk.yellowBright(line));

        // Call the original response JSON method
        originalJson.call(this, data);
    };

    // Continue to the next middleware or route handler
    next();
};

module.exports = logDataOperation;
