import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/models/chat_message_model.dart';
import 'package:getgoods/src/models/user_model.dart';
import 'package:getgoods/src/pages/Messages/widgets/chats.dart';
import 'package:getgoods/src/viewmodels/user_viewmodel.dart';
import 'package:getgoods/src/viewmodels/chat_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../constants/constants.dart';
import '../../../services/api_service.dart';

class ChatRoom extends StatefulWidget {
  final String chatId;
  final String chatName;
  const ChatRoom({Key? key, required this.chatId, required this.chatName}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  late UserViewModel userViewModel;
  late User user;
  late String? userId = "";
  List<ChatMessage> messages = [];
  bool _isEmpty = false;
  late IO.Socket _socket;
  

  void _connectSocket() {
    
    _socket.onConnect((data) {
      print('Connection established');
    });

    _socket.onConnectError((data) {
      print('Connection Error: $data');
    });

    _socket.onDisconnect((data) {
      print('Socket.IO server disconnect');
    });

    _socket.on('chat message', (data) {
      setState(() {
        messages.add(
          ChatMessage(
            message: data['message'],
            sender: data['sender'],
            chatId: data['chatId'],
            createdAt: data['timestamp'],
          ),
        );
      });
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _getMessage() async{
    final response = await ApiService.request(
        'GET',
        '${ApiConstants.baseUrl}/chats/${widget.chatId}',
        requiresAuth: true,
    );

    final Map<String, dynamic> data = response['data'];
    final List<dynamic> messageData = data['message'];
    messages = messageData.map((e) => ChatMessage.fromJson(e)).toList();
    
  }

  Future<void> _getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  Future<bool?> _checkSender(int index) async{
    if(userId == messages[index].sender){
        return true;
    }
    else{
      return false;
    }
    
  }

  @override
  void initState() {
    super.initState();
    _getMessage();
    // If testing app on Android then replace http://localhost:8000 with http://10.0.2.2:8000
    //platform.isIOS
    _socket = IO.io(
      "http://localhost:8000",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'userName': userId ,'chatId' : widget.chatId})
          .build(),
    );

    _socket.connect();

    _socket.on('chat message', (data) {
      setState(() {
        messages.add(
          ChatMessage(
            message: data['message'],
            sender: data['sender'],
            chatId: data['chatId'],
            createdAt: data['timestamp'],
          ),
        );
      });
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // _socket.onConnectError((data) {
    //   print('Connection Error: $data');
    // });

    // _socket.onDisconnect((data) {
    //   print('Socket.IO server disconnect');
    // });

    _getUserId();

  }

  @override
  void dispose() {
    _scrollController.dispose();
    _socket.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    var timestamp = DateTime.now().toString().substring(10, 16);
    _socket.emit('chat message', {
      'message': text,
      'sender': userId,
      'chatId' : widget.chatId,
      'timestamp': timestamp,
    });

    setState(() {
      _isEmpty = false;
      // messages.add(
      //   ChatMessage(
      //     message: text,
      //     sender: widget.userName,
      //     chatId: widget.chatId,
      //     timestamp: timestamp,
      //   ),
      // );
      _controller.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/150?img=1",
                  ),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        //user name
                        widget.chatName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        // "Online",
                        userId!,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            color: Colors.green[100],
            child: ListView.builder(
              itemCount: messages.length + 1,
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 10, bottom: 100),
              itemBuilder: (context, index) {
                //number of text message
                //print(messages.length);
                //last message
                if (index == messages.length) {
                  return Container(
                    height: 100,
                  );
                }
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left:
                            messages[index].sender != userId ? 0 : 50,
                        right:
                            messages[index].sender != userId ? 50 : 0,
                      ),
                      padding: const EdgeInsets.only(
                        left: 14,
                        right: 14,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Align(
                        alignment: messages[index].sender != userId
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: messages[index].sender != userId
                                ? Colors.grey.shade200
                                : Colors.green[200],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages[index].message,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 14),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        messages[index].createdAt.toString().substring(10, 16),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                  width: 2,
                ),
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 10,
              top: 10,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _controller,
                      onSubmitted: _handleSubmitted,
                      onChanged: (String text) {
                        setState(() {
                          _isEmpty = text.length > 0;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.green.shade50,
                        hintText: "Write message...",
                        hintStyle: const TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: FloatingActionButton(
                      onPressed: _isEmpty
                          ? () => _handleSubmitted(_controller.text)
                          : null,
                      backgroundColor: Colors.lightGreen,
                      elevation: 0,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
