/*
Ramin Selseleh

Substask: MA-150

The point of this task was to fix the icon image and the fuinctionality of the back button.
Now, the button is visible and functional. Now when clicked, it will navigate back to previous page.

 */

import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../backend/firebase_storage/database.dart';

import 'confirm_new_username_model.dart';
export 'confirm_new_username_model.dart';

class ConfirmNewUsernameWidget extends StatefulWidget {
  const ConfirmNewUsernameWidget({super.key});

  @override
  State<ConfirmNewUsernameWidget> createState() =>
      _ConfirmNewUsernameWidgetState();
}

class _ConfirmNewUsernameWidgetState extends State<ConfirmNewUsernameWidget> {
  late ConfirmNewUsernameModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfirmNewUsernameModel());

    _model.usernameTextController ??= TextEditingController();
    _model.usernameFocusNode ??= FocusNode();


    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryText,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 12),
          child: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Align(
        alignment: AlignmentDirectional(0, -1),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 570,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                FlutterFlowTheme.of(context).primaryText,
                FlutterFlowTheme.of(context).primaryText
              ],
              stops: [0, 1],
              begin: AlignmentDirectional(0, -1),
              end: AlignmentDirectional(0, 1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This row exists for when the "app bar" is hidden on desktop, having a way back for the user can work well.
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.safePop();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Text(
                            'Back',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Text(
                  'Confirm New Username',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
                child: Text(
                  'Please confirm your new username by filling out the fields below',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _model.usernameTextController,
                    focusNode: _model.usernameFocusNode,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Inter',
                      color: Colors.white, // Change text color to white
                      letterSpacing: 0.0,
                    ),
                    decoration: InputDecoration(
                      labelText: 'New Username',
                      labelStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                        color: Colors.white, // Change label color to white
                      ),
                      hintText: 'Enter New Username',
                      hintStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                        color: Colors.white54, // Change hint color to a lighter white shade
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryText,
                      contentPadding: EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      final newUsername = _model.usernameTextController.text.trim();

                      if (newUsername.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Username is required!'),
                          ),
                        );
                        return;
                      }

                      // Update username in Firebase
                      final dbService = DatabaseService();
                      await dbService.updateUsername(newUsername);

                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Username updated successfully!'),
                        ),
                      );

                      // Navigate back to the previous page
                      context.pop();
                    },
                    text: 'Save Username',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      textStyle:
                      FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                      ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
