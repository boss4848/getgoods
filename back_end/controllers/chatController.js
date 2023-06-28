const Chat = require("../models/chatModel");
const Message = require("../models/messageModel")
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");
const mongoose = require("mongoose");

exports.getChatList = catchAsync(async (req, res, next) => {
  const chat = await Chat.find({ members: { $in: req.user.id } })

  if (!chat) {
    return next(new AppError("No chat room found", 404));
  }

  res.status(200).json({
    status: "success",
    data: {
      chat,
    },
  });
});

exports.getMessage = catchAsync(async (req, res, next) => {
  const message = await Message.find({ chatId : { $in: req.params.chatId } });

  res.status(200).json({
    status: "success",
    data: {
      message,
    },
  });
});

exports.createChatRoom = catchAsync(async (req, res, next) => {
  const ownerId = req.body.ownerId
  const userId = req.user.id
  // const chat = await Chat.find({ members: { $in: [ownerId, userId] } })
  const chat = await Chat.findOne({
    $and: [
      { members: { $all: [ownerId, userId] } },
      { members: { $size: 2 } },
      { ownerId: { $ne: userId } }
    ]
  });
  
  if(chat){
    return next(new AppError('You already have a chat', 400));
  }

  const newRoom = await Chat.create({
    members: [
      ownerId,
      userId
    ]
  });
  res.status(201).json({
    status: 'success',
    data: {
        data: newRoom
    }
});
  
})

exports.deleteChatRoom = catchAsync(async (req, res, next) => {
  const chatId = req.params.id;

  const deletedChat = await Chat.findByIdAndDelete(chatId);

  if (!deletedChat) {
    return next(new AppError("No chat room found", 404));
  }

  await Message.deleteMany({ chatId: chatId });

  res.status(200).json({
    status: "success",
    data: {
      message: "Chat room deleted successfully",
    },
  });
});

