import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lya_encuestas/screens/menu_pages/bill_screen.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_products_screen.dart';
import 'package:lya_encuestas/widgets/background.dart';

class ElectronicBillAdditionalScreen extends StatefulWidget {
  final Map<String, dynamic> data4;

  //Nuevo emisor
  final Map<String, dynamic> emisor;

  const ElectronicBillAdditionalScreen({Key? key, required this.data4,required this.emisor}) : super(key: key);

  @override
  _ElectronicBillAdditionalScreenState createState() => _ElectronicBillAdditionalScreenState();//Creacion del estado
}
class _ElectronicBillAdditionalScreenState extends State<ElectronicBillAdditionalScreen> {

  late Map<String, dynamic> data4;
  List<Map<String, dynamic>> documentoDetalle = [];

  ///////CHECKBOXLISTTILE////
  bool condition1 = false;
  bool condition2= false;
  bool condition3 = false;
  bool condition4 = false;

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
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.05, 0),
                          //margin: const EdgeInsets.symmetric(horizontal: 20),
                          child:Text('Adicionales',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.05, 0),
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      child:Column(
                        children: [
                          CheckboxListTile(
                            value: condition1,
                            onChanged: (value){
                              setState(() {
                                condition1=value!;
                                print(condition1);
                              });
                            },
                            //activeColor:Colors.green,
                            title: Text("¿Agregar bolsas plasticas?",style:TextStyle(color: Colors.black26)),
                          ),

                          CheckboxListTile(
                            value: condition2,
                            onChanged: (value){
                              setState(() {
                                condition2=value!;
                                print(condition2);
                              });
                            },
                            //activeColor:Colors.green,
                            title: Text("¿Es anticipo?",style:TextStyle(color: Colors.black26)),
                          ),

                          CheckboxListTile(
                            value: condition3,
                            onChanged: (value){
                              setState(() {
                                condition3=value!;
                                print(condition3);
                              });
                            },
                            //activeColor:Colors.green,
                            title: Text("¿Aplica descuento global?",style:TextStyle(color: Colors.black26)),
                          ),

                          CheckboxListTile(
                            value: condition4,
                            onChanged: (value){
                              setState(() {
                                condition4=value!;
                                print(condition4);
                              });
                            },
                            //activeColor:Colors.green,
                            title: Text("¿Aplica IGV Mype? (Hoteles y Restaurantes)",style:TextStyle(color: Colors.black26)),
                          ),



                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.001,
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
                                            //Nuevo para el JSON
                                            widget.data4['totales'] = {
                                              //"valorICBPER":condition1 ? 1 : 0,
                                              "totalICBPER":30,
                                              "valorICBPER":30,
                                              "totalAnticipos": 40,
                                              "totalAnticipo": 40,
                                            };

                                            additionalApi(context,widget.emisor);
                                           // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BillScreen()),(route) => false);
                                          },
                                          child: const Text('Guardar',style: TextStyle(color:Colors.white),),
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
                                            //COMENTE AHORA
                                           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ElectronicBillProductsScreen(data3:Map.identity(),emisor:widget.emisor),),(route) => false);
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

  //"cantidaUnidades": int.parse(numberUnit.text),
  Future<void> additionalApi(BuildContext context,dynamic emisor) async {
    //Información del producto-Objeto detalle con variables
    final detalle = {
      "nombreProducto":   widget.data4["nombreProducto"],
      "codigoProducto":  widget.data4["codigoProducto"],
      "descripcion":      widget.data4["descripcion"],
      "unidadMedida":    widget.data4["unidadMedida"],
      "cantidaUnidades": widget.data4["cantidaUnidades"],
      "precioUnitario": widget.data4["precioUnitario"],
    };

    //El objeto detalle se agrega a la lista documentoDetalle
    documentoDetalle.add(detalle);

    final body = {
      "serieNumero": widget.data4['serieNumero'],
      "tipoDocumento":widget.data4['tipoDocumento'],
      "fechaEmision":widget.data4['fechaEmision'],
      "fechaVencimiento":widget.data4['fechaVencimiento'],
      //"formaPago":widget.data4['formaPago'],
      //"establecimientoAnexo":widget.data4['establecimientoAnexo'],


      "emisor": widget.emisor, // Utilizar el valor de emisor recibido
      //Informacion del cliente
      "cliente": widget.data4['cliente'],

      "moneda": widget.data4['moneda'],

      //Informacion del producto
      //"documentoDetalle": documentoDetalle,


      //Adicionales
      "totales": widget.data4['totales'],

      //Leyenda
      "leyendas":widget.data4['leyendas'],

      //Informacion del producto
      //"documentoDetalle": documentoDetalle,
      "documentoDetalle": widget.data4['documentoDetalle'],
    };

    final jsonDecode = json.encode(body);
    //print(body);
    print(jsonDecode);

    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectronicBillCoinScreen(data2: data2),),);
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectronicBillAdditionalScreen (),),);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BillScreen()),(route) => false);
  }



}