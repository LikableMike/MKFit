import 'package:m_k_fit/backend/firebase_storage/database.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'admin_client_list_model.dart';
export 'admin_client_list_model.dart';
import "/backend/firebase_storage/globals.dart" as globals;

class AdminClientListWidget extends StatefulWidget {
  const AdminClientListWidget({super.key});

  @override
  State<AdminClientListWidget> createState() => _AdminClientListWidgetState();
}

class _AdminClientListWidgetState extends State<AdminClientListWidget>
    with TickerProviderStateMixin {
  late AdminClientListModel _model;
  late Map userWorkouts;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminClientListModel());

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0.0, 40.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0, 1.396),
            end: const Offset(0, 0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0.0, 40.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 250.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0, 1.396),
            end: const Offset(0, 0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 250.0.ms,
            duration: 300.0.ms,
            begin: const Offset(0.0, 40.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    List clientList = [];
    DatabaseService().getClients().then((names){
      clientList = names;
    });

    print(clientList.toString());
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
          title: Text(
            'All Clients',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: FlutterFlowTheme.of(context).primaryBackground,
              fontSize: 30.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 0.0, 8.0),
                child: Text(
                  'All Clients',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Outfit',
                    color: const Color(0xFF606A85),
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
                ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
              ),Expanded(
                child: FutureBuilder<List>(
                  future: DatabaseService().getClients(),
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
                    List clientList = snapshot.data!;
                    return BuildClientList(Clients: clientList, animationMap: animationsMap);
                  },
                ),
              ),
              //BuildClientList(Clients: clientList, animationMap: animationsMap)
            ],
          ),
        ),
      ),
    );
  }
}

class ClientWidget extends StatelessWidget {
  const ClientWidget({
    required this.animationMaps,
    required this.name,
    super.key,
  });

  final String name;
  final animationMaps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: Container(
        width: 100.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: const Color(0xFF00831B),
          boxShadow: const [
            BoxShadow(
              blurRadius: 3.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                1.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: const Color(0xFF00831B),
            width: 2.0,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: ColoredBox(color: Colors.transparent)
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0x9AFFFFFF),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String>(
                      future: DatabaseService().findClientName(name),
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
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                              fontFamily: 'Outfit',
                              color: const Color(0xFF15161E),
                              fontSize: 22.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        } else {
                          // Handle the case where there is no data
                          return Text('No client name found');
                        }
                      },
                    )
                  ].divide(const SizedBox(height: 4.0)),
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                globals.selectedClient = name;
                context.pushNamed('ClientInfoPage');

              },
              text: '',
              options: FFButtonOptions(
                width: double.infinity,
                height: 60.0,
                padding: const EdgeInsetsDirectional.fromSTEB(
                    24.0, 0.0, 24.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                    0.0, 0.0, 0.0, 0.0),
                color: Colors.transparent,
                textStyle: FlutterFlowTheme.of(context)
                    .titleSmall
                    .override(
                  fontFamily: 'Inter',
                  color: Colors.transparent,
                  letterSpacing: 0.0,
                ),
                elevation: 0.0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ).animateOnPageLoad(
          animationMaps['containerOnPageLoadAnimation1']!),
    );
  }
}

class BuildClientList extends StatelessWidget {
  const BuildClientList({
    required this.Clients,
    required this.animationMap,

  });

  final List Clients;
  final animationMap;

  @override
  Widget build(BuildContext context) {
    print(Clients.length);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        44.0,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List.generate(Clients.length, (index) {
        return ClientWidget(animationMaps: animationMap, name: Clients[index]);
      }),
    );
  }
}

