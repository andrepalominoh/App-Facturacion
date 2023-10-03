import 'package:flutter/material.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_coin_screen.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_data_screen.dart';
import 'package:lya_encuestas/screens/menu_pages/bill_screen.dart';
import 'package:lya_encuestas/widgets/background.dart';


import '../../assets/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lya_encuestas/assets/utils.dart';

class ElectronicBillInformationCustomerScreen extends StatefulWidget {

  final Map<String, dynamic> data; //En la variable data recibimos el valor de la otra clase
  //Nuevo
  final dynamic emisor;

  //const ElectronicBillInformationCustomerScreen({Key? key}) : super(key: key);
  //NUEVO
  const ElectronicBillInformationCustomerScreen({Key? key, required this.data, required this.emisor}) : super(key: key);

  @override
  _ElectronicBillInformationCustomerScreenState createState() => _ElectronicBillInformationCustomerScreenState();//Creacion del estado
}
class _ElectronicBillInformationCustomerScreenState extends State<ElectronicBillInformationCustomerScreen> {

  //Nuevo para la creacion del JSON
  late Map<String, dynamic> data;
  //Nuevo
  late dynamic emisor;



  //CLIENTE
  String _orderSelected= "";
  final _numeroDocumentoIdentidad = TextEditingController();
  final razonSocial = TextEditingController();
  final direccionCompleta= TextEditingController();
  final correoElectronico= TextEditingController();
  //Codificación dura
  String hardNombreComercial= "EN EL CORPORACION";
  String hardUrbanizacion= "URB. LOS SAUCES";
  String hardCodigoUbigeo= "150101";
  String hardDepartamento= "LIMA";
  String hardProvincia= "LIMA";
  String hardDistrito= "LIMA";
  String hardCodigoPais= "PE";





  //BARRA DE NAVEGACIÓN LATERAL
  bool _isMenuOpen = false;
  //Se ejecuta la funcion toggleMenu cuando el usuario presione el icono
  void toggleMenu() {//Palanca
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  //Nuevo para la creacion del JSON
  @override
  void initState() {
    super.initState();
    data = Map<String, dynamic>.from(widget.data);

    //Nuevo
    emisor = widget.emisor;
  }

  @override
  void dispose() {
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Background(
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
                          child:Text('FACTURA ELECTRÓNICA',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                        ),
                      ],
                    ),

                    //Linea horizontal
                    const Divider(
                      color: Color(0xFF115B84),
                      indent: 20,
                      endIndent: 20,
                    ),

                    Row(
                      children:<Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child:Text('Información del cliente',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height:16,
                    ),

                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin: const EdgeInsets.only(left: 20),
                            //Creacion de una lista desplegable
                            child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(fontSize: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true, //Permiso para pintar el campo de texto
                                  contentPadding: const EdgeInsets.only(left: 10),//Hay un espacio de 10 pixeles entre el campo de texto y texto ingresado
                                  fillColor: Colors.grey[200],
                                ),

                                items: <String> ["DNI", "PASAPORTE","RUC","CARNET DE EXTRANJERIA"]
                                    .map((i) => DropdownMenuItem<String>(
                                  value: i,
                                  child:  Text(i,style: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF6C7480)),),
                                ))
                                    .toList(),
                                hint:
                                _orderSelected==""? //Si _orderSelected3 es igual a una cadena vacia se imprime  "DNI"
                                const Text( "DNI", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF6C7480)),
                                )
                                    : Text(_orderSelected// De lo contrario contrario se imprime este texto
                                ),
                                onChanged: (value){
                                  setState(() {
                                    _orderSelected=value.toString();
                                   // print( _orderSelected);
                                  });
                                }
                            )
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child:  TextField(
                           controller: _numeroDocumentoIdentidad,
                              decoration: InputDecoration(
                                hintText: "0000000000",
                                hintStyle: TextStyle(color: Colors.black26),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                ),
                              ),
                              obscureText: false
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child:  TextField(
                              controller: razonSocial,
                              decoration: InputDecoration(
                                hintText: "Nombre/Razón Social",
                                hintStyle: TextStyle(color: Colors.black26),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                ),
                              ),
                              obscureText: false
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child:  TextField(
                              controller: direccionCompleta,
                              decoration: InputDecoration(
                                hintText: "Dirección",
                                hintStyle: TextStyle(color: Colors.black26),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                ),
                              ),
                              obscureText: false
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                              controller:correoElectronico,
                              decoration: InputDecoration(
                                hintText: "Correo Cliente",
                                hintStyle: TextStyle(color: Colors.black26),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                ),
                              ),
                              obscureText: false
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const TextField(
                              decoration: InputDecoration(
                                hintText: "N° Celular",
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

                    Column(
                      children: [
                        Row(
                            children:<Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.width * 0.2, 0),
                                  child: OutlinedButton(
                                    onPressed: (){
                                      //data = widget.data;

                                      //Nuevo para el JSON
                                      data['cliente'] = {
                                        "tipoDocumentoIdentidad": _orderSelected,
                                        "numeroDocumentoIdentidad": _numeroDocumentoIdentidad.text,
                                        //Comentado el dia 14/07/2023

                                        "nombreComercial": hardNombreComercial,
                                        "razonSocial": razonSocial.text,
                                        "direccionCompleta": direccionCompleta.text,
                                        "urbanizacion": hardUrbanizacion,
                                        "codigoUbigeo": hardCodigoUbigeo,
                                        "departamento": hardDepartamento,
                                        "provincia": hardProvincia,
                                        "distrito": hardDistrito,
                                        "codigoPais": hardCodigoPais,
                                        "correoElectronico": correoElectronico.text,



                                      };

                                      informationCustomerApi(context);
                                      //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillCoinScreen()),(route) => false);
                                    },
                                    child: const Text('Siguiente',style: TextStyle(color:Colors.white),),
                                    style: OutlinedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none,
                                      backgroundColor: Color(0xFF0EB1E6),
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
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillDataScreen()),(route) => false);
                                    },
                                    child: const Text('Volver'),
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


  Future<void> informationCustomerApi(BuildContext context) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      // "Authorization": "Bearer token"
    };

    const url = Constants.API_URL + Constants.API_REQUEST_POST_GET_TOKEN;

    final body = {

      "serieNumero": data['serieNumero'],
      "tipoDocumento":data['tipoDocumento'],
      "fechaEmision":data['fechaEmision'],
      "horaEmision":data['horaEmision'],
      "fechaVencimiento":data['fechaVencimiento'],
      "tipoOperacion":data['tipoOperacion'],
      //"formaPago":data['formaPago'],

     // "establecimientoAnexo":data['establecimientoAnexo'],
      // "documentoIdentidad":_orderSelected,
      "emisor": widget.emisor,

       //Customer information
      "cliente": data['cliente'],



/*
      "cliente":{
        "tipoDocumentoIdentidad":_orderSelected,
        "numeroDocumentoIdentidad":_numeroDocumentoIdentidad.text,
      }
*/

    };
    print(body);


    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectronicBillCoinScreen(data2:body, emisor: widget.emisor),),);



    //final response = await http.post(Uri.parse(url), headers: headers, body: body);

  }







}





