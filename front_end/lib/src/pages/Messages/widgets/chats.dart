import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/models/user_model.dart';
import 'package:getgoods/src/viewmodels/chat_viewmodel.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants/constants.dart';
import '../../../services/api_service.dart';
import 'chat_room.dart';

class Chats extends StatefulWidget {

  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late UserViewModel userViewModel;
  late ChatViewModel chatViewModel;
  late UserDetail userDetail;
  late String roomId;
  List<String>? list;

  @override
  void initState() {
    super.initState();
    chatViewModel = ChatViewModel();
    getChatList();
  }

  Future<void> getChatList() async {
    final response = await ApiService.request(
        'GET',
        '${ApiConstants.baseUrl}/chats/chatList',
        requiresAuth: true,
    );

    setState(() {
      
    });
    
  }

  _getUser() async {
    await userViewModel.fetchUser();
    setState(() {
      userDetail = userViewModel.userDetail;
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
          child: Column(
            children: 
              List.generate(
              5,
              (index) => _buildChatItem(
                context: context,
                avatar: 'https://i.pravatar.cc/150?img=$index',
                name: 'John Doe',
                message: 'Hello, how are you?',
                time: '12:00 PM',
              ),
            // ),
          ),
            
          )
      ),
    ));
  }

  GestureDetector _buildChatItem({
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
            builder: (context) => ChatRoom(chatId: '6499b11ef851f957787da579',),
            //builder: (context) => ChatRoom(userDetail: UserDetail(name: name)),
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
