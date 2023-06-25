const express = require('express');
const transactionController = require('../controllers/transactionController');
const router = express.Router();
const authController = require('../controllers/authController');

router.post('/',
    authController.protect,
    transactionController.createTransaction,
);
router.get('/test',
    transactionController.test,
);

router.patch('/:id',
    authController.protect,
    transactionController.updateTransaction,
);

router.get('/:id',
    authController.protect,
    transactionController.getTransaction,
);

router.patch('/updateCharge/:id',
    authController.protect,
    transactionController.updateCharge,
);
router.patch('/cancel/:id',
    authController.protect,
    transactionController.updateCharge,
);


module.exports = router;