import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/utils.dart';

import 'package:lya_encuestas/classes/database/models/user.dart';
import 'package:lya_encuestas/screens/menu_pages/myInit_screen.dart';
import 'package:lya_encuestas/widgets/background.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:lya_encuestas/assets/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();//state creation
}

class _LoginScreenState extends State<LoginScreen> {
  late ProgressDialog loading;

  //Primera vez
  final txtEmailController = TextEditingController();
  final txtPasswordController = TextEditingController();

  //Primera vez
  @override
  void initState() {
    super.initState();
    loading = ProgressDialog(context: context);
  }

  //Primera vez
  @override
  void dispose() {
    txtEmailController.dispose();
    txtPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Background(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Image.asset('assets/images/header-banner.png',width: MediaQuery.of(context).size.width * 1),
                        Container(
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.5,MediaQuery.of(context).size.width * 0.2, 25, 25),
                          child: Image.asset('assets/images/Image.png',width: MediaQuery.of(context).size.width * 0.4,alignment: Alignment.bottomRight),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        child: TextField(
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                hintText: "Username or Email",
                                enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                ),
                            ),
                            obscureText: false,
                            controller: txtEmailController,

                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "Password",
                                enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                              ),
                            ),
                            obscureText: false,
                            controller: txtPasswordController
                        ),
                      ),
                      Row(
                        children:<Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.width * 0.2, 0),
                              child: OutlinedButton(
                                onPressed: (){
                                  LoginApi(context);
                                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyInitScreen()),(route) => false);
                                },
                                child: const Text('Ingresar'),
                                style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(color: Colors.lightBlue)
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                      TextButton(
                          onPressed: (){
                            print("gika");
                          },
                          child: const Text('¿Olvidaste tu contraseña?',style: TextStyle(color: Colors.grey),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> ValidarLoginScreen(BuildContext context) async {

  }


 /////////LOGIN API///////////////////////////////
  Future<void> LoginApi(BuildContext context) async{
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    if(txtEmailController.text.isEmpty){
      print("el txt email esta vacio");
    }
    if(txtPasswordController.text.isEmpty){
      print("La contraseña esta vacia");
    }
    loading.show(
      barrierDismissible: false,
      max: 50,
      msg: "Validando User"
    );
    const Url = Constants.API_URL + Constants.API_REQUEST_POST_GET_TOKEN;
    final body = {
      'username': txtEmailController.text,
      'password': txtPasswordController.text,
      'grant_type': 'password'
    };
    //La cadena de texto  se almacena en la constante response
    final response = await http.post(Uri.parse(Url),headers:headers, body:body);
    loading.close();
    if(response.statusCode == 200){
      //response.body , contiene una cadena de texto en formato JSON
      //jsonDecode es una función que se utiliza para analizar la respuesta JSON
      //jsonDecode convierte la informacion en string del response.body en un JSON
      final data = jsonDecode(response.body);
      //Utils() , es una clase que llama al metodo saveSharedPreferences
      //saveSharedPreferences:  Se utiliza para guardar informacion en el almacenamiento compartido.
      Utils().saveSharedPreferences('access_parameters', response.body);
      //print(response.statusCode);
      //print(data);
      print(body);
    }
    if(response.statusCode == 400){
      print("fallo la Autorization");
    }
  }

  void configureUserAcess(BuildContext context, User user) {

  }
}