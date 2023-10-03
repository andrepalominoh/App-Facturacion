import 'package:flutter/material.dart';
import 'package:lya_encuestas/classes/http/services/user_service.dart';
import 'package:lya_encuestas/screens/menu_pages/bill_screen.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_additional.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_information_customer_screen.dart';
import 'package:lya_encuestas/widgets/background.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lya_encuestas/assets/utils.dart';
import 'package:lya_encuestas/assets/constants.dart';


class ElectronicBillDataScreen extends StatefulWidget {
  const ElectronicBillDataScreen({Key? key}) : super(key: key);

  @override
  _ElectronicBillDataScreenState createState() => _ElectronicBillDataScreenState();


}
class _ElectronicBillDataScreenState extends State<ElectronicBillDataScreen>{

  //INICIO FECHA
  //Creamos un objeto de tipo TextEditingController llamado "dateController"
  final dateController = TextEditingController();//Primera fecha "Desde"
  final dateController2 = TextEditingController();//Primera fecha "Hasta"

  String? selectedValue="1";

  @override
  void initState(){
    super.initState();
    dateController.text= "";//Inicializamos o configuramos el controlador de actualizaciones de texto en vacio
    dateController2.text= "";
  }//FIN FECHA


  //LISTAS DESPLEGABLES
  //Primera lista desplegable
  String numeroDocumentoIdentidad= "";

  //CODIFICACION DURA INICIO
  String hardSerieNumero= "F012-99901281";
  String hardTipoDocumento= "01";
  String hardHoraEmision= "10:38:00";
  String hardTipoOperacion= "0101";
  //emisor
  String hardTipoDocumentoIdentidad= "6";
  String hardRazonSocial= "TELEFONICA DEL PERÚ";
  String hardDomicilioFiscal= "xxx";
  String hardUrbanizacion= "xxx";
  String hardCodigoUbigeo= "150122";
  String hardDepartamento= "LIMA";
  String hardProvincia= "LIMA";
  String hardDistrito= "MIRAFLORES";
  String hardCodigoPais= "PE";
  String hardCodigoEstablecimientoAnexo= "0000";



  //Segunda lista desplegable
  String _orderSelected2= "";
  String tipoDocumento= "";

  //Tercera lista desplegable
  String _orderSelected3= "";

  //Cuarta lista desplegable
  String _orderSelected4= "";


