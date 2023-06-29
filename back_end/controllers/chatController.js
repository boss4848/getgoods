const Chat = require("../models/chatModel");
const Message = require("../models/messageModel")
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");
const mongoose = require("mongoose");
const Shop = require("../models/shopModel");

exports.getChatList = catchAsync(async (req, res, next) => {
  const chat = await Chat.find({
    $or:[
      {'members.user': { $in: req.user.id } },
      {'members.shop': { $in: req.user.id } },
    ]});
    // console.log(chat[0].members[0].user.id);
    // const shop = await Shop.find({owner: chat[0].members[1].shop.id});
    //update chat with shop name


    const updatedChat = chat.map((item) => {
      console.log('members: ', item.members[1].shop._id);
      // console.log('members: ', item.members[1]._id);
      // const shop = Shop.findById(item.members[1].shop._id);
      //find by user id
      const shop = Shop.find({owner: item.members[1].shop.id.toString()});
      if(!shop){
        return next(new AppError("No shop found", 404));
      }
      console.log('shop: ', shop);
      
      // console.log('shop: ', shop);
      // const shop = Shop.find(item.members[1].shop.id);
      // console.log('shop: ', shop);
      // console.log('shop name: ', shop[0].name);
      // item.shopOwnerName = shop[0].name;
    });
    // console.log(shop);
    // let shop;
    // let i = 0
    // // console.log('chat: ', chat);
    // chat.map((item) => {
    //   // console.log(item.members[i].user);
    //   console.log(item.toString());
    //   item.members.map((item) => {
    //     console.log('user---: '+item);
    //   });
    //   // item.map((item) => {
    //   //   console.log(item.members[i].user);
    //   // });
    //   // shop = Shop.find({owner: item.members[i].user.id});
    //   // console.log(shop);
    //   // chat.shopOwnerName = shop.name;
    //   // chat.shopId = shop._id;
    //   i++;
    // });

    // if(!shop){
    //   res.status(200).json({
    //     status: "success",
    //     data: {
    //       chat: updatedChat,
    //       shopOwnerName: null,
    //       shopId: null,
    //     }
    //   });
    // }
    if(!chat){
      return next(new AppError("No chat room found", 404));
    }


  // if (!chat) {
  //   return next(new AppError("No chat room found", 404));
  // }

  res.status(200).json({
    status: "success",
    data: {
      chat,
      // shopOwnerName: shop[0].name,
      // shopId: shop[0]._id,
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
  const chat = await Chat.findOne({
    $and: [
      { 'members.user': { $in: userId } },
      { 'members.shop': { $in: ownerId } },
      { 'members': { $size: 2 } }
    ]
  });
  
  if(chat){
    return next(new AppError('You already have a chat', 400));
  }

  const newRoom = await Chat.create({
    members: [
      {user: userId},
      {shop: ownerId}
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

