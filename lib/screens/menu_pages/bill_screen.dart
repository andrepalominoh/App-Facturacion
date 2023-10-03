import 'dart:convert';

import 'package:flutter/material.dart';
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




class BillScreen extends StatefulWidget {
  const BillScreen({Key? key}) : super(key: key);

  @override
  _BillScreenState createState() => _BillScreenState();//state creation
}
//state
class _BillScreenState extends State<BillScreen> {
  late ProgressDialog loading;

  final dateController = TextEditingController();//Primera fecha "Desde"
  final dateController2 = TextEditingController();//Primera fecha "Hasta"

  //Cambio de color en el boton del dialogo
  bool isDialogOpen = false;
  bool isDialogOpen2 = false;


  String _orderSelected= "";

  @override
  void initState(){
    super.initState();
    dateController.text= "";//Inicializamos o configuramos el controlador de actualizaciones de texto en vacio
    dateController2.text= "";

    //Busqueda- 19/07/2023
    filteredItems = items;
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

  //////BUSQUEDA/////////
  List<String> items = [
    '73956824',
    '75236895',
    '77852356',
    '71253669',
    '79845226',
    /*
    'Fig',
    'Grape',
    'Honeydew',
    'Jackfruit',
    'Kiwi'
     */
  ];
  List<String> filteredItems = [];

  void filterList(String query) {
    List<String> filteredList = [];
    filteredList.addAll(items.where((item) => item.toLowerCase().contains(query.toLowerCase())));
    setState(() {
      filteredItems = filteredList;
    });
  }
  ///////FIN DE BUSQUEDA////////



  @override
  Widget build(BuildContext context){

    //Cambio de color en el boton del dialogo
    Color buttonColor = isDialogOpen ?Color(0xFF115B84) : Color(0xFF119CBF);
    Color buttonColor2 = isDialogOpen2 ? Color(0xFF115B84) : Color(0xFF119CBF);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
        SingleChildScrollView(
             child:Background(
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
                     children:<Widget>[
                       Container(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                         child:Text('Registro Factura',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
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
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       //COMIENZO FECHA DESDE
                       Container(
                         width: MediaQuery.of(context).size.width*0.4,
                         height: MediaQuery.of(context).size.height*0.07,
                         margin: EdgeInsets.all(5.0),
                         padding: EdgeInsets.all(0.09),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15.0),
                           //border: Border.all(color: Colors.grey),
                         ),
                         child: TextField(
                           controller: dateController,
                           decoration: InputDecoration(
                               hintText: "Desde",
                               hintStyle: TextStyle(
                                   color: Color(0xFF6C7480),
                                   fontWeight: FontWeight.bold,
                               ),
                               filled: true,
                               suffixIcon: Icon(Icons.calendar_today,color: Colors.grey,),
                               enabledBorder:OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                   borderSide: BorderSide.none
                               ),
                               focusedBorder:  OutlineInputBorder(
                                 /////////Solo hize este cambio//////
                                  borderRadius: BorderRadius.circular(15),
                                   borderSide:BorderSide.none
                               )
                           ) ,
                           readOnly: true, //Solo lectura, el usuario no podra escribir en el campo
                           onTap: () async{
                             //FechaApi(context);

                             //showDatePicker muestra un cuadro de dialogo
                             //Declaramos una varible de tipo DateTime llamada "pickedDate",
                             //la cual almacena la fecha y hora
                             DateTime? pickedDate=await showDatePicker(context: context,
                               initialDate: DateTime.now(),
                               firstDate: DateTime(2000),
                               lastDate: DateTime(2101),
                             );
                             //Si el valor almacenado en pickedDate es diferente de null, se ejecuta lo que hay dentro del if.
                             //De lo contrario si el valor es igual  null te saldra un mensaje de "No se ha seleccionado nada"
                             if(pickedDate!=null){
                               //formateamos el pickedDate para que solo salga la fecha
                               String formattedDate= DateFormat("yyyy-MM-dd").format(pickedDate); //año-mes-dia
                               setState(() {
                                 //toString lo que hace es convertir la fecha que esta almacenada en formattedDate en una cadena y lo almacena en dateController.text
                                 dateController.text=formattedDate.toString();
                                 print(dateController.text);
                               });

                             }else{
                               print("No se ha seleccionado nada");
                             }
                           },
                         ),
                       ),

                       Container(
                         width: MediaQuery.of(context).size.width*0.4,
                         height: MediaQuery.of(context).size.height*0.07,
                         margin: EdgeInsets.all(5.0),
                         padding: EdgeInsets.all(0.09),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15.0),
                           //border: Border.all(color: Colors.grey),
                         ),
                         child: TextField(
                           controller: dateController2,
                           decoration: InputDecoration(
                               hintText: "Hasta",
                               hintStyle: TextStyle(
                                 color: Color(0xFF6C7480),
                                 fontWeight: FontWeight.bold,
                               ),
                               filled: true,
                               suffixIcon: Icon(Icons.calendar_today,color: Colors.grey,),
                               enabledBorder:OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                   borderSide: BorderSide.none
                               ),
                               focusedBorder:  OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(15),
                                   borderSide:BorderSide.none
                               )
                           ) ,
                           readOnly: true, //Solo lectura, el usuario no podra escribir en el campo
                           onTap: () async{
                             //FechaApi(context);

                             //showDatePicker muestra un cuadro de dialogo
                             //Declaramos una varible de tipo DateTime llamada "pickedDate",
                             //la cual almacena la fecha y hora
                             DateTime? pickedDate=await showDatePicker(context: context,
                               initialDate: DateTime.now(),
                               firstDate: DateTime(2000),
                               lastDate: DateTime(2101),
                             );
                             //Si el valor almacenado en pickedDate es diferente de null, se ejecuta lo que hay dentro del if.
                             //De lo contrario si el valor es igual  null te saldra un mensaje de "No se ha seleccionado nada"
                             if(pickedDate!=null){
                               //formateamos el pickedDate para que solo salga la fecha
                               String formattedDate= DateFormat("yyyy-MM-dd").format(pickedDate); //año-mes-dia
                               setState(() {
                                 //toString lo que hace es convertir la fecha que esta almacenada en formattedDate en una cadena y lo almacena en dateController.text
                                 dateController2.text=formattedDate.toString();
                               });

                             }else{
                               print("No se ha seleccionado nada");
                             }
                           },
                         ),
                       ),
                       //FIN FECHA HASTA
                     ],
                   ),

                   ////////////////////////////INICIO BUSQUEDA/////////////////////////////////
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Row(
                       children: [
                         Expanded(
                           child: TextField(
                             onChanged: filterList,
                             decoration: InputDecoration(
                               //labelText: 'Search',
                               hintText: "Factura",
                                 hintStyle: TextStyle(
                                   color: Color(0xFF6C7480),
                                   fontWeight: FontWeight.bold,
                                   fontSize: 13
                                 ),

                               suffixIcon: Icon(Icons.search),
                                 enabledBorder:OutlineInputBorder(
                                     borderSide: BorderSide.none
                                 ),
                                 focusedBorder:  OutlineInputBorder(
                                     borderSide:BorderSide.none
                                 )
                             ),
                           ),
                         ),

                         SizedBox(width: 1),
                         Expanded(
                           child: TextField(
                             //onChanged: filterList,
                             decoration: InputDecoration(
                               //labelText: 'Search',
                                 hintText: "Destinatario",
                                 hintStyle: TextStyle(
                                     color: Color(0xFF6C7480),
                                     fontWeight: FontWeight.bold,
                                     fontSize: 13
                                 ),

                                 suffixIcon: Icon(Icons.search),
                                 enabledBorder:OutlineInputBorder(
                                     borderSide: BorderSide.none
                                 ),
                                 focusedBorder:  OutlineInputBorder(
                                     borderSide:BorderSide.none
                                 )
                             ),
                           ),
                         ),

                         SizedBox(width: 1),

                         Expanded(
                           child: TextField(
                             // onChanged: filterList,
                             decoration: InputDecoration(
                               //labelText: 'Search',
                                 hintText: "Fecha",
                                 hintStyle: TextStyle(
                                     color: Color(0xFF6C7480),
                                     fontWeight: FontWeight.bold,
                                     fontSize: 13
                                 ),

                                 suffixIcon: Icon(Icons.search),
                                 enabledBorder:OutlineInputBorder(
                                     borderSide: BorderSide.none
                                 ),
                                 focusedBorder:  OutlineInputBorder(
                                     borderSide:BorderSide.none
                                 )
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),


                   Divider(
                     color: Color(0xFF115B84),
                     indent: 20,
                     endIndent: 20,
                   ),

                    //BUSQUEDA////
                 /*
                   Expanded(
                       child: ListView.builder(
                         itemCount: filteredItems.length,
                         itemBuilder: (BuildContext context, int index) {
                           return ListTile(
                             title: Text(filteredItems[index]),
                           );
                         },
                       ),
                     ),
                   */


                   ////////FIN DE BUSQUEDA//////////////////////////////////////
                   SizedBox(
                     height: MediaQuery.of(context).size.height*0.2,
                   ),

                   const Center(child: Text("Presione en Emitir nueva factura para agregar una nueva factura", textAlign: TextAlign.center,
                       style: TextStyle(color: Color(0xFFD6D6D6))),),
                   Column(
                     children: [
                       Row(
                           children:<Widget>[
                             Expanded(
                               child: Container(
                                 margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.width * 0, MediaQuery.of(context).size.width * 0.2, 0),
                                 child:OutlinedButton.icon(
                                   onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillDataScreen()),(route) => false);
                                   },
                                   icon: const Icon(
                                     Icons.add,
                                     size: 20.0,
                                   ),
                                   label: const Text('Emitir nueva factura',style: TextStyle(color: Color(0xFF0EB1E6)),),
                                   style: OutlinedButton.styleFrom(
                                       shape: const StadiumBorder(),
                                       side: const BorderSide( color: Color(0xFF0EB1E6),)
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
                                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyInitScreen()),(route) => false);
                                   },
                                   child: const Text('Volver',style: TextStyle(color: Color(0xFF0EB1E6))),
                                   style: OutlinedButton.styleFrom(
                                       shape: const StadiumBorder(),
                                       side: const BorderSide(color: Color(0xFF0EB1E6),)
                                   ),
                                 ),
                               ),
                             ),
                           ]
                       ),
                     ],
                   ),





                   Expanded(child: Container()),
                   Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       //crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Expanded(
                           child: Container(
                             width: MediaQuery.of(context).size.width*0.25,
                             height: MediaQuery.of(context).size.width*0.15,
                             margin: EdgeInsets.symmetric(vertical:0),
                             decoration: BoxDecoration(
                               color: Color(0xFF119CBF),
                               borderRadius: BorderRadius.circular(0),
                             ),
                             child: TextButton(
                               onPressed: () {
                                 //Cambio de color en el boton del dialogo
                                 setState(() {
                                   isDialogOpen = true;
                                 });
                                 showDialog(
                                   barrierDismissible: false,//Impide que me salga del cuadro de dialogo al pulsar fuera del cuadro de dialogo
                                   context: context,
                                   builder: (BuildContext context) {
                                     return AlertDialog(
                                       title: Text("Enviar",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0277BD))),

                                       actions: [ //Creacion de botones dentro del cuadro de dialogo
                                         Column(
                                           children: [
                                             Row(
                                                 children:<Widget>[
                                                   Expanded(
                                                     child: Container(
                                                       margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,MediaQuery.of(context).size.width * 0, MediaQuery.of(context).size.width * 0.1, 0),
                                                       child: OutlinedButton(
                                                         onPressed: (){
                                                           print("si");
                                                          // Navigator.pop(context);//El pop nos permite salir del cuadro de dialogo y nos muestra la pantalla que esta por debajo de ella
                                                           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillContentScreen()),(route) => false);
                                                         },
                                                         child: const Text('PDF',style: TextStyle(color:Colors.white),),
                                                         style: OutlinedButton.styleFrom(
                                                           shape: const StadiumBorder(),
                                                           side: BorderSide.none,
                                                           backgroundColor: Colors.lightBlueAccent,
                                                           //backgroundColor: isButtonPressed ? Color(0xFF115B84) : Color(0xFF119CBF),
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
                                                       margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.1, 0),
                                                       child: OutlinedButton(
                                                         onPressed: (){
                                                           print("si");
                                                           Navigator.pop(context);//El pop nos permite salir del cuadro de dialogo y nos muestra la pantalla que esta por debajo de ella
                                                           //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillDataScreen()),(route) => false);
                                                           setState(() {
                                                             isDialogOpen = false;
                                                           });
                                                         },
                                                         child: const Text('Imagen'),
                                                         style: OutlinedButton.styleFrom(
                                                             shape: const StadiumBorder(),
                                                             side: const BorderSide(color: Colors.lightBlueAccent)
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                 ]
                                             ),
                                           ],
                                         ),
                                       ],
                                       //Para darle bordes al cuadro de dialogo
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(10.0),
                                       ),

                                     );
                                   },

                                 );

                                 print("Button pressed");
                               },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: buttonColor,
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(
                                     Icons.send,
                                     size: 20,
                                     color: Colors.white,
                                   ),
                                   //SizedBox(height: 5),
                                   Text(
                                     'Enviar',
                                     style: TextStyle(
                                       fontSize: 10,
                                       color: Colors.white,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),


                         const SizedBox(
                           width: 1.0,
                         ),

                         Expanded(
                           child: Container(
                             width: MediaQuery.of(context).size.width*0.25,
                             height: MediaQuery.of(context).size.width*0.15,
                             margin: EdgeInsets.symmetric(vertical:0),
                             decoration: BoxDecoration(
                               color: Color(0xFF119CBF),
                               borderRadius: BorderRadius.circular(0),
                             ),
                             child: TextButton(
                               onPressed: () {
                                 //Cambio de color en el boton del dialogo
                                 setState(() {
                                   isDialogOpen2 = true;
                                 });
                                 showDialog(
                                   barrierDismissible: false,//Impide que me salga del cuadro de dialogo al pulsar fuera del cuadro de dialogo
                                   context: context,
                                   builder: (BuildContext context) {
                                     return AlertDialog(
                                       title: Column(
                                         children: [
                                           Text("Orden de Compra/",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0277BD))),
                                           Text("Tamaño de comprobante",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0277BD))),
                                         ],
                                       ),
                                       content: Container(
                                         constraints: BoxConstraints(
                                           maxHeight: 50, // Establece la altura máxima deseada
                                         ),
                                         child: Column(
                                           children: [
                                             Padding(padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, MediaQuery.of(context).size.width * 0.01, 0),
                                               //margin: const EdgeInsets.symmetric(horizontal: 20),
                                               child: const TextField(
                                                   decoration: InputDecoration(
                                                     hintText: "Orden de Compra/Servicio",
                                                     hintStyle: TextStyle(color: Colors.black26,fontSize: 15),
                                                   ),
                                                   obscureText: false
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),

                                       actions: [ //Creacion de botones dentro del cuadro de dialogo
                                         Row(
                                           children: <Widget>[
                                             Expanded(
                                               child:Container(
                                                 margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, 0,MediaQuery.of(context).size.width*0.2, 0),
                                                 // margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.5,MediaQuery.of(context).size.width * 0.2, 25, 25),
                                                 child: Text('Tamaño de impresión de comprobante:', style: TextStyle(color: Colors.black26,fontSize: 15),),
                                               ),
                                             )

                                           ],
                                         ),
                                         SizedBox(
                                           height: 30,
                                         ),

                                         Row(
                                           children: [
                                             Container(
                                                 width: MediaQuery.of(context).size.width * 0.5,
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
                                                     items: <String> ["Tamaño A4","Tamaño A3","Tamaño A2"]
                                                         .map((i) => DropdownMenuItem<String>(
                                                       value: i,
                                                       child:  Text(i,style: const TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                                                     ))
                                                         .toList(),
                                                     hint:
                                                     _orderSelected==""? //Si _orderSelected3 es igual a una cadena vacia se imprime  "Contado"
                                                     const Text( "Tamaño A4", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                                                     )
                                                         : Text(_orderSelected// De lo contrario contrario se imprime este texto
                                                     ),
                                                     onChanged: (value){
                                                       print(value);
                                                       /*setState((){
                          _orderSelected=value.toString();
                        });*/
                                                     }
                                                 )
                                             ),
                                           ],
                                         ),
                                         Column(
                                           children: [
                                             Row(
                                                 children:<Widget>[
                                                   Expanded(
                                                     child: Container(
                                                       margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.width * 0.1, 0),
                                                       child: OutlinedButton(
                                                         onPressed: (){
                                                           print("si");
                                                           Navigator.pop(context);//El pop nos permite salir del cuadro de dialogo y nos muestra la pantalla que esta por debajo de ella
                                                           // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillCoinScreen()),(route) => false);
                                                           setState(() {
                                                             isDialogOpen2 = false;
                                                           });

                                                         },
                                                         child: const Text('Imprimir',style: TextStyle(color:Colors.white),),
                                                         style: OutlinedButton.styleFrom(
                                                           shape: const StadiumBorder(),
                                                           side: BorderSide.none,
                                                           backgroundColor: Colors.lightBlueAccent,
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
                                                       margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.1, 0),
                                                       child: TextButton(
                                                         onPressed: (){
                                                           print("si");
                                                           Navigator.pop(context);//El pop nos permite salir del cuadro de dialogo y nos muestra la pantalla que esta por debajo de ella
                                                           //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillDataScreen()),(route) => false);
                                                           setState(() {
                                                             isDialogOpen2 = false;
                                                           });
                                                         },
                                                         child: const Text('Salir'),
                                                         style: OutlinedButton.styleFrom(
                                                             shape: const StadiumBorder(),
                                                             side: const BorderSide(color: Colors.lightBlueAccent)
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                 ]
                                             ),
                                           ],
                                         ),
                                       ],
                                       //Para darle bordes al cuadro de dialogo
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(10.0),
                                       ),
                                     );            //AlertDialog
                                   },
                                 );

                                 print("Button pressed");
                               },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: buttonColor2,
                               ),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(
                                     Icons.print,
                                     size: 20,
                                     color: Colors.white,
                                   ),
                                   //SizedBox(height: 5),
                                   Text(
                                     'Imprimir',
                                     style: TextStyle(
                                       fontSize: 10,
                                       color: Colors.white,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),

                         const SizedBox(
                           width: 1.0,
                         ),

                         Expanded(
                           child: Container(
                             width: MediaQuery.of(context).size.width*0.25,
                             height: MediaQuery.of(context).size.width*0.15,

                           margin: EdgeInsets.symmetric(vertical:0),
                           decoration: BoxDecoration(
                             color: Color(0xFF119CBF),
                             borderRadius: BorderRadius.circular(0),
                           ),
                           child: TextButton(
                             onPressed: () {
                               print("Button pressed");
                             },
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(
                                   Icons.save,
                                   size: 20,
                                   color: Colors.white,
                                 ),
                                 //SizedBox(height: 5),
                                 Text(
                                   'Guardar',
                                   style: TextStyle(
                                     fontSize: 10,
                                     color: Colors.white,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         ),

                         const SizedBox(
                           width: 1.0,
                         ),

                         Expanded(
                           child: Container(
                             width: MediaQuery.of(context).size.width*0.25,
                             height: MediaQuery.of(context).size.width*0.15,

                           decoration: BoxDecoration(
                             color: Color(0xFF119CBF),
                             borderRadius: BorderRadius.circular(0),
                           ),
                           child: TextButton(
                             onPressed: () {
                               print("Button pressed");
                             },
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(
                                   Icons.cleaning_services,
                                   size: 20,
                                   color: Colors.white,
                                 ),
                                 //SizedBox(height: 5),
                                 Text(
                                   'Limpiar',
                                   style: TextStyle(
                                     fontSize: 10,
                                     color: Colors.white,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         ),
                       ]
                   ),

                   //AQUI

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


/*
void _mostrarAlerta(BuildContext context){
  //Primera lista desplegable
  String _orderSelected= "";
  showDialog(
      barrierDismissible: false,//Impide que me salga del cuadro de dialogo al pulsar fuera del cuadro de dialogo
      context: context,
      builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Text("Orden de compra/",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0277BD))),
            Text("Tamaño de comprobante",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0277BD))),
          ],
        ),
        content: Container(
          constraints: BoxConstraints(
            maxHeight: 50, // Establece la altura máxima deseada
          ),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, 0, MediaQuery.of(context).size.width * 0.01, 0),
              //margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Orden de compra/Servicio",
                    hintStyle: TextStyle(color: Colors.black26,fontSize: 15),
                  ),
                  obscureText: false
              ),
            ),
          ],
        ),
        ),

        actions: [ //Creacion de botones dentro del cuadro de dialogo
          Row(
            children: <Widget>[
              Expanded(
              child:Container(
                margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, 0,MediaQuery.of(context).size.width*0.2, 0),
                // margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.5,MediaQuery.of(context).size.width * 0.2, 25, 25),
                child: Text('Tamaño de impresion de comprobante:', style: TextStyle(color: Colors.black26,fontSize: 15),),
              ),
              )

            ],
          ),
          SizedBox(
            height: 30,
          ),

          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
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
                      items: <String> ["Tamaño A4","Tamaño A3","Tamaño A2"]
                          .map((i) => DropdownMenuItem<String>(
                        value: i,
                        child:  Text(i,style: const TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),),
                      ))
                          .toList(),
                      hint:
                      _orderSelected==""? //Si _orderSelected3 es igual a una cadena vacia se imprime  "Contado"
                      const Text( "Tamaño A4", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                      )
                          : Text(_orderSelected// De lo contrario contrario se imprime este texto
                      ),
                      onChanged: (value){
                        print(value);
                        /*setState((){
                          _orderSelected=value.toString();
                        });*/
                      }
                  )
              ),
            ],
          ),
          Column(
            children: [
              Row(
                  children:<Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.width * 0.1, 0),
                        child: OutlinedButton(
                          onPressed: (){
                            print("si");
                            Navigator.pop(context);//El pop nos permite salir del cuadro de dialogo y nos muestra la pantalla que esta por debajo de ella
                            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillCoinScreen()),(route) => false);


                          },
                          child: const Text('Imprimir',style: TextStyle(color:Colors.white),),
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: BorderSide.none,
                            backgroundColor: Colors.lightBlueAccent,
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
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.1, 0),
                        child: TextButton(
                          onPressed: (){
                            print("si");
                            Navigator.pop(context);//El pop nos permite salir del cuadro de dialogo y nos muestra la pantalla que esta por debajo de ella
                            //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillDataScreen()),(route) => false);
                          },
                          child: const Text('Salir'),
                          style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: const BorderSide(color: Colors.lightBlueAccent)
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ],
        //Para darle bordes al cuadro de dialogo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );            //AlertDialog
      },
  );
}
*/



void _mostrarAlerta2(BuildContext context){//El contex es el mismo que esta en el boton
  showDialog(
      barrierDismissible: false,//Impide que me salga del cuadro de dialogo al pulsar fuera del cuadro de dialogo
      context: context,
      builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enviar",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0277BD))),

        actions: [ //Creacion de botones dentro del cuadro de dialogo
          Column(
            children: [
              Row(
                  children:<Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,MediaQuery.of(context).size.width * 0, MediaQuery.of(context).size.width * 0.1, 0),
                        child: OutlinedButton(
                          onPressed: (){
                            print("si");
                            Navigator.pop(context);//El pop nos permite salir del cuadro de dialogo y nos muestra la pantalla que esta por debajo de ella
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillContentScreen()),(route) => false);
                          },
                          child: const Text('PDF',style: TextStyle(color:Colors.white),),
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: BorderSide.none,
                            backgroundColor: Colors.lightBlueAccent,
                            //backgroundColor: isButtonPressed ? Color(0xFF115B84) : Color(0xFF119CBF),
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
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.1, 0),
                        child: OutlinedButton(
                          onPressed: (){
                            print("si");
                            Navigator.pop(context);//El pop nos permite salir del cuadro de dialogo y nos muestra la pantalla que esta por debajo de ella
                            //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillDataScreen()),(route) => false);
                          },
                          child: const Text('Imagen'),
                          style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: const BorderSide(color: Colors.lightBlueAccent)
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ],
          ),
        ],
        //Para darle bordes al cuadro de dialogo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),

      );
      },

  );
}