  //BARRA DE NAVEGACIÓN LATERAL
  bool _isMenuOpen = false;
  //Se ejecuta la funcion toggleMenu cuando el usuario presione el icono
  void toggleMenu() {//Palanca
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  //Creacion del JSON emisor
  Map<String, dynamic> emisor = {};
  //Variables emisor
  final nombreComercial = TextEditingController(text: "TELEFONICA DEL PERU SAA");



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
            // Main Content
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
                          child:Text('FACTURA ELECTRÓNICAS',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
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
                          child:Text('Datos de la boletas',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height:16,
                    ),

                    Row(
                      children: [

                        Expanded(
                          flex:3,
                          child:Container(
                              width: double.infinity,//Me ayudo para que sea responsive
                              height: MediaQuery.of(context).size.height * 0.07,
                              margin: const EdgeInsets.only(left: 20),
                              //Creacion de una lista desplegable
                              child: DropdownButtonFormField(
                                  isExpanded: true, //Me ayudo para que sea responsive
                                  //isDense: true,  //Disminuye la altura vertical del textfield
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

                                  items: <String> ["Seleccionar","20100017491"]
                                      .map((i) => DropdownMenuItem<String>(
                                    value: i,
                                    child:  Text(i,style: const TextStyle(color: Color(0xFF6C7480) , fontWeight: FontWeight.bold,fontSize: 15),),
                                  ))
                                      .toList(),
                                  hint:
                                  numeroDocumentoIdentidad==""? //Si _orderSelected es igual a una cadena vacia se imprime  "2010001749"
                                  const Text( "20100017491", style: TextStyle(color: Color(0xFF6C7480),fontWeight: FontWeight.bold),)
                                      : Text(numeroDocumentoIdentidad// De lo contrario contrario se imprime este texto
                                  ),
                                  onChanged: (value){
                                    setState(() {
                                      numeroDocumentoIdentidad=value.toString();
                                       print(numeroDocumentoIdentidad);
                                    });
                                  }
                              )
                          ),
                        ),

                        const SizedBox(
                          width:4,
                        ),


                        Expanded(
                        flex:2,
                        child:Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.07,
                                // margin: const EdgeInsets.only(left: 20),
                                //Creacion de una lista desplegable
                                child: DropdownButtonFormField(
                                    isExpanded: true,
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

                                    items: <String> ["F001","F002", "FFF1"]
                                        .map((i) => DropdownMenuItem<String>(
                                      value: i,
                                      child:  Text(i,style: const TextStyle(color: Color(0xFF6C7480) , fontWeight: FontWeight.bold,),),
                                    ))
                                        .toList(),
                                    hint:
                                    _orderSelected2==""? //Si _orderSelected es igual a una cadena vacia se imprime  "F001"
                                    const Text( "F001", style: TextStyle(color: Color(0xFF6C7480) , fontWeight: FontWeight.bold),
                                    )
                                        : Text(_orderSelected2// De lo contrario se imprime este texto
                                    ),
                                    onChanged: (value){
                                      setState(() {
                                        if (value == "F001") {
                                          _orderSelected2 = "00010332";

                                        } else if(value == "F002"){
                                          _orderSelected2 = "00000004";
                                        } else if(value == "FFF1"){
                                          _orderSelected2 = "00000001";
                                        }else{
                                          _orderSelected2 = value.toString();
                                        }
                                        tipoDocumento=value.toString();

                                        print(tipoDocumento);//tipoDocumento
                                        print(_orderSelected2);//tipoOperacion
                                      });
                                    }
                                )
                            ),
                        ),

                        const SizedBox(
                          width:4,
                        ),

                        Expanded(
                          flex:2,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin: const EdgeInsets.only(right: 20),
                            child: TextField(

                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: '00000000',
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

                              controller: TextEditingController(text: _orderSelected2,),

                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                        height:8
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin: const EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(0.09),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),

                            child: Padding(
                              padding: EdgeInsets.only(bottom:0.5),
                              child: TextField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  hintText: "F.de Emisión *",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF6C7480),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  filled: true,
                                  suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat("yyyy-MM-dd").format(pickedDate);
                                    setState(() {
                                      dateController.text = formattedDate.toString();
                                      print(dateController.text);
                                    });
                                  } else {
                                    print("No se ha seleccionado nada");
                                  }
                                },
                              ),
                            ),
                          ),
                        ),



                        const SizedBox(
                          width: 4.0,
                        ),

                        Expanded(
                          flex: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin: const EdgeInsets.only(right: 20),
                            padding: EdgeInsets.all(0.09),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),

                            child: Padding(
                              padding: EdgeInsets.only(bottom:0.5),
                              child: TextField(
                                controller: dateController2,
                                decoration: InputDecoration(
                                  hintText: "F.de Vencimiento *",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF6C7480),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  filled: true,
                                  suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat("yyyy-MM-dd").format(pickedDate);
                                    setState(() {
                                      dateController2.text = formattedDate.toString();
                                      print(dateController2.text);
                                    });
                                  } else {
                                    print("No se ha seleccionado nada");
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height:8
                    ),

                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.3,
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

                                items: <String> ["Contado","Credito"]
                                    .map((i) => DropdownMenuItem<String>(
                                  value: i,
                                  child:  Text(i,style: const TextStyle(color: Color(0xFF6C7480) , fontWeight: FontWeight.bold),),
                                ))
                                    .toList(),
                                hint:
                                _orderSelected3==""? //Si _orderSelected3 es igual a una cadena vacia se imprime  "Contado"
                                const Text("Contado", style: TextStyle(color: Color(0xFF6C7480) , fontWeight: FontWeight.bold),
                                )
                                    : Text(_orderSelected3// De lo contrario contrario se imprime este texto
                                ),
                                onChanged: (value){
                                  setState(() {
                                    _orderSelected3=value.toString();
                                    print(_orderSelected3);
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
                              controller: nombreComercial,
                              decoration: InputDecoration(
                                hintText: "TELEFONICA DEL PERU SAA",
                                hintStyle: TextStyle(color: Colors.black26),
                              ),
                              enabled: false,
                              obscureText: false
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.07,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
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

                                items: <String> ["Seleccione","0000-AV BENAVIDES"]
                                    .map((i) => DropdownMenuItem<String>(
                                  value: i,
                                  child:  Text(i,style: const TextStyle(color: Color(0xFF6C7480) , fontWeight: FontWeight.bold),),
                                ))
                                    .toList(),
                                hint:
                                _orderSelected4==""? //Si _orderSelected es igual a una cadena vacia se imprime  "Establecimiento Anexo"
                                const Text( "Establecimiento Anexo", style: TextStyle(color: Color(0xFF6C7480) , fontWeight: FontWeight.bold),
                                )
                                    : Text(_orderSelected4// De lo contrario contrario se imprime este texto
                                ),
                                onChanged: (value){
                                  setState(() {
                                    if (value == "Seleccione") {
                                      _orderSelected4 = "Dirección Emisor";

                                    } else if(value == "0000-AV BENAVIDES"){
                                      _orderSelected4 = "AV BENAVIDES";
                                    }else{
                                      _orderSelected4 = value.toString();
                                    }
                                    //_orderSelected4=value.toString();
                                    print(_orderSelected4);
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
                              decoration: InputDecoration(
                                hintText: "AV BENAVIDES",
                                hintStyle: TextStyle(color: Colors.black26),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                ),
                              ),
                              //Nuevo
                              controller: TextEditingController(text: _orderSelected4),
                              enabled: false,
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
                                  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.width * 0.2, 0),
                                  child: OutlinedButton(
                                    onPressed: (){

                                      //Nuevo emisor
                                      emisor = {
                                        "tipoDocumentoIdentidad": hardTipoDocumentoIdentidad,
                                        "numeroDocumentoIdentidad": numeroDocumentoIdentidad,
                                        //Comentado el dia 14/07/2023

                                        "nombreComercial": nombreComercial.text,
                                        "razonSocial": hardRazonSocial,
                                        "domicilioFiscal": hardDomicilioFiscal,
                                        "direccionCompleta": _orderSelected4,
                                        "urbanizacion": hardUrbanizacion,
                                        "codigoUbigeo": hardCodigoUbigeo,
                                        "departamento": hardDepartamento,
                                        "provincia": hardProvincia,
                                        "distrito": hardDistrito,
                                        "codigoPais": hardCodigoPais,
                                        "codigoEstablecimientoAnexo": hardCodigoEstablecimientoAnexo,


                                      };
                                      //Nuevo emisor
                                      fechaApi(context,emisor);
                                   // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillInformationCustomerScreen()),(route) => false);
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
                                  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.width * 0, MediaQuery.of(context).size.width * 0.2, 0),
                                  child: OutlinedButton(
                                    onPressed: (){
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BillScreen()),(route) => false);
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

   Future<void> fechaApi(BuildContext context,Map<String, dynamic> emisor) async {


    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
     // "Authorization": "Bearer token"
    };

    const url = Constants.API_URL + Constants.API_REQUEST_POST_GET_TOKEN;

    final body = {
      //"serieNumero":_orderSelected,//Este valor viene de una lista desplegable
      //"tipoDocumento":tipoDocumento, //Este valor viene de una lista desplegable
      "serieNumero": hardSerieNumero,
      "tipoDocumento": hardTipoDocumento,
      "fechaEmision":dateController.text,
      "horaEmision":hardHoraEmision,
      "fechaVencimiento":dateController2.text,
      "tipoOperacion":hardTipoOperacion,

     // "formaPago":_orderSelected3 ,//Este valor viene de una lista desplegable
      //"establecimientoAnexo":_orderSelected4,

      //Nuevo emisor
      "emisor": emisor,


    };
    //print(body);


    final jsonDecode2 = jsonEncode(body);
    //print(body);
    print(jsonDecode2);

    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectronicBillInformationCustomerScreen (data:body),),);
    //Nuevo emisor
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectronicBillInformationCustomerScreen (data: body, emisor: emisor),),);


    //ESTE CODIGO ERA LA SOLUCIÓN A MIS PROBLEMAS
    final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
    //CON ESTE CODIGO ME SALE ERROR
    //final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      Utils().saveSharedPreferences('access_parameters', response.body);
      //print(response.statusCode);
      print(body);
    }

    if (response.statusCode == 400) {
      //print("Falló la autorización");
    }

  }

}





