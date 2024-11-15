import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'workout_plan_page_model.dart';
export 'workout_plan_page_model.dart';
import "/backend/firebase_storage/globals.dart" as globals;

class WorkoutPlanPageWidget extends StatefulWidget {
  const WorkoutPlanPageWidget({super.key});

  @override
  State<WorkoutPlanPageWidget> createState() => _WorkoutPlanPageWidgetState();
}

class _WorkoutPlanPageWidgetState extends State<WorkoutPlanPageWidget>
    with TickerProviderStateMixin {
  late WorkoutPlanPageModel _model;
  late Map userWorkouts;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WorkoutPlanPageModel());

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
          title: Text(
            'Your Workout Plan',
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
                  'Your Workouts',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Outfit',
                        color: const Color(0xFF606A85),
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
              ),
              Expanded(child: BuildWorkouts(Workouts: globals.userWorkouts, animationMap: animationsMap))
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({
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
       height: 150.0,
       decoration: BoxDecoration(
         color: const Color(0xFF86BD92),
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
           color: const Color(0xFF86BD92),
           width: 2.0,
         ),
       ),
       child: Stack(
         children: [
           Align(
             alignment: const AlignmentDirectional(0.0, 0.0),
             child: ClipRRect(
               borderRadius: BorderRadius.circular(12.0),
               child: Image.network(
                 'https://images.unsplash.com/photo-1544717684-1243da23b545?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyNHx8d29ya291dHxlbnwwfHx8fDE3MDY2NjA2NzR8MA&ixlib=rb-4.0.3&q=80&w=1080',
                 width: double.infinity,
                 height: double.infinity,
                 fit: BoxFit.cover,
               ),
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
                   Text(
                     name,
                     style: FlutterFlowTheme.of(context)
                         .titleLarge
                         .override(
                       fontFamily: 'Outfit',
                       color: const Color(0xFF15161E),
                       fontSize: 22.0,
                       letterSpacing: 0.0,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   RichText(
                     textScaler:
                     MediaQuery.of(context).textScaler,
                     text: TextSpan(
                       children: const [
                         TextSpan(
                           text: '8 Mins',
                           style: TextStyle(),
                         ),
                         TextSpan(
                           text: ' || ',
                           style: TextStyle(),
                         ),
                         TextSpan(
                           text: '3 workouts',
                           style: TextStyle(),
                         )
                       ],
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
                   ),
                 ].divide(const SizedBox(height: 4.0)),
               ),
             ),
           ),
           FFButtonWidget(
             onPressed: () {
               print(name);
               globals.selectedWorkout = name;
               context.pushNamed('IndividualWorkoutPage');
             },
             text: '',
             options: FFButtonOptions(
               width: double.infinity,
               height: 148.0,
               padding: const EdgeInsetsDirectional.fromSTEB(
                   24.0, 0.0, 24.0, 0.0),
               iconPadding: const EdgeInsetsDirectional.fromSTEB(
                   0.0, 0.0, 0.0, 0.0),
               color: Colors.transparent,
               textStyle: FlutterFlowTheme.of(context)
                   .titleSmall
                   .override(
                 fontFamily: 'Inter',
                 color: Colors.white,
                 letterSpacing: 0.0,
               ),
               elevation: 3.0,
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

class BuildWorkouts extends StatelessWidget {
  const BuildWorkouts({
    required this.Workouts,
    required this.animationMap,

  });

  final List Workouts;
  final animationMap;

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.fromLTRB(
          0,
          0,
          0,
          44.0,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(Workouts.length, (index) {
        return WorkoutWidget(animationMaps: animationMap, name: Workouts[index]);
      }),
    );
  }
}

