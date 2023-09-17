import 'package:flutter/material.dart';
import '../../../core/utils/functions/size_config.dart';
import '../../group/view/group_screen.dart';

import '../../chats/view/chats_screen.dart';

class GroupChatTabsScreen extends StatelessWidget {
  const GroupChatTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(
                child: Text(
                  "Chat",
                  style: TextStyle(fontSize: getFont(25)),
                ),
              ),
              Tab(
                  child: Text(
                "Group",
                style: TextStyle(fontSize: getFont(25)),
              ))
            ]),
            const Expanded(
              child: TabBarView(children: [ChatScreen(), GroupScreen()]),
            ),
          ],
        ),
      ),
    );
  }
}
