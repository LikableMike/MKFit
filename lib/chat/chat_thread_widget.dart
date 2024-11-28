import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:m_k_fit/backend/firebase_storage/database.dart';
import 'package:m_k_fit/chat/message_widget.dart';
import 'package:m_k_fit/flutter_flow/flutter_flow_icon_button.dart';
import 'package:m_k_fit/flutter_flow/flutter_flow_theme.dart';
import 'my_message_widget.dart';

class ChatThreadWidget extends StatefulWidget {
  final List<String> participants;

  const ChatThreadWidget({super.key, required this.participants});

  @override
  State<ChatThreadWidget> createState() => _ChatThreadWidgetState();
}

class _ChatThreadWidgetState extends State<ChatThreadWidget> {
  List<Map<String, dynamic>> chat = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchChat();
  }

  void fetchChat() async {
    final chatList = await DatabaseService().getChat(widget.participants);
    if (chatList != null) {
      setState(() {
        chat = chatList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 24),
              reverse: true,
              itemCount: chat.length,
              itemBuilder: (context, index) {
                final message = chat[index];
                final senderUid = message['sender'];
                final db = DatabaseService();
                final UID = "User UID";

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: senderUid == UID
                      ? MyMessageWidget(chatMessage: message)
                      : MessageWidget(chatMessage: message),
                );
              },
            ),
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    borderRadius: 60,
                    borderWidth: 1,
                    buttonSize: 40,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    icon: Icon(
                      Icons.add_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                          child: Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _textController,
                              autofocus: true,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.send,
                              decoration: InputDecoration(
                                hintText: 'Start typing here...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 56, 16),
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium,
                              maxLines: 12,
                              minLines: 1,
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter a message';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 6, 4),
                            child: FlutterFlowIconButton(
                                borderColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: 20,
                                borderWidth: 1,
                                buttonSize: 40,
                                fillColor: FlutterFlowTheme.of(context).accent1,
                                icon: Icon(
                                  Icons.send_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 20,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final text = _textController.text.trim();
                                    _textController.clear();

                                    final message = {
                                      'text': text,
                                      'timestamp': Timestamp.now(),
                                      'sender': 'User UID',
                                      'reciever': 'Admin UID',
                                      'chatId': '1'
                                    };
                                    setState(() {
                                      chat.insert(0, message);
                                    });
                                  }
                                }),
                          ),
                        ),
                      ],
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
