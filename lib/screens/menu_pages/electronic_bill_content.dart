import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lya_encuestas/screens/menu_pages/bill_screen.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_content.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_data_screen.dart';
import 'package:lya_encuestas/screens/menu_pages/myInit_screen.dart';
import 'package:lya_encuestas/widgets/background.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'package:lya_encuestas/assets/utils.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:lya_encuestas/assets/constants.dart';




class ElectronicBillContentScreen extends StatefulWidget {
  const ElectronicBillContentScreen({Key? key}) : super(key: key);

  @override
  _ElectronicBillContentScreenState createState() => _ElectronicBillContentScreenState();//state creation
}
//state
class _ElectronicBillContentScreenState extends State<ElectronicBillContentScreen> {
  late ProgressDialog loading;



  @override
  void initState(){
    super.initState();

  }

  @override
  void dispose(){
    super.dispose();
  }

  bool _isMenuOpen = false;
  void toggleMenu() {//Palanca
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  //Boton de enviar
  bool isButtonPressed = false;

  //BOTONES DE LA BARRA DE NAVEGACIÓN LATERAL
  List<Color> tileColors = [Color(0xFF6C7480), Color(0xFF6C7480), Color(0xFF6C7480),Color(0xFF6C7480),Color(0xFF6C7480),Color(0xFF6C7480),Color(0xFF6C7480)];
  void changeColor(int index) {
    setState(() {
      for (int i = 0; i < tileColors.length; i++) {
        if (i == index) {
          tileColors[i] =  Color(0xFF0EB1E6); // Cambia el color al seleccionado
        } else {
          tileColors[i] = Color(0xFF6C7480); // Vuelve a establecer el color predeterminado para los demás
        }
      }
    });
  }


  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
        SingleChildScrollView(
            child: Background(
              child: Column(
                children: [
                  // Resto del contenido
                  //////////////////////////////////////////////////PRIMERA FILA////////////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        //alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,MediaQuery.of(context).size.width*0.06,MediaQuery.of(context).size.width*0.2, MediaQuery.of(context).size.width*0.04),
                        margin: EdgeInsets.only(right: 100),
                        child:Image.asset('assets/images/Logo movistar@300x-8.png',width: MediaQuery.of(context).size.width * 0.4,alignment: Alignment.bottomRight),
                      ),
                    ],
                  ),

                  ///////////////////////////////////////////////////SEGUNDA FILA/////////////////////////////////////////////

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'FACTURA ELECTRÓNICA',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),
                          ),
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        icon: Container(
                          decoration: BoxDecoration(
                            // Ajusta el grosor del borde
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            size: 22,
                            color: Color(0xFF115B84),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BillScreen()),(route) => false);
                        },
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.05, 0),
                        //margin: const EdgeInsets.symmetric(horizontal: 20),
                        child:  TextField(
                            //controller:  nameProduct,
                            decoration: InputDecoration(
                              hintText: "Factura N° 0000",
                              hintStyle: TextStyle(color: Colors.black26),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                              ),
                            ),
                            obscureText: false
                        ),
                      ),
                    ],
                  ),

                   SizedBox(
                    height: 10,
                  ),

                  Row(
                    children:<Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:Text('Contenido',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                      ),
                    ],
                  ),


                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 0, MediaQuery.of(context).size.width * 0.4,0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text("Cliente-Persona de contacto", style: TextStyle(color: Colors.black26)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text("Nombre de la organización", style: TextStyle(color: Colors.black26)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text("Recibo Factura Numerada", style: TextStyle(color: Colors.black26)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text("Usuario Nombre de la persona", style: TextStyle(color: Colors.black26)),
                      ],
                    ),
                  ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.19,
                  ),


                  Column(
                    children: [
                      Row(
                          children:<Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.width * 0.2, 0),
                                child: OutlinedButton(
                                  onPressed: (){

                                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BillScreen()),(route) => false);
                                  },
                                  child: const Text('Editar',style: TextStyle(color:Colors.white),),
                                  style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    side: BorderSide.none,
                                    backgroundColor: const Color(0xFF0EB1E6),
                                    //backgroundColor: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),

                      Row(
                          children:<Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.2, 0),
                                child: OutlinedButton(
                                  onPressed: (){
                                 //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ElectronicBillProductsScreen(data3:Map.identity()),),(route) => false);
                                  },
                                  child: const Text('Enviar'),
                                  style: OutlinedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      side: const BorderSide(color: Color(0xFF0EB1E6))
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),







                ],
              ),
            ),
        ),


            ///////ULTIMO
            ////////////////////////////////////////////////BARRA LATERAL MENU//////////////////////////////////////////////
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              transform: Matrix4.translationValues(_isMenuOpen ? 100 : 400, 0, 0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),

              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  SizedBox(height: 80),

                  ListTile(
                    title: Text('Consultar', style: TextStyle(color: tileColors[0],fontWeight: FontWeight.bold),),
                    onTap: () {
                      changeColor(0);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()));
                    },
                  ),

                  ListTile(
                    title: Text('Emisión', style: TextStyle(color: tileColors[1],fontWeight: FontWeight.bold)),
                    onTap: () {
                      changeColor(1);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()));
                    },
                  ),

                  ListTile(
                    title: Text('Cotización', style: TextStyle(color: tileColors[2],fontWeight: FontWeight.bold)),
                    onTap: () {
                      changeColor(2);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()));
                    },
                  ),

                  ListTile(
                    title: Text('Gastos', style: TextStyle(color: tileColors[3],fontWeight: FontWeight.bold)),
                    onTap: () {
                      changeColor(3);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()));
                    },
                  ),

                  ListTile(
                    title: Text('Cobranzas', style: TextStyle(color: tileColors[3],fontWeight: FontWeight.bold)),
                    onTap: () {
                      changeColor(3);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()));
                    },
                  ),

                  ListTile(
                    title: Text('Mantenimientos', style: TextStyle(color: tileColors[3],fontWeight: FontWeight.bold)),
                    onTap: () {
                      changeColor(3);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()));
                    },
                  ),

                  ListTile(
                    title: Text('DashBoard', style: TextStyle(color: tileColors[3],fontWeight: FontWeight.bold)),
                    onTap: () {
                      changeColor(3);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()));
                    },
                  ),

                  ListTile(
                    title: Text('Centro de ayuda', style: TextStyle(color: tileColors[3],fontWeight: FontWeight.bold)),
                    onTap: () {
                      changeColor(3);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()));
                    },
                  ),

                ],
              ),

            ),

            // Menu Button
            Positioned(
              top: 20,
              right: 10,
              child: Container(
                margin: const EdgeInsets.only(right: 5.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF00B7F1), // Color de fondo
                  shape: BoxShape.circle, // Forma circular para el botón
                ),
                child: IconButton(
                  icon: Icon(
                    _isMenuOpen ? Icons.close : Icons.menu,
                    color: Colors.white, // Color del icono
                  ),
                  onPressed: toggleMenu,
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}






