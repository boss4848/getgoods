import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'widgets/chats.dart';
import 'widgets/notifications.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

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
              const TabBarView(
                children: [
                  Chats(),
                  Notifications(),
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
