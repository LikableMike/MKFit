/*
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'message_page_model.dart';

class MessagePageWidget extends StatefulWidget {
  const MessagePageWidget({super.key});

  @override
  State<MessagePageWidget> createState() => _MessagePageWidgetState();
}

class _MessagePageWidgetState extends State<MessagePageWidget> {
  late final MessagePageModel _model;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessagePageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
        appBar: _buildAppBar(context),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 8.0),
                _buildMessageCard(context),
                const Divider(
                    height: 1.0, thickness: 1.0, color: Color(0xFF103E0C)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: FlutterFlowTheme.of(context).primaryText,
      automaticallyImplyLeading: false,
      leading: FlutterFlowIconButton(
        borderColor: Colors.transparent,
        borderRadius: 30.0,
        buttonSize: 70.0,
        icon: const Icon(Icons.arrow_back_rounded,
            color: Colors.white, size: 40.0),
        onPressed: () async {
          context.pop();
        },
      ),
      title: Text(
        'My Messages',
        style: FlutterFlowTheme.of(context).headlineLarge.override(
              fontFamily: 'Readex Pro',
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
      ),
      centerTitle: false,
      elevation: 2.0,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      'Message with trainer',
      style: FlutterFlowTheme.of(context).labelMedium.override(
            fontFamily: 'Inter',
          ),
    );
  }

  Widget _buildMessageCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryText,
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserAvatar(),
              const SizedBox(width: 8.0),
              _buildMessageContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 44.0,
      height: 44.0,
      decoration: BoxDecoration(
        color: const Color(0xFF103E0C),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF2B901B), width: 2.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: Image.network(
          'https://source.unsplash.com/random/1280x720?user&2',
          width: 44.0,
          height: 44.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MK FIT',
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Are you free this Friday for a workout session?',
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'Inter',
                ),
          ),
          const SizedBox(height: 4.0),
          _buildMessageFooter(context),
        ],
      ),
    );
  }

  Widget _buildMessageFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Mon. July 3rd - 4:12pm',
          style: FlutterFlowTheme.of(context).labelSmall.override(
                fontFamily: 'Inter',
              ),
        ),
        Icon(
          Icons.chevron_right_rounded,
          color: FlutterFlowTheme.of(context).secondaryText,
          size: 24.0,
        ),
      ],
    );
  }
}
*/