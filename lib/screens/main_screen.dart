import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/assets/utils.dart';
import 'package:http/http.dart' as http;
import 'package:lya_encuestas/screens/menu_pages/login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Constants.COLOR_PRIMARY,
      statusBarColor: Constants.COLOR_PRIMARY,
    ));

    return FutureBuilder(
        future: ValidatedSession(),
        builder: (context, snapshot) {
          return Utils.afterFutureBuilder(context, snapshot, (){
            return const Scaffold(body: LoginScreen());
          });
        });
  }
  // FUNCTION PARA VALIDAR EL INICIO DE SESION
  Future<void> ValidatedSession() async{

  }
  Future<void> ValidatedUser(objusers) async{

  }
}
