import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/models/user_model.dart';
import 'package:getgoods/src/viewmodels/chat_viewmodel.dart';
import 'package:getgoods/src/viewmodels/shop_viewmodel.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants/constants.dart';
import '../../../models/chat_room_model.dart';
import '../../../services/api_service.dart';
import 'chat_room.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late ShopViewModel shopViewModel;
  List<ChatList> chatLists = [];
  late String roomId;
  late String? userId = "";

  @override
  initState() {
    super.initState();
    _getUserId();
    shopViewModel = ShopViewModel();
    getChatList();
  }

  Future<void> _getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  String _getShopName(int index) {
    shopViewModel.fetchShop(chatLists[index].shopId);
    return shopViewModel.shop.name;
  }

  bool isShopCurrentUser(int index) {
    if(chatLists[index].userId == userId) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> getChatList() async {
    final response = await ApiService.request(
      'GET',
      '${ApiConstants.baseUrl}/chats/chatList',
      requiresAuth: true,
    );

    final Map<String, dynamic> data = response['data'];

    final List<dynamic> chatListData = data['chat'];
    print('data111: ${chatListData.toString()}}');
    setState(() {
      chatLists = chatListData.map((e) => ChatList.fromJson(e)).toList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryBGColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 62,
            left: 12,
            right: 12,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: chatLists.length,
            itemBuilder: (context, index) {
              return _buildChatItem(
                index: index,
                avatar: !isShopCurrentUser(index) ? 'https://getgoods.blob.core.windows.net/user-photos/${chatLists[index].shopPhoto}' : 'https://getgoods.blob.core.windows.net/user-photos/${chatLists[index].userPhoto}',
                name: isShopCurrentUser(index) ? chatLists[index].userName : chatLists[index].shopId,
                message: 'Hello, how are you?',
                time: '12:00 PM',
                context: context,
              );
            },
          ),
        ),
      ),
    );
  }

  GestureDetector _buildChatItem({
    required int index,
    required String avatar,
    required String name,
    required String message,
    required String time,
    context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoom(
              chatId: chatLists[index].chatId,
              chatName: isShopCurrentUser(index) ? chatLists[index].userName : chatLists[index].shopId,
              avatar : !isShopCurrentUser(index) ? 'https://getgoods.blob.core.windows.net/user-photos/${chatLists[index].shopPhoto}' : 'https://getgoods.blob.core.windows.net/user-photos/${chatLists[index].userPhoto}',
              isShop: !isShopCurrentUser(index),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.5,
              spreadRadius: 0.5,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                avatar,
              ),
              radius: 30,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              time,
              style: const TextStyle(
                color: secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
