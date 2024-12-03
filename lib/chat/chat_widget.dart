import 'package:flutter/material.dart';
import 'package:m_k_fit/backend/firebase_storage/database.dart';
import 'package:m_k_fit/chat/chat_thread_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class ChatWidget extends StatefulWidget {
  final String participant;

  const ChatWidget({Key? key, required this.participant}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  String participantName = '--';

  @override
  void initState() {
    super.initState();
    getParticipantName();
  }

  Future<void> getParticipantName() async {
    try {
      final name = await DatabaseService().getName(widget.participant);
      setState(() {
        participantName = name;
      });
    } catch (e) {
      setState(() {
        participantName = '--';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatThreadWidget(
              participants: [
                widget.participant,
                'eYJLyiWEaVhwAtW3J0ZsPhg2mmc2',
              ],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                participantName.isNotEmpty ? participantName[0] : '?',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    participantName,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '--',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
