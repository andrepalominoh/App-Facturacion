import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lya_encuestas/assets/utils.dart';
import 'package:lya_encuestas/main.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_coin_screen.dart';
import 'package:lya_encuestas/widgets/background.dart';
import 'package:lya_encuestas/screens/menu_pages/bill_screen.dart';//screen navigation
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class MyInitScreen extends StatefulWidget{
  const MyInitScreen({Key?key}):super(key: key);
  @override
  _MyInitScreenState createState() => _MyInitScreenState();//state creation
}
//state
class _MyInitScreenState extends State<MyInitScreen>{



  late ProgressDialog loading;

  String? User = "andre";

  //BARRA DE NAVEGACIÓN MENÚ LATERAL
  bool _isMenuOpen = false;
  //Se ejecuta la funcion toggleMenu cuando el usuario presione el icono
  void toggleMenu() {//Palanca
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  //BOTÓNES DEL MENÚ
  //Factura
  bool isButtonPressed = false;
  //Boleta
  bool isButtonPressed2 = false;
  //Nota de Credito
  bool isButtonPressed3 = false;
  //Nota de debito
  bool isButtonPressed4 = false;
  //Guia de Remisión (Remitente)
  bool isButtonPressed5 = false;
  //Guia de Remisión (Transportistas)
  bool isButtonPressed6 = false;


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
  void initState() {
    super.initState();
    getParameterAccess();
  }

  @override
  void dispose() {
    //txtEmailTransport.dispose();
    //txtPasswordTransport.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor= Color(0xFFF6F6F6);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              child: Column(
                children: [
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
                    children:<Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child:Text('EMISIÓN',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                      ),
                    ],
                  ),

                  //Linea horizontal
                  const Divider(
                    color: Color(0xFF115B84),
                    indent: 20,
                    endIndent: 20,
                  ),
                  ////////////////////////////////////////////////////TERCERA FILA///////////////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.width*0.20,
                        margin: EdgeInsets.all(5.0),


                        decoration: BoxDecoration(
                          //  borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                            color: Color(0xFF115B84),
                        ),

                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("S/0000.00",style:TextStyle(color: Colors.white,fontSize: 15.0)),
                            SizedBox(height: 5,),
                            Text("Pagadas",style:TextStyle(color: Colors.white,fontSize: 11.0)),
                          ],
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.width*0.20,
                        margin: EdgeInsets.all(5.0),

                        decoration: BoxDecoration(
                          //  borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          color: Color(0xFF115B84),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("S/0000.00",style:TextStyle(color: Colors.white,fontSize: 15.0)),
                            SizedBox(height: 5,),
                            Text("No Pagadas",style:TextStyle(color: Colors.white,fontSize: 11.0)),
                          ],
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.width*0.20,
                        margin: EdgeInsets.all(5.0),

