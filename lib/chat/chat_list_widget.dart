import 'package:flutter/material.dart';
import 'package:m_k_fit/backend/firebase_storage/database.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'chat_widget.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({super.key});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  String? UID;

  @override
  void initState() {
    super.initState();
    getUID();
  }

  Future<void> getUID() async {
    UID = await DatabaseService().getUID();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: DatabaseService().getChatStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final chats = snapshot.data!;
                if (chats.isEmpty) {
                  return Center(
                    child: Text(
                      'None',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 24),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final participants = chat['participants'];
                    String participant = "None";
                    for (String p in participants) {
                      if (p != UID) {
                        participant = p;
                        break;
                      }
                    }

                    return ChatWidget(participant: participant);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
