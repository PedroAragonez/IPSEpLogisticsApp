import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:i_p_s_mant/models/detalleEvento.dart';
import 'package:i_p_s_mant/models/detalleSalida.dart';
import 'package:i_p_s_mant/models/numEntry.dart';
import 'package:i_p_s_mant/models/numOrder.dart';


class DatabaseProvider {
  static const ROOT = "http://192.168.52.168:8070/api/";
  static const ROOTDETALLEENTRADA = ROOT+"detalleEntrada";
  static const ROOTGETENTRADAS = ROOT+"detalleEntrada/getnumorders";
  static const ROOTGETENTRADASPENDIENTES = ROOT+"detalleEntrada/orderspendingbydocument";
  static const ROOTGETBYPALLEDID = ROOT+"detalleEntrada/bypalletid";
  static const ROOTREGISTRAPALLETSCAN = ROOT+"detalleEntrada/readpalet";
  static const ROOTREGISTRALOCATIONSCAN = ROOT+"detalleEntrada/locationsave";
  static const ROOTDETALLESALIDA = ROOT+"detalleSalida";
  static const ROOTGETBYPALLEDIDSALIDA = ROOT+"detalleSalida/bypalletid";
  static const ROOTREGISTRAPALLETSCANSALIDA = ROOT+"detalleSalida/readpalet";
  static const ROOTREGISTRALOCATIONSCANSALIDA = ROOT+"detalleSalida/depuresave";
  static const ROOTGETSALIDAS = ROOT+"detalleSalida/getnumorders";
  static const ROOTGETSALIDASPENDIENTES = ROOT+"detalleSalida/orderspendingbydocument";
  static String lastVersion = "1.0.6";





//----------------------------------------------------------
// SECTION OF ENTRADA
//----------------------------------------------------------
  static Future<List<detalleEvento>> getPendientesEntradasOrdenes(String documento) async {
    print(ROOTGETSALIDASPENDIENTES+"?document='${documento}'");
    var response = await http.get(Uri.parse(ROOTGETENTRADASPENDIENTES+"?document=${documento}"));
    print("RESPONSE BODY VALIDA USUARIO ID ::: "+response.body);
    if (response.statusCode == 200) {
      List<detalleEvento> list = parseDetalleEventoList(response.body);

      return list;
    } else {
    }
  }
//obtener usuario mediante email y password
  static Future<List<numEntry>> getPalletsPendientes( ) async {
    var response = await http.get(Uri.parse(ROOTGETENTRADAS));
    if (response.statusCode == 200) {
      print(response.body);
      List<numEntry> list = parseDetalleEvento(response.body);

      return list;
    } else {
      throw <numEntry>[];
    }
  }
  static List<numEntry> parseDetalleEvento(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<numEntry>((json) => numEntry.fromJson(json)).toList();
  }
  static List<detalleEvento> parseDetalleEventoList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<detalleEvento>((json) => detalleEvento.fromJson(json)).toList();
  }
//obtener usuario mediante email y password
  static Future<detalleEvento> getPalletById(String palletId) async {
    print(ROOTGETBYPALLEDID+"?palletid="+palletId+"");
    var response = await http.get(Uri.parse(ROOTGETBYPALLEDID+"?palletid="+palletId+""));
    if (response.statusCode == 200) {
      print(response.body);
      detalleEvento list = detalleEvento.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <detalleEvento>[];
    }
  }
  static savePalletScan(String palletId) async {
    print(ROOTREGISTRAPALLETSCAN+"?palletid=${palletId}");
    var response = await http.get(Uri.parse(ROOTREGISTRAPALLETSCAN+"?palletid=${palletId}"));
    if (response.statusCode == 200) {

    } else {
    }
  }
  //obtener usuario mediante id
  static saveLocationScan(String location, String palletId) async {
    print(ROOTREGISTRALOCATIONSCAN+"?palletid=${palletId}&location=${location}");
    var response = await http.get(Uri.parse(ROOTREGISTRALOCATIONSCAN+"?palletid=${palletId}&location=${location}"));
    print("RESPONSE BODY VALIDA USUARIO ID ::: "+response.body);
    if (response.statusCode == 200) {
    } else {
    }
  }


//----------------------------------------------------------
// END SECTION OF ENTRADA
//----------------------------------------------------------


//----------------------------------------------------------
// SECTION OF SALIDA
//----------------------------------------------------------


//obtener usuario mediante email y password
  static Future<detalleSalida> getPalletByIdSalida(String palletId) async {
    print(ROOTGETBYPALLEDIDSALIDA+"?palletid=${palletId}");
    var response = await http.get(Uri.parse(ROOTGETBYPALLEDIDSALIDA+"?palletid=${palletId}"));
    if (response.statusCode == 200) {
      detalleSalida list = detalleSalida.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <detalleSalida>[];
    }
  }
  static savePalletScanSalida(String palletId) async {
    print(ROOTREGISTRAPALLETSCANSALIDA+"?palletid='${palletId}'");
    var response = await http.get(Uri.parse(ROOTREGISTRAPALLETSCANSALIDA+"?palletid='${palletId}'"));
    if (response.statusCode == 200) {

    } else {
    }
  }
  //obtener usuario mediante id
  static saveLocationScanSalida(String location, String palletId) async {
    print(ROOTREGISTRALOCATIONSCANSALIDA+"?palletid=${palletId}&document=${location}");
    var response = await http.get(Uri.parse(ROOTREGISTRALOCATIONSCANSALIDA+"?palletid=${palletId}&document=${location}"));
    print("RESPONSE BODY VALIDA USUARIO ID ::: "+response.body);
    if (response.statusCode == 200) {
    } else {
    }
  }
  //obtener usuario mediante id
  static Future<List<numOrder>> getSalidasNumorder() async {
    var response = await http.get(Uri.parse(ROOTGETSALIDAS));
    print("RESPONSE BODY VALIDA USUARIO ID ::: "+response.body);
    if (response.statusCode == 200) {
      List<numOrder> list = parseNumorder(response.body);

      return list;
    } else {
    }
  }
  static List<numOrder> parseNumorder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<numOrder>((json) => numOrder.fromJson(json)).toList();
  }

  //obtener usuario mediante id
  static Future<List<detalleSalida>> getPendientesSalidasOrdenes(String documento) async {
    print(ROOTGETSALIDASPENDIENTES+"?document='${documento}'");
    var response = await http.get(Uri.parse(ROOTGETSALIDASPENDIENTES+"?document=${documento}"));
    print("RESPONSE BODY VALIDA USUARIO ID ::: "+response.body);
    if (response.statusCode == 200) {
      List<detalleSalida> list = parsePendientes(response.body);

      return list;
    } else {
    }
  }

  static List<detalleSalida> parsePendientes(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<detalleSalida>((json) => detalleSalida.fromJson(json)).toList();
  }



//----------------------------------------------------------
// END SECTION OF SALIDA
//----------------------------------------------------------

}