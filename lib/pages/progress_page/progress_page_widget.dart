import '../../components/progress_component_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:m_k_fit/backend/firebase_storage/database.dart';
import "package:firebase_storage/firebase_storage.dart";

import 'progress_page_model.dart';
export 'progress_page_model.dart';

class ProgressPageWidget extends StatefulWidget {
  const ProgressPageWidget({super.key});

  @override
  State<ProgressPageWidget> createState() => _ProgressPageWidgetState();
}

class _ProgressPageWidgetState extends State<ProgressPageWidget> {
  late ProgressPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double? bmiValue;
  // Initialize the database service instance here
  final DatabaseService databaseService = DatabaseService();

  Map<String, Map<String, List<dynamic>>> graphData = {
    "weight": {"x": [], "y": []},
    "bmi": {"x": [], "y": []}
  };

  Future<void> updateBMIChartData() async {
    List<Map<String, dynamic>> bmiRecords = [
      {"date": DateTime.now().subtract(Duration(days: 30)), "bmi": 23.5},
      {"date": DateTime.now().subtract(Duration(days: 20)), "bmi": 24.1},
      {"date": DateTime.now().subtract(Duration(days: 10)), "bmi": 23.9},
      {"date": DateTime.now(), "bmi": 24.0},
    ];
    graphData["bmi"]!["x"] = bmiRecords.map((record) => record["date"]).toList();
    graphData["bmi"]!["y"] = bmiRecords.map((record) => record["bmi"]).toList();
  }

  Future<double?> calculateBMI() async {
    String? heightStr = await databaseService.getUserHeight();
    String? weightStr = await databaseService.getUserWeight();

    if (heightStr != null && weightStr != null) {
      try {
        List<String> heightParts = heightStr.split("'");
        int feet = int.parse(heightParts[0].trim());
        int inches = int.parse(heightParts[1].replaceAll("\"", "").trim());
        double heightInMeters = ((feet * 12) + inches) * 0.0254;
        double weightInKg = double.parse(weightStr) * 0.453592;
        double bmi = weightInKg / (heightInMeters * heightInMeters);
        return bmi;

      } catch (e) {
        print("Error in calculating BMI: $e");
        return null;
      }
    } else {
      print("Height or Weight data not available.");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
    getGraphData();
    calculateBMI().then((bmi) {
        setState(() {
          bmiValue = bmi;
        });
    });
  }

  Future getGraphData() async {
    var data = await databaseService.getGraphData(["weight", "bmi"]);
    setState(() {
      graphData = data;
    });
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
          title: Text(
            'Progress',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
          FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 72,
          icon: Icon(
            Icons.settings_rounded,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () async {
            context.pushNamed('SettingsPage');
          },
        )
            //),
          ],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                  child: Container(
                    width: double.infinity,
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 32, 16, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Color(0xFF86BD92),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF86BD92),
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(44),
                                    child: Image.network(
                                      'https://picsum.photos/seed/183/600',
                                      width: 44,
                                      height: 44,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 4),
                                        child: Text(
                                          'Weight',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        'Your recent activity is below.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 60,
                                icon: Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () =>
                                            FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: ProgressComponentWidget(
                                              input: "weight"),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            child: FlutterFlowLineChart(
                              data: [
                                FFLineChartData(
                                  xData: graphData["weight"]!["x"]!,
                                  yData: graphData["weight"]!["y"]!,
                                  settings: LineChartBarData(
                                    color: FlutterFlowTheme.of(context).primary,
                                    barWidth: 2,
                                    isCurved: true,
                                    preventCurveOverShooting: true,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Color(0x4C4B39EF),
                                    ),
                                  ),
                                )
                              ],
                              chartStylingInfo: ChartStylingInfo(
                                enableTooltip: true,
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                showBorder: false,
                              ),
                              axisBounds: AxisBounds(),
                              xAxisLabelInfo: AxisLabelInfo(
                                title: 'Last 30 Days',
                                titleTextStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              yAxisLabelInfo: AxisLabelInfo(
                                title: 'Weight lb.',
                                titleTextStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 32, 16, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Color(0xFF86BD92),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF86BD92),
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(44),
                                    child: Image.network(
                                      'https://picsum.photos/seed/183/600',
                                      width: 44,
                                      height: 44,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                        child: Text(
                                          'BMI',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        'Your recent activity is below.',
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 60,
                                icon: Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding: MediaQuery.viewInsetsOf(context),
                                          child: ProgressComponentWidget(input: "bmi"),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                              ),
                            ],
                          ),
                        ),
                        // Display BMI value
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                          child: Text(
                            bmiValue != null
                                ? 'Current BMI: ${bmiValue!.toStringAsFixed(1)}'
                                : 'Calculating BMI...',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            child: FlutterFlowLineChart(
                              data: [
                                FFLineChartData(
                                  xData: graphData["bmi"]!["x"]!,
                                  yData: graphData["bmi"]!["y"]!,
                                  settings: LineChartBarData(
                                    color: FlutterFlowTheme.of(context).secondary,
                                    barWidth: 2,
                                    isCurved: true,
                                    preventCurveOverShooting: true,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Color(0x3239D2C0),
                                    ),
                                  ),
                                )
                              ],
                              chartStylingInfo: ChartStylingInfo(
                                enableTooltip: true,
                                backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                showBorder: false,
                              ),
                              axisBounds: AxisBounds(),
                              xAxisLabelInfo: AxisLabelInfo(
                                title: 'Last 30 Days',
                                titleTextStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              yAxisLabelInfo: AxisLabelInfo(
                                title: 'BMI',
                                titleTextStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                          child: Container(
                            width: 86,
                            height: 86,
                            decoration: BoxDecoration(),
                            child: FlutterFlowIconButton(
                              borderColor: Color(0xFF86BD92),
                              borderRadius: 40,
                              borderWidth: 3,
                              buttonSize: 40,
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 60,
                              ),
                              onPressed: () async {
                                final databaseService = DatabaseService();

                                FilePickerResult? file = await FilePicker
                                    .platform
                                    .pickFiles(type: FileType.image);
                                String uid = await databaseService.getUID();
                                String destination =
                                    "images/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg";

                                UploadTask? uploadTask = await databaseService
                                    .uploadFile(file, destination);
                                if (uploadTask != null) {
                                  TaskSnapshot taskSnapshot = await uploadTask;
                                  String url =
                                      await taskSnapshot.ref.getDownloadURL();
                                  databaseService.uploadProgress("img", url);
                                }
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Container(
                              width: 244,
                              height: 100,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              alignment: AlignmentDirectional(-1, 0),
                              child: Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Text(
                                        'Time for a progress picture?',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 20,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      'Last picture taken on 1/25/24',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
