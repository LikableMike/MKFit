import 'dart:ffi';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'client_details_model.dart';
export 'client_details_model.dart';
import 'package:m_k_fit/backend/firebase_storage/database.dart';
import "/backend/firebase_storage/globals.dart" as globals;
import 'package:url_launcher/url_launcher.dart';


class ClientDetailsPageWidget extends StatefulWidget {
  const ClientDetailsPageWidget({super.key});

  @override
  State<ClientDetailsPageWidget> createState() =>
      _ClientDetailsPageWidgetState();
}

class _ClientDetailsPageWidgetState
    extends State<ClientDetailsPageWidget> {
  late ClientDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientDetailsPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryText,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 70.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 40.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: FutureBuilder<String>(
            future: DatabaseService().findClientName(globals.selectedClient),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle errors here
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Display the text once data is available
                return Text(
                  snapshot.data!,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Readex Pro',
                    color: Colors.white,
                    fontSize: 34,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                // Handle the case where there is no data
                return Text('No client name found');
              }
            },
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
              child: Padding(padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 0.0, 8.0),
                    child:
              Container(
                  child:
                  FutureBuilder<Map>(
                    future: DatabaseService().getClientDetails(globals.selectedClient),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show a loading spinner while waiting for data
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // Show error message if something went wrong
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        // Show a message if the list is empty
                        return Center(child: Text('No clients found.'));
                      }

                      // If data is loaded successfully, use it
                      var clientDetails = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User Details:",
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              letterSpacing: 0.0,
                              fontSize: 50,
                              fontWeight: FontWeight.bold
                            ),
                          textAlign: TextAlign.left,),
                          Text("Name: " + clientDetails["name"],

                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              letterSpacing: 0.0,
                              fontSize: 20
                            ),
                            textAlign: TextAlign.left,),
                          Text("Email: " + clientDetails["email"],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                letterSpacing: 0.0,
                                fontSize: 20
                            ),
                            textAlign: TextAlign.left,),
                          Text("Phone Number: " + clientDetails["phone"],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                letterSpacing: 0.0,
                                fontSize: 20
                            ),
                            textAlign: TextAlign.left,),
                          Text("Current Weight: " + clientDetails["weight"],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                letterSpacing: 0.0,
                                fontSize: 20
                            ),
                            textAlign: TextAlign.left,),
                          Text("Height: " + clientDetails["height"],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                letterSpacing: 0.0,
                                fontSize: 20
                            ),
                            textAlign: TextAlign.left,),
                          Text("Client Since: " + clientDetails["accountCreated"],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                fontFamily: 'Inter',
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                letterSpacing: 0.0,
                                fontSize: 20
                            ),
                            textAlign: TextAlign.left,),
                        ],
                      );

                    },
                  ),
              ),
      ),

          ),
        ),
      ),
    );
  }

}

class WorkoutSection extends StatelessWidget{
  const WorkoutSection({
    this.title = "Exercise Title",
    this.weight = -1,
    this.description = "Placeholder Description",
    this.sets = 2,
    this.reps = 4,
    this.url = "",
    this.docLink = "",
  });

  final String title;
  final double weight;
  final String description;
  final int sets;
  final int reps;
  final String url;
  final String docLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      decoration: BoxDecoration(
        color: Colors.black38,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.black12,
          width: 3.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(

            width: double.infinity,
            height: 80.0,
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 300.0,
                  height: 105.0,
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        15.0, 0.0, 0.0, 0.0),
                    child: Text(

                      title,
                      style: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context)
                            .primaryBackground,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: 65.0,
                    height: 90.0,
                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF86BD92),
                        width: 3.0,
                      ),
                    ),
                    child: Align(
                      alignment:
                      const AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        weight.toString() + " lb",
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context)
                              .primaryBackground,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 200.0,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 0.0, 15.0),
                        child: Text(
                          description,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Inter',
                            color: FlutterFlowTheme.of(context)
                                .primaryBackground,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                    )
                ),
                Container(
                    width: double.infinity,
                    height: 42.0,
                    decoration: const BoxDecoration(),
                    child: SetBubble(height: 40.0,width: 40.0,reps: reps,sets: sets)
                ),
                Container(
                  width: double.infinity,
                  height: 70.0,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if(url != "No Link Added")
                        Container(
                          width: 60.0,
                          height: 94.0,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 44.0,
                                icon: const Icon(
                                  Icons.ondemand_video_outlined,
                                  color: Color(0xFF86BD92),
                                  size: 35.0,
                                ),
                                onPressed: () async {
                                  print(url);
                                  final Uri URL = Uri.parse(url);
                                  if (!await launchUrl(URL)) {
                                    throw Exception('Could not launch $URL');
                                  }
                                },
                              ),
                              Text(
                                'Video',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Inter',
                                  color:
                                  FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if(docLink != "No Doc Link")
                        Container(
                          width: 54.0,
                          height: 94.0,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 44.0,
                                icon: const Icon(
                                  Icons.assignment_rounded,
                                  color: Color(0xFF86BD92),
                                  size: 35.0,
                                ),
                                onPressed: () async {
                                  print(docLink);
                                  final Uri DOC_URL = Uri.parse(docLink);
                                  if (!await launchUrl(DOC_URL)) {
                                    throw Exception(
                                        'Could not launch $DOC_URL');
                                  }
                                },
                              ),
                              Text(
                                'Details',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme
                                    .of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Inter',
                                  color:
                                  FlutterFlowTheme
                                      .of(context)
                                      .primaryBackground,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ],
                          ),
                        ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}


