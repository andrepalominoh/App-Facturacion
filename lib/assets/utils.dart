import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lya_encuestas/classes/database/data_access/last_answer_da.dart';
import 'package:lya_encuestas/classes/database/models/last_answer.dart';
import 'package:lya_encuestas/classes/database/models/period.dart';
import 'package:lya_encuestas/classes/database/models/sell_point.dart';
import 'package:lya_encuestas/classes/database/models/sku.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {

  static Widget afterFutureBuilder(BuildContext context, AsyncSnapshot<Object?> snapshot, toExecute) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Text('Por favor espere....')],
        ),
      ));
    }else {
      if (snapshot.hasError) {
        String message = "Ocurrio un error en la aplicación. Por favor contactese con un administrador enviando una captura de pantalla de esta ventana\n\nError: ${snapshot.error}";
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(message)],
            ),
          )
        );
      } else {
        return toExecute();
      }
    }
  }

  static void closeMessageDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(email);
  }

  static String getDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return formattedDate;
  }

  static Future<List<LastAnswer>> getLastAnswers( Period period, Sku sku, SellPoint sellPoint) async {
    var dbData;
    if (sku.id > 0 && sellPoint.id > 0) {
      //si ni el sku ni el sellpoint es alta entonces el proceso es normal, se busca en la tabla last_answers para encontrar los surveys y si no hay en vez de sku usamos el category.
      dbData = await LastAnswerDA().getBySellPointAndSkuGroupedBySurvey(
          period.code, sellPoint.id, sku.id);

      if (dbData.isEmpty) {
        dbData = await LastAnswerDA().getBySellPointAndCategoryGroupedBySurvey(
            period.code, sellPoint.id, sku.categoryId);
      }
    } else if ((sku.id < 0 && sellPoint.id < 0) ||
        (sku.id > 0 && sellPoint.id < 0)) {
      // Como es nuevo sell point entonces se asume que el sell point afecta a toooodos los surveys (Independiente de la orden de trabajo, ya en el procesamiento se filtra).
      // Lo mismo, si solo el PUNTO DE VENTA es nuevo entonces se busca solo por categoría de SKU puesto que se asume que el punto de venta aplica para todas las SURVEYS.
      dbData = await LastAnswerDA().getByNewSellPointAndCategoryGroupedBySurvey(
          period.code, sku.categoryId);
    } else if (sku.id < 0 && sellPoint.id > 0) {
      // Si solo el SKU es alta entonces se utiliza la categoría del SKU nuevo para obtener los surveys.
      dbData = await LastAnswerDA().getBySellPointAndCategoryGroupedBySurvey(
          period.code, sellPoint.id, sku.categoryId);
    }
    var data = LastAnswer.parseModelList(dbData);

    return data;
  }

  static Future<bool> internetConnectivity()async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(BuildContext context,Color backgroundColor,Color textColor,String message){
    SnackBar snackBar = SnackBar(
      content: Row(children: <Widget>[
        Text(message,style: TextStyle(
          color: textColor
        ),)
      ]),
      backgroundColor: backgroundColor,
      shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  saveSharedPreferences(String key,String value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<dynamic> readSharedPreferences(String key)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString(key)==null)return null;
    return prefs.getString(key);
  }

  Future<bool> containsSharedPreferences(String key)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(key);
  }
  Future<bool> removerSharedPreferences(String key)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(key);
  }
  Future<List<String>> GetDatesOfWeek() async {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    // OBTENEMOS EL RANGO DE FECHAS
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dayRange = await readSharedPreferences('dayRange') ?? '7';
    // VBobio2022@gmail.com
    List<String> test =[];
    for(var i = 0 ; i<int.parse(dayRange); i++){
      var formatter = DateFormat('d-MM-yyyy');
      var ad =  now.add(Duration(days: - i));
      String formattedDate = formatter.format(ad);
      test.add(formattedDate.toString());
    }
    return test;
  }

  Future<String> GetDateAndValidateDate()async{
    String date = '';
    List<String> dates = await GetDatesOfWeek();
    String readpreference = await readSharedPreferences('date_selected')??'';
    if(readpreference!=null || readpreference != ''){
      bool verif = dates.contains(readpreference);
      print(readpreference);
      print(verif);
      if(verif){
        date = readpreference;
      }else{
        date = dates[dates.length-1].toString();
      }
    }else{
      date = dates[0].toString();
      await saveSharedPreferences('date_selected',date);
    }
    return date;
  }
}