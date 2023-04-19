import 'dart:convert';

import 'package:i_p_s_mant/backend/database_connect.dart';
import 'package:i_p_s_mant/models/detalleEvento.dart';
import 'package:i_p_s_mant/models/detalleSalida.dart';
import 'package:i_p_s_mant/models/numOrder.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SalidaDetailsWidget extends StatefulWidget {
  final numOrder numerodeOrden;

  const SalidaDetailsWidget({
    Key key,this.numerodeOrden

  }) : super(key: key);

  @override
  _SalidaDetailsWidgetState createState() =>
      _SalidaDetailsWidgetState();
}

class _SalidaDetailsWidgetState extends State<SalidaDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController serialNumberController;
  TextEditingController locationController;
  SharedPreferences preffs;
  detalleSalida detalle = detalleSalida();
  Location currentLocation = Location();
  int totalItems = 0;
  String iLatitud;
  String iLongitud;
  List<detalleSalida> listadePendientes = [];
  bool numerodeSerieEscaneado = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serialNumberController = TextEditingController();
    locationController = TextEditingController();
    detalle = new detalleSalida();

    _getPendientes();

  }
  _getPendientes(){
    setState(() {
      listadePendientes.clear();
    });
    DatabaseProvider.getPendientesSalidasOrdenes(widget.numerodeOrden.orderNum).then((pendientes) {
      pendientes.forEach((element) {
        if(!element.status){
          setState(() {

            totalItems = pendientes.length;
            listadePendientes.add(element);
          });
        }


      }

      );
      if(listadePendientes.length==0){
        Navigator.pop(context);
        Navigator.pop(context);
      }

    });
  }
  _getPalletID(){
    DatabaseProvider.getPalletByIdSalida(serialNumberController.value.text).then((value) {
      print(value.orderNum);
      if(value.orderNum.contains(widget.numerodeOrden.orderNum)){
        setState(() {
          detalle = value;
          serialNumberController.clear();
        });
      }else{
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AlertDialog(
                  content: Stack(
                    children: <Widget>[
                      InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                      Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Error try again.',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),

                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'The scanned number does not match the purchase order.',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        );
      }


    });
  }
  _checkQty(){
    if(serialNumberController.value.text.contains(detalle.qtyRequested.toString().toUpperCase())){
      DatabaseProvider.saveLocationScanSalida(detalle.orderNum, detalle.palletId);
      setState(() {

        detalle = detalleSalida();
        numerodeSerieEscaneado = false;
        serialNumberController.clear();
        locationController.clear();

      });
      Future.delayed(const Duration(seconds: 2), () {


        setState(() {
          _getPendientes();
        });

      });
    }else{
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AlertDialog(
                content: Stack(
                  children: <Widget>[
                    InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.close),
                        backgroundColor: Colors.red,
                      ),
                    ),
                    Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Error try again.',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),

                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'The scanned number does not match the purchase order.',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      );
    }
  }
  _getLocation(){
    if(serialNumberController.value.text.toUpperCase().contains(detalle.product.toUpperCase())){
      setState(() {
        numerodeSerieEscaneado = true;
        serialNumberController.clear();
        locationController.clear();

      });


    }
    else {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AlertDialog(
                content: Stack(
                  children: <Widget>[ InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                    Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Error try again.',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),

                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'The scanned number does not match the purchase order.',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      );
    }

  }
  _getSerial(){
    if(serialNumberController.value.text.toUpperCase().contains(detalle.serialNum.toUpperCase())){
      setState(() {
        numerodeSerieEscaneado = true;
        serialNumberController.clear();
        locationController.clear();

      });


    }
    else {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AlertDialog(
                content: Stack(
                  children: <Widget>[ InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                    Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Error try again.',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),

                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'The scanned number does not match the purchase order.',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(Duration(seconds: 20), (timer) {
    //   _getEnCurso();
    // });
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).background,
        automaticallyImplyLeading: false,
        // leading: InkWell(
        //   onTap: () async {
        //     Navigator.pop(context);
        //   },
        //   child: Icon(
        //     Icons.chevron_left_rounded,
        //     color: FlutterFlowTheme.of(context).grayLight,
        //     size: 32,
        //   ),
        // ),
        title: Text(
          'EPLogistics SysScan '+DatabaseProvider.lastVersion,
          style: FlutterFlowTheme.of(context).title3,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SafeArea(child:
      SingleChildScrollView(

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Current order number: ' +widget.numerodeOrden.orderNum,
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Pending: ' +listadePendientes.length.toString() + " de: "+totalItems.toString(),
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            detalle.palletId!=null ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Start Process Deaperture',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ) : Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Continue deaperture',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      "Welcome to EPLogistics",
                      style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Scan Code',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            detalle.palletId==null ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: TextFormField(
                  onEditingComplete: (){
                    _getPalletID();
                  },
                  controller: serialNumberController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Pallet ID',
                    labelStyle: FlutterFlowTheme.of(context).bodyText1,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).background,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).background,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).darkBackground,
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                  ),
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ) : numerodeSerieEscaneado==false ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: TextFormField(
                  onEditingComplete: (){
                    _getLocation();
                  },
                  controller: serialNumberController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Part Number',
                    labelStyle: FlutterFlowTheme.of(context).bodyText1,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).background,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).background,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).darkBackground,
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                  ),
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ) : Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: TextFormField(
                  onEditingComplete: (){
                    _checkQty();
                  },
                  controller: serialNumberController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Qty',
                    labelStyle: FlutterFlowTheme.of(context).bodyText1,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).background,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).background,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).darkBackground,
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                  ),
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            detalle.palletId!=null ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'PalletID',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ) : Column(),
            detalle.palletId!=null ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      detalle.palletId,
                      style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ) : Column(),

            detalle.palletId!=null ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'PalletID',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ) : Column(),
            detalle.palletId!=null ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Expanded( child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .88,
                      height: 70,
                      decoration: BoxDecoration(
                        color:
                        FlutterFlowTheme.of(context).darkBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded( child:
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    detalle.palletId,
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .subtitle1
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color:
                                      FlutterFlowTheme.of(
                                          context)
                                          .textColor,
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
                ],
              ),
              ),
            ) : Column(),
            detalle.palletId!=null ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Qty. Box/Pallet:',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ) : Column(),
            detalle.palletId!=null ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Expanded( child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .88,
                      height: 70,
                      decoration: BoxDecoration(
                        color:
                        FlutterFlowTheme.of(context).darkBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [


                            Expanded( child:
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    detalle.qtyRequested.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .subtitle1
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color:
                                      FlutterFlowTheme.of(
                                          context)
                                          .textColor,
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
                ],
              ),
              ),
            ) : Column(),
            detalle.palletId!=null ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 28, 0, 36),
              child: FFButtonWidget(
                onPressed: () {
                  _getLocation();
                },
                text: 'Finish',
                options: FFButtonOptions(
                  width: 300,
                  height: 60,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle:
                  FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  elevation: 2,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 8,
                ),
              ),
            ) : Column(),
            // detalle.palletId!=null ? Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 36),
            //   child: FFButtonWidget(
            //     onPressed: () async {
            //       Navigator.pop(context);
            //     },
            //     text: 'Pausar',
            //     options: FFButtonOptions(
            //       width: 230,
            //       height: 50,
            //       color: FlutterFlowTheme.of(context).darkBackground,
            //       textStyle:
            //           FlutterFlowTheme.of(context).subtitle2.override(
            //                 fontFamily: 'Lexend Deca',
            //                 color: FlutterFlowTheme.of(context).textColor,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //       elevation: 2,
            //       borderSide: BorderSide(
            //         color: Colors.transparent,
            //         width: 1,
            //       ),
            //       borderRadius: 8,
            //     ),
            //   ),
            // ) : Column(),

            listadePendientes.length!= 0 ? Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      "Pallets pending",
                      style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ): Column(),
            listadePendientes.length!= 0 ?
            SizedBox(
              height: 400.0,
              child:  ListView.builder(

                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: listadePendientes.length,
                itemBuilder: (context, listViewIndex) {
                  final evento =
                  listadePendientes[listViewIndex];
                  return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(17, 0, 17, 13),
                      child: InkWell(

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
                                            evento.palletId,
                                            overflow: TextOverflow.ellipsis,
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .subtitle1,
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
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
                                            evento.location.isNotEmpty ? evento.location : "Ubicacion no encontrada",
                                            overflow: TextOverflow.ellipsis,
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .subtitle1,
                                          ),
                                        ),
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


            )
                : Row(
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
            ) ,
          ],
        ),
      ),
      ),
    );
  }
}