class SetBubble extends StatefulWidget {
  const SetBubble({
    this.height = 40.0,
    this.width = 40.0,
    this.reps = 2,
    this.sets = 2,
    super.key,
  });

  final double height;
  final double width;
  final int reps;
  final int sets;

  @override
  _SetBubbleState createState() => _SetBubbleState();
}

class _SetBubbleState extends State<SetBubble> {
  // Mutable fields moved to State
  late Color startfillColor;
  late Color completedfillColor;
  late Color currFillColor;

  @override
  void initState() {
    super.initState();
    // Initialize mutable fields
    startfillColor = Colors.transparent;
    completedfillColor = Color(0xFF86BD92);
    currFillColor = startfillColor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment:
          const AlignmentDirectional(-1.0, -1.0),
          child: Padding(
            padding:
            const EdgeInsetsDirectional.fromSTEB(
                5.0, 5.0, 0.0, 0.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment:
                    const AlignmentDirectional(
                        0.0, 0.0),
                    child: Text(
                      widget.sets.toString(),
                      textAlign: TextAlign.center,
                      style:
                      FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme
                            .of(context)
                            .secondaryBackground,
                        letterSpacing: 0.0,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment:
                    const AlignmentDirectional(
                        0.0, 0.0),
                    child: Text(
                      'Sets',
                      textAlign: TextAlign.center,
                      style:
                      FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                        fontFamily: 'Inter',
                        color: FlutterFlowTheme
                            .of(context)
                            .secondaryBackground,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: List.generate(widget.sets, (index) {
            return ColorChangingBubble(width: widget.width, height: widget.height, reps: widget.reps, startFillColor: startfillColor, completedFillColor: completedfillColor,);
          }),
        ),
      ],
    );

  }
}

class ColorChangingBubble extends StatefulWidget {
  final double width;
  final double height;
  final int reps;
  final Color startFillColor;
  final Color completedFillColor;

  const ColorChangingBubble({
    Key? key,
    this.width = 40.0,
    this.height = 40.0,
    this.reps = 2,
    this.startFillColor = const Color(0xFFFBF9F5),
    this.completedFillColor = const Color(0xFF86BD92),
  }) : super(key: key);

  @override
  _ColorChangingBubbleState createState() => _ColorChangingBubbleState();
}

class _ColorChangingBubbleState extends State<ColorChangingBubble> {
  late Color currFillColor;
  late int completedSets = 0;

  @override
  void initState() {
    super.initState();
    currFillColor = widget.startFillColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: currFillColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Color(0xFFFBF9F5),
          width: 2.0,
        ),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 0.0),
        child: TextButton(
          child: Text(
            widget.reps.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Color(0xFFFBF9F5),
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          onPressed: () {
            setState(() {
              // Toggle the fill color
              currFillColor = (currFillColor == widget.startFillColor)
                  ? widget.completedFillColor
                  : widget.startFillColor;


            });
            print("Pressed");
          },
        ),
      ),
    );
  }
}

class BuildWorkouts extends StatelessWidget {
  const BuildWorkouts({
    required this.Workouts,

  });

  final List Workouts;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(Workouts.length, (index) {
        return WorkoutSection(title: Workouts[index]["name"], weight: Workouts[index]["weight"], description: Workouts[index]["description"], sets: Workouts[index]["sets"], reps: Workouts[index]["reps"], url: Workouts[index]["video_sample"], docLink: Workouts[index].keys.contains("doc_link") ? Workouts[index]["doc_link"] : "No Document Link",);
      }),
    );
  }
}

