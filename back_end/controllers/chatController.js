const Chat = require("../models/chatModel");
const Message = require("../models/messageModel")
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");
const mongoose = require("mongoose");
const ObjectId = require('mongoose').Types.ObjectId;

exports.getChatList = catchAsync(async (req, res, next) => {
  const chat = await Chat.findById(req.params._id);

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
  const message = await Message.findById(req.params.chatId).populate("message");

  res.status(200).json({
    status: "success",
    data: {
      message,
    },
  });
});

exports.createChatRoom = catchAsync(async (req, res, next) => {
  const newRoom = await Chat.create(req.body);

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

