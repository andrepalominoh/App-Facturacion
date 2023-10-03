import 'package:flutter/material.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_information_customer_screen.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_products_screen.dart';
import 'package:lya_encuestas/widgets/background.dart';
import 'package:http/http.dart' as http;
import '../../assets/constants.dart';
import 'package:lya_encuestas/screens/menu_pages/bill_screen.dart';

class ElectronicBillCoinScreen extends StatefulWidget {

  //final Map<String, String> data2;
  final Map<String, dynamic> data2;

  final dynamic emisor;


  //const ElectronicBillCoinScreen({Key? key}) : super(key: key);
  const ElectronicBillCoinScreen({Key? key, required this.data2, required this.emisor}) : super(key: key);


  @override
  _ElectronicBillCoinScreenState createState() => _ElectronicBillCoinScreenState();//Creacion del estado
}
class _ElectronicBillCoinScreenState extends State<ElectronicBillCoinScreen> {

  late Map<String, dynamic> data2;//Nuevo

  //LISTAS DESPLEGABLES
  //Primera lista desplegable
  String _orderSelected= "";
  //Primera lista desplegable
  String _orderSelected2= "";

  //BARRA DE NAVEGACIÓN LATERAL
  bool _isMenuOpen = false;
  //Se ejecuta la funcion toggleMenu cuando el usuario presione el icono
  void toggleMenu() {//Palanca
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    data2 = Map<String, dynamic>.from(widget.data2);
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
                          child:Text('Moneda',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height:16,
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
                                items: <String> ["Soles","Euro","Dolar Americano","Libra Esterlina"]
                                    .map((i) => DropdownMenuItem<String>(
                                  value: i,
                                  child:  Text(i,style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6C7480)),),
                                ))
                                    .toList(),
                                hint:
                                _orderSelected==""? //Si _orderSelected3 es igual a una cadena vacia se imprime  "Soles"
                                const Text( "Soles", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF6C7480)),
                                )
                                    : Text(_orderSelected// De lo contrario contrario se imprime este texto
                                ),
                                onChanged: (value){
                                  setState((){
                                    _orderSelected=value.toString();
                                    //print(value);
                                  });
                                }
                            )
                        ),
                      ],
                    ),

                    Padding(
                      //padding: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20),//Espacio de relleno entre el Scaffold y el padding
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, 0,MediaQuery.of(context).size.width*0.2, 0),
                            // margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.5,MediaQuery.of(context).size.width * 0.2, 25, 25),
                            child: Text(
                              'Tipo de Cambio',
                              style: TextStyle(color: Colors.black26),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'S/00.00',
                                hintStyle: TextStyle(color: Colors.black26),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height:20,
                    ),

                    Padding(
                      //padding: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20),//Espacio de relleno entre el Scaffold y el padding
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, 0,MediaQuery.of(context).size.width*0.2, 0),
                            // margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.5,MediaQuery.of(context).size.width * 0.2, 25, 25),
                            child: Text(
                              'Tipo de Operacion*',
                              style: TextStyle(color: Colors.black26),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height:20,
                    ),


                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
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

                                items: <String> ["00000000","476567575", "7655","4566"]
                                    .map((i) => DropdownMenuItem<String>(
                                  value: i,
                                  child:  Text(i,style: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF6C7480)),),
                                ))
                                    .toList(),
                                hint:
                                _orderSelected2==""? //Si _orderSelected es igual a una cadena vacia se imprime  "0000000"
                                const Text( "0000000", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF6C7480)),
                                )
                                    : Text(_orderSelected2// De lo contrario contrario se imprime este texto
                                ),
                                onChanged: (value){
                                  setState(() {
                                    _orderSelected2=value.toString();
                                    //print(value);
                                  });
                                }
                            )
                        ),
                      ],
                    ),

                    SizedBox(
                      height:50,
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

                                      coinApi(context,widget.emisor);
                                      //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillProductsScreen()),(route) => false);
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
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  ElectronicBillInformationCustomerScreen(data: data2,emisor:widget.emisor,)),(route) => false);
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

  Future<void> coinApi(BuildContext context, dynamic emisor) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      // "Authorization": "Bearer token"
    };

    const url = Constants.API_URL + Constants.API_REQUEST_POST_GET_TOKEN;

    final body = {

    //  "serieNumero": data2['serieNumero'],
     // "cliente": data2['cliente'],

/*
      "cliente":{
        "tipoDocumentoIdentidad":data2['tipoDocumentoIdentidad'],
        "numeroDocumentoIdentidad":data2['numeroDocumentoIdentidad'],
      },
*/
     // "documentoIdentidad":_orderSelected,

      "serieNumero": widget.data2['serieNumero'],
      "tipoDocumento":widget.data2['tipoDocumento'],
      "fechaEmision":widget.data2['fechaEmision'],
      "fechaVencimiento":widget.data2['fechaVencimiento'],
      //"formaPago":widget.data2['formaPago'],
      //"establecimientoAnexo":widget.data2['establecimientoAnexo'],

      //Nuevo emisor
      "emisor": widget.emisor,

      //Informacion del cliente
      "cliente": widget.data2['cliente'],

      "moneda": _orderSelected,


    };
    print(body);
    //COMENTE AHORA
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectronicBillProductsScreen(data3: body ,emisor: widget.emisor),),);

    //final response = await http.post(Uri.parse(url), headers: headers, body: body);

  }




}