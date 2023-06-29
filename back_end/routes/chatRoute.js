const express = require('express');
const router = express.Router({ mergeParams: true });
const chatController = require('../controllers/chatController');
const authController = require('../controllers/authController');

// router.get('/', getChatList);

// router.get('/:chatId', chatController.getMessage);


router.route('/chatList').get(
    authController.protect,
    chatController.getChatList,
    );
    
router.route('/:chatId').get(authController.protect,chatController.getMessage);

// router.route('/getChatId').get(authController.protect,chatController.getChatID);

router.route('/createChat').post(
    authController.protect,chatController.createChatRoom);

// router.get('/createChat', chatController.createChatRoom);

module.exports = router;