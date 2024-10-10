/*
Ramin Selseleh

Subtask: 139

Fixed the overflow issue widget within the home page.
 */



/*
Ramin Selseleh

Substask: Ma-140

The goal for this task was
the visit your progress” button should redirect to the progress page.
Same page as the “Graph Lines” button in the nave bar.
 */


import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'home2_model.dart';
export 'home2_model.dart';

class Home2Widget extends StatefulWidget {
  const Home2Widget({super.key});

  @override
  State<Home2Widget> createState() => _Home2WidgetState();
}

class _Home2WidgetState extends State<Home2Widget> {
  late Home2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Home2Model());

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
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning, Champ!',
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      letterSpacing: 0.0,
                    ),
                  ),
                  Text(
                    'Time to rise and grind',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Readex Pro',
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      letterSpacing: 0.0,
                    ),
                  ),
                  Divider(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ].divide(SizedBox(height: 4)),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                  ),
                ),
                child: FlutterFlowIconButton(
                  borderRadius: 20,
                  borderWidth: 1,
                  buttonSize: 40,
                  icon: FaIcon(
                    FontAwesomeIcons.userCircle,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    size: 30,
                  ),
                  onPressed: () async {
                    context.pushNamed('SettingsPage');
                  },
                ),
              ),
            ),
          ],
          centerTitle: false,
          toolbarHeight: 72,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(
                          0,
                          2,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Color(0xFF00831B),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://picsum.photos/seed/634/600',
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 5,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 164,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(
                          0,
                          2,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 5, 4, 0),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00831B),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: FlutterFlowIconButton(
                                    borderColor: Color(0xFF40DC28),
                                    borderRadius: 40,
                                    borderWidth: 4,
                                    buttonSize: 25,
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 60,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ),
                              ),
                              Expanded( // << Replace Container with Expanded to make the layout adaptive
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(),
                                  child: Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Text(
                                      'Next Appointment: \nApril 1st, at 1:00 PM',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        fontSize: 25,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed('makeAppointment');
                            },
                            text: 'Schedule/Cancel Appointment',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Color(0xFF00831B),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 5,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Container(
                            width: 300,
                            height: 23,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'Todays Progress',
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(-5, 0),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Container(
                                      width: 110,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: CircularPercentIndicator(
                                          percent: 0.5,
                                          radius: 50,
                                          lineWidth: 12,
                                          animation: true,
                                          animateFromLastPercent: true,
                                          progressColor:
                                          FlutterFlowTheme.of(context)
                                              .primary,
                                          backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .accent4,
                                          center: Text(
                                            '50%',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 230,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2, 0, 0, 0),
                                      child: Container(
                                        height: 230,
                                        child: FlutterFlowLineChart(
                                          data: [
                                            FFLineChartData(
                                              xData: List.generate(
                                                  random_data.randomInteger(
                                                      5, 5),
                                                      (index) => random_data
                                                      .randomInteger(0, 10)),
                                              yData: List.generate(
                                                  random_data.randomInteger(
                                                      5, 5),
                                                      (index) => random_data
                                                      .randomInteger(0, 10)),
                                              settings: LineChartBarData(
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                barWidth: 2,
                                                isCurved: true,
                                                dotData: FlDotData(show: false),
                                                belowBarData: BarAreaData(
                                                  show: true,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .accent1,
                                                ),
                                              ),
                                            )
                                          ],
                                          chartStylingInfo: ChartStylingInfo(
                                            backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            showBorder: false,
                                          ),
                                          axisBounds: AxisBounds(),
                                          xAxisLabelInfo: AxisLabelInfo(),
                                          yAxisLabelInfo: AxisLabelInfo(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed('CustomerChat'); // Navigate to CustomerChat when button is pressed
                              },
                              text: 'Chat Button',
                              icon: const Icon(
                                Icons.chat,
                                size: 40.0,
                              ),
                              options: FFButtonOptions(
                                height: 78.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primaryText,
                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                ),
                                elevation: 3.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 5)),
                  ),
                ),
              ),
              Divider(
                thickness: 5,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 151,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF00831B),
                                    width: 4,
                                  ),
                                ),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://images.unsplash.com/photo-1606902965551-dce093cda6e7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxmaXQlMjBnaXJsfGVufDB8fHx8MTcxMDM5MDQ1N3ww&ixlib=rb-4.0.3&q=80&w=1080',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                              child: Container(
                                width: 255,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(-1, -1),
                                      child: Text(
                                        'MK FIT',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Text(
                                        'Are you free this friday for a workout session?',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-1, 1),
                                      child: Text(
                                        'Mon. July 3rd - 4:12pm',
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
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed('messagePage');
                            },
                            text: 'Messages',
                            options: FFButtonOptions(
                              height: 40,
                              padding:
                              EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Color(0xFF00831B),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
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
