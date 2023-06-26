const express = require('express');
const router = express.Router({ mergeParams: true });
const chatController = require('../controllers/chatController');
const authController = require('../controllers/authController');

// router.get('/', getChatList);

// router.get('/:chatId', chatController.getMessage);

router.route('/:chatId').get(chatController.getMessage);

router.route('/:chatId/chatList').get(chatController.getChatList);

router.route('/createChat').post(chatController.createChatRoom);

// router.get('/createChat', chatController.createChatRoom);

module.exports = router;