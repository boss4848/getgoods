import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/models/user_model.dart';
import 'package:getgoods/src/viewmodels/chat_viewmodel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants/constants.dart';
import 'chat_room.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late ChatViewModel chatViewModel = ChatViewModel();
  List<dynamic>? chatList;

  @override
  void initState() {
    super.initState();
    chatViewModel = ChatViewModel();
  }

  getChatList() async {
    // await chatViewModel.fetchChatList().then((value){
    //   setState(() {
    //     chatList = value;
    //   });
    // });
    try {
    Response response = await Dio().get(
      '${ApiConstants.baseUrl}/chats/',
      // Replace ':id' with the actual chat room ID you want to retrieve messages for
    );

    if (response.statusCode == 200) {
      // Chat messages retrieved successfully
      chatList = response.data;
      print(chatList);
    } else {
      // Error occurred while retrieving chat messages
      // Handle the error based on the response status code
      print("error");
    }
  } catch (e) {
    // Error occurred while making the request
    // Handle the network or other errors
    print('Error getting chat messages: $e');
  }
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
            //Gift ja 
            children: List.generate(
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
        ),
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
            builder: (context) => const ChatRoom(userName: "649020872f417fdf203f6ba9", chatId: "6498098b7321325eb8eb10f5",),
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