                        decoration: BoxDecoration(
                          //  borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                          color: Color(0xFF115B84),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("S/0000.00",style:TextStyle(color: Colors.white,fontSize: 15.0)),
                            SizedBox(height: 5,),
                            Text("Todas",style:TextStyle(color: Colors.white,fontSize: 11.0)),
                          ],
                        ),
                      )
                    ],
                  ),

                  //Segunda linea horizontal
                  const Divider(
                    color: Color(0xFF115B84),
                    indent: 20,
                    endIndent: 20,
                  ),

                  //////////////////////////////////////////////////////CUARTA FILA//////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            isButtonPressed = true;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            isButtonPressed = false;
                          });
                          //Primera exp
                          print("desde la vista init ====================");
                          print(User);
                           Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()),);
                        },
                        onTapCancel: () {
                          setState(() {
                            isButtonPressed = false;
                          });
                        },
                        child:  Container(

                          width: MediaQuery.of(context).size.width*0.4,
                          height: MediaQuery.of(context).size.width*0.28,
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.symmetric(vertical: 10.0),

                          decoration: BoxDecoration(
                              color: isButtonPressed ? Color(0xFF00B7F1) : Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(10),
                              //shape: BoxShape.rectangle,

                              boxShadow:[
                                BoxShadow (
                                    color: Colors.white,
                                    offset: Offset(-2,-2),
                                    blurRadius: 2, //Suavizar la sombra
                                    spreadRadius: 2
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(2,2),
                                    blurRadius: 1,
                                    spreadRadius: 1
                                )
                              ]
                          ),

                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  isButtonPressed
                                      ? 'assets/images/Factura-B@300x-8.png'//Si el boton esta presionado se muestra esta imagen
                                      : 'assets/images/Factura-A@300x-8.png',//Caso contrario, si el boton no esta presionado , te muestra esta imagen por defecto
                                  // Esta linea ajusta las propiedades de la imagen
                                  width: MediaQuery.of(context).size.width * 0.135,
                                ),

                                Text(
                                  'Factura',textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                    color: isButtonPressed ? Colors.white : Color(0xFF115B84),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            isButtonPressed2 = true;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            isButtonPressed2 = false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()),);
                        },
                        onTapCancel: () {
                          setState(() {
                            isButtonPressed2 = false;
                          });
                        },
                        child:  Container(

                          width: MediaQuery.of(context).size.width*0.4,
                          height: MediaQuery.of(context).size.width*0.28,
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.symmetric(vertical: 10.0),

                          decoration: BoxDecoration(
                              color: isButtonPressed2 ? Color(0xFF00B7F1) : Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(10),
                              //shape: BoxShape.rectangle,

                              boxShadow:[
                                BoxShadow (
                                    color: Colors.white,
                                    offset: Offset(-2,-2),
                                    blurRadius: 2, //Suavizar la sombra
                                    spreadRadius: 2
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(2,2),
                                    blurRadius: 1,
                                    spreadRadius: 1
                                )
                              ]
                          ),

                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  isButtonPressed2
                                      ? 'assets/images/Boleta-B@300x-8.png'//Si el boton esta presionado se muestra esta imagen
                                      : 'assets/images/Boleta-A@300x-8.png',//Caso contrario, si el boton no esta presionado , te muetra esta imagen por defecto
                                  // Esta linea ajusta las propiedades de la imagen
                                  width: MediaQuery.of(context).size.width * 0.135,
                                ),

                                Text(
                                  'Boleta',textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                    color: isButtonPressed2 ? Colors.white : Color(0xFF115B84),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(
                    height:5,
                  ),

                  /////////////////////////////////////////////QUINTA FILA//////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            isButtonPressed3 = true;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            isButtonPressed3 = false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()),);
                        },
                        onTapCancel: () {
                          setState(() {
                            isButtonPressed3 = false;
                          });
                        },
                        child:  Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          height: MediaQuery.of(context).size.width*0.28,
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.symmetric(vertical: 10.0),

                          decoration: BoxDecoration(
                              color: isButtonPressed3 ? Color(0xFF00B7F1) : Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(10),
                              //shape: BoxShape.rectangle,

                              boxShadow:[
                                BoxShadow (
                                    color: Colors.white,
                                    offset: Offset(-2,-2),
                                    blurRadius: 2, //Suavizar la sombra
                                    spreadRadius: 2
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(2,2),
                                    blurRadius: 1,
                                    spreadRadius: 1
                                )
                              ]
                          ),

                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  isButtonPressed3
                                      ? 'assets/images/Nota de Credito-B300x-8.png'//Si el boton esta presionado se muestra esta imagen
                                      : 'assets/images/Nota de Credito-A@300x-8.png',//Caso contrario, si el boton no esta presionado , te muetra esta imagen por defecto
                                  // Esta linea ajusta las propiedades de la imagen
                                  width: MediaQuery.of(context).size.width * 0.135,
                                ),

                                Text(
                                  'Nota de Crédito',textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                    color: isButtonPressed3 ? Colors.white : Color(0xFF115B84),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            isButtonPressed4 = true;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            isButtonPressed4 = false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()),);
                        },
                        onTapCancel: () {
                          setState(() {
                            isButtonPressed4 = false;
                          });
                        },
                        child:  Container(

                          width: MediaQuery.of(context).size.width*0.4,
                          height: MediaQuery.of(context).size.width*0.28,
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.symmetric(vertical: 10.0),

                          decoration: BoxDecoration(
                              color: isButtonPressed4 ? Color(0xFF00B7F1) : Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(10),
                              //shape: BoxShape.rectangle,

                              boxShadow:[
                                BoxShadow (
                                    color: Colors.white,
                                    offset: Offset(-2,-2),
                                    blurRadius: 2, //Suavizar la sombra
                                    spreadRadius: 2
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(2,2),
                                    blurRadius: 1,
                                    spreadRadius: 1
                                )
                              ]
                          ),

                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  isButtonPressed4
                                      ? 'assets/images/Nota de Debito-B@300x-8.png'//Si el boton esta presionado se muestra esta imagen
                                      : 'assets/images/Nota de Debito-A@300x-8.png',//Caso contrario, si el boton no esta presionado , te muetra esta imagen por defecto
                                  // Esta linea ajusta las propiedades de la imagen
                                  width: MediaQuery.of(context).size.width * 0.135,
                                ),

                                Text(
                                  'Nota de Débito',textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                    color: isButtonPressed4 ? Colors.white : Color(0xFF115B84),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox (
                    height:5,
                  ),

                  ////////////////////////////////////////////SEXTA FILA//////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            isButtonPressed5 = true;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            isButtonPressed5 = false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()),);
                        },
                        onTapCancel: () {
                          setState(() {
                            isButtonPressed5 = false;
                          });
                        },
                        child:  Container(

                          width: MediaQuery.of(context).size.width*0.4,
                          height: MediaQuery.of(context).size.width*0.28,
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.symmetric(vertical: 10.0),

                          decoration: BoxDecoration(
                              color: isButtonPressed5 ? Color(0xFF00B7F1) : Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(10),
                              //shape: BoxShape.rectangle,

                              boxShadow:[
                                BoxShadow (
                                    color: Colors.white,
                                    offset: Offset(-2,-2),
                                    blurRadius: 2, //Suavizar la sombra
                                    spreadRadius: 2
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(2,2),
                                    blurRadius: 1,
                                    spreadRadius: 1
                                )
                              ]
                          ),

                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  isButtonPressed5
                                      ? 'assets/images/G-R-Remitente-B@300x-8.png'//Si el boton esta presionado se muestra esta imagen
                                      : 'assets/images/G-R-Remitente-A@300x-8.png',//Caso contrario, si el boton no esta presionado , te muetra esta imagen por defecto
                                  // Esta linea ajusta las propiedades de la imagen
                                  width: MediaQuery.of(context).size.width * 0.135,
                                ),

                                Text('Guía de Remisión',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: isButtonPressed5 ? Colors.white : Color(0xFF115B84), fontSize: 13,),),
                                Text('(Remitente)',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: isButtonPressed5 ? Colors.white : Color(0xFF115B84), fontSize: 12,),),
                              ],
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            isButtonPressed6 = true;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            isButtonPressed6 = false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BillScreen()),);
                        },
                        onTapCancel: () {
                          setState(() {
                            isButtonPressed6 = false;
                          });
                        },
                        child:  Container(

                          width: MediaQuery.of(context).size.width*0.4,
                          height: MediaQuery.of(context).size.width*0.28,
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.symmetric(vertical: 10.0),

                          decoration: BoxDecoration(
                              color: isButtonPressed6 ? Color(0xFF00B7F1) : Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(10),
                              //shape: BoxShape.rectangle,

                              boxShadow:[
                                BoxShadow (
                                    color: Colors.white,
                                    offset: Offset(-2,-2),
                                    blurRadius: 2, //Suavizar la sombra
                                    spreadRadius: 2
                                ),
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(2,2),
                                    blurRadius: 1,
                                    spreadRadius: 1
                                )
                              ]
                          ),

                          child: Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  isButtonPressed6
                                      ? 'assets/images/G-R-Transportistas-B@300x-8.png'//Si el boton esta presionado se muestra esta imagen
                                      : 'assets/images/G-R-Transportistas-A@300x-8.png',//Caso contrario, si el boton no esta presionado , te muetra esta imagen por defecto
                                  // Esta linea ajusta las propiedades de la imagen
                                  width: MediaQuery.of(context).size.width * 0.135,
                                ),

                                Text('Guía de Remisión',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: isButtonPressed6 ? Colors.white : Color(0xFF115B84), fontSize: 13,),),
                                Text('(Transportistas)',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: isButtonPressed6 ? Colors.white : Color(0xFF115B84), fontSize: 12,),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //////////////////////////////////////////////// BARRA LATERAL MENU//////////////////////////////////////////////
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              transform: Matrix4.translationValues(_isMenuOpen ? 100 : 400, 0, 0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
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
               margin: EdgeInsets.only(right: 5.0),
                decoration: BoxDecoration(
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

  //Primera vez
  Future<void> getParameterAccess() async{
    User = await Utils().readSharedPreferences('access_parameters');
  }
}




