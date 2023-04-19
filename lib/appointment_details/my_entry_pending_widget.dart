import 'dart:convert';

import 'package:i_p_s_mant/backend/database_connect.dart';
import 'package:i_p_s_mant/models/numEntry.dart';
import 'package:i_p_s_mant/models/numOrder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appointment_details/appointment_details_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'exit_details_widget.dart';

class EntryWidget extends StatefulWidget {
  const EntryWidget({Key key, }) : super(key: key);

  @override
  _EntryWidgetState createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<numEntry> listadeOrdenes = [];
  @override
  void initState() {
    super.initState();
    _getRequisitorEventos();
  }
  _getRequisitorEventos() async {
    DatabaseProvider.getPalletsPendientes().then((value) {
      setState(() {
        print(value.first.IdLot);
        listadeOrdenes = value;
      });
    });




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).background,
        automaticallyImplyLeading: false,
        title: Text(
          'Output orders',
          style: FlutterFlowTheme.of(context).title1,
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: Image.asset(
              'assets/images/logo.png',
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).background,

      body: SafeArea(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(
                thickness: 3,
                indent: 150,
                endIndent: 150,
                color: Color(0xFF465056),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        'Pending Orders.',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                ],
              ),

              listadeOrdenes!=null ? Expanded(
                child:  ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: listadeOrdenes.length,
                  itemBuilder: (context, listViewIndex) {
                    final evento =
                    listadeOrdenes[listViewIndex];
                    return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(17, 0, 17, 13),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppointmentDetailsWidget(
                                      numEntrada: evento,
                                    ),
                              ),
                            );
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 91,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .darkBackground,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 12, 12, 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(4, 0, 0, 0),
                                            child: Text(
                                              evento.IdLot,
                                              overflow: TextOverflow.ellipsis,
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .title3,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .grayLight,
                                          size: 24,
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    );
                  },
                ),

              ): Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        'There are no pending orders.',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ]
        ),
      ),
    );
  }
}