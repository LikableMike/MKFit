import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/backend/firebase_storage/database.dart';
import 'update_exercise_model.dart';
export 'update_exercise_model.dart';
import "/backend/firebase_storage/globals.dart" as globals;


class UpdateExerciseWidget extends StatefulWidget {
  const UpdateExerciseWidget({super.key});


  @override
  State<UpdateExerciseWidget> createState() => _UpdateExerciseWidgetState();
}

class _UpdateExerciseWidgetState extends State<UpdateExerciseWidget> {
  late UpdateExerciseModel _model;
  Map totalExercise = {};
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateExerciseModel());

    _model.fullNameTextController ??= TextEditingController();
    _model.fullNameFocusNode ??= FocusNode();
    _model.DocLinkController ??= TextEditingController();
    _model.DocLinkFocusNode ??= FocusNode();
    _model.phoneNumberTextController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();
    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
    _model.videoLinkTextController ??= TextEditingController();
    _model.videoLinkFocusNode ??= FocusNode();
  }



  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryText,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Exercise',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Please fill out the form below to continue.',
                style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'Outfit',
                  color: const Color(0xFF606A85),
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ].divide(const SizedBox(height: 4.0)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 12.0, 8.0),
              child: FlutterFlowIconButton(
                borderColor: const Color(0xFFE5E7EB),
                borderRadius: 12.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                fillColor: Colors.white,
                icon: const Icon(
                  Icons.close_rounded,
                  color: Color(0xFF15161E),
                  size: 24.0,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, -1.0),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 770.0,
                            ),
                            decoration: const BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<Map>(
                                    future: DatabaseService().getExerciseData(globals.selectedExercise), // Replace with your async function
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text('Error: ${snapshot.error}'),
                                        );
                                      } else if (!snapshot.hasData || snapshot.data == null) {
                                        return const Center(
                                          child: Text('No data available'),
                                        );
                                      } else {
                                        final exerciseData = snapshot.data!;
                                        _model.fullNameTextController.text = exerciseData["name"];
                                        return TextFormField(

                                    controller: _model.fullNameTextController,

                                    focusNode: _model.fullNameFocusNode,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Excersise Name*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF606A85),
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF606A85),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Figtree',
                                        color: const Color(0xFFFF5963),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF6F61EF),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor:
                                      (_model.fullNameFocusNode?.hasFocus ??
                                          false)
                                          ? const Color(0x4D9489F5)
                                          : Colors.white,
                                      contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: const Color(0xFF15161E),
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLength: 30,
                                    maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                    buildCounter: (context,
                                        {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                    null,
                                    cursorColor: const Color(0xFF6F61EF),

                                  );
                              }
                            },
                            ),


                                  Text(
                                    'Brief Exercise Description',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: const Color(0xFF606A85),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                    FutureBuilder<Map>(
                                  future: DatabaseService().getExerciseData(globals.selectedExercise), // Replace with your async function
                                  builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(
                                  child: CircularProgressIndicator(),
                                  );
                                  } else if (snapshot.hasError) {
                                  return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                  );
                                  } else if (!snapshot.hasData || snapshot.data == null) {
                                  return const Center(
                                  child: Text('No data available'),
                                  );
                                  } else {

                                  final exerciseData = snapshot.data!;
                                  _model.descriptionTextController.text = exerciseData["description"];
                                  return TextFormField(
                                    controller: _model.descriptionTextController,
                                    focusNode: _model.descriptionFocusNode,

                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                      'Please describe the exercise...',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF606A85),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      alignLabelWithHint: true,
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF606A85),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Figtree',
                                        color: const Color(0xFFFF5963),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF6F61EF),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model.descriptionFocusNode
                                          ?.hasFocus ??
                                          false)
                                          ? const Color(0x4D9489F5)
                                          : Colors.white,
                                      contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 16.0, 16.0, 16.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Figtree',
                                      color: const Color(0xFF15161E),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 9,
                                    minLines: 5,
                                    cursorColor: const Color(0xFF6F61EF),

                                  );
                                  }
                                  }),
                                  Text(
                                    'Video link',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: const Color(0xFF606A85),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),


                            FutureBuilder<Map>(
                          future: DatabaseService().getExerciseData(globals.selectedExercise), // Replace with your async function
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(
                                child: Text('No data available'),
                              );
                            } else {
                              final exerciseData = snapshot.data!;
                              _model.videoLinkTextController.text = exerciseData["video_link"];
                              return TextFormField(
                                controller: _model.videoLinkTextController,
                                focusNode: _model.videoLinkFocusNode,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Video Link...',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: const Color(0xFF606A85),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: const Color(0xFF606A85),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  errorStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily: 'Figtree',
                                    color: const Color(0xFFFF5963),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE5E7EB),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF6F61EF),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  filled: true,
                                  fillColor: (_model.videoLinkFocusNode?.hasFocus ?? false)
                                      ? const Color(0x4D9489F5)
                                      : Colors.white,
                                  contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 20.0, 16.0, 20.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                  fontFamily: 'Figtree',
                                  color: const Color(0xFF15161E),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                cursorColor: const Color(0xFF6F61EF),

                              );
                            }
                          },
                          ),

                            Text(
                                    'PDF File',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: const Color(0xFF606A85),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _model.DocLinkController,
                                    focusNode: _model.DocLinkFocusNode,
                                    autofocus: true,

                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Document Link...',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF606A85),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        color: const Color(0xFF606A85),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Figtree',
                                        color: const Color(0xFFFF5963),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFE5E7EB),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF6F61EF),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model.DocLinkFocusNode
                                          ?.hasFocus ??
                                          false)
                                          ? const Color(0x4D9489F5)
                                          : Colors.white,
                                      contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Figtree',
                                      color: const Color(0xFF15161E),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    cursorColor: const Color(0xFF6F61EF),
                                    validator: _model
                                        .DocLinkControllerValidator
                                        .asValidator(context),
                                  ),
                                ]
                                    .divide(const SizedBox(height: 12.0))
                                    .addToEnd(const SizedBox(height: 32.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 770.0,
                  ),
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        try {
                          totalExercise = {
                            "name": _model.fullNameTextController.text.trim(),
                            "description": _model.descriptionTextController.text.trim(),
                            "video_link": _model.videoLinkTextController.text.trim(),
                            "doc_link" : _model.DocLinkController.text.trim(),
                          };
                          print("Attempting to update Exercise");
                          await DatabaseService().updateExerciseData(totalExercise, globals.selectedExercise);
                        }catch(e){
                          print(e);
                        }
                        if (_model.formKey.currentState == null ||
                            !_model.formKey.currentState!.validate()) {
                          return;
                        }
                      },
                      text: 'Update Exercise',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: const Color(0xFF87A88E),
                        textStyle:
                        FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Figtree',
                          color: const Color(0xFF364233),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
