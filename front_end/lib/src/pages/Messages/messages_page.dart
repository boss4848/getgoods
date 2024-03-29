import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import '../../constants/constants.dart';
import '../../models/chat_room_model.dart';
import '../../services/api_service.dart';
import 'widgets/chats.dart';
import 'widgets/notifications.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.5,
              spreadRadius: 0.5,
            )
          ],
        ),
        child: SafeArea(
          child: Stack(
            children: [
               TabBarView(
                children: [
                  Chats(),
                  const Notifications(),
                ],
              ),
              Container(
                color: Colors.white,
                child: const TabBar(
                  indicatorColor: primaryColor,
                  unselectedLabelColor: secondaryTextColor,
                  labelColor: primaryColor,
                  tabs: [
                    Tab(
                      text: "Chats",
                    ),
                    Tab(
                      text: "Notifications",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
