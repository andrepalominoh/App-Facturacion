import 'package:flutter/material.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_additional.dart';
import 'package:lya_encuestas/screens/menu_pages/electronic_bill_coin_screen.dart';
import 'package:lya_encuestas/widgets/background.dart';
import 'dart:convert';
import 'package:lya_encuestas/screens/menu_pages/bill_screen.dart';
class ElectronicBillProductsScreen extends StatefulWidget {

  final Map<String, dynamic> data3;
  //Nuevo emisor
  final Map<String, dynamic> emisor;

  const ElectronicBillProductsScreen({Key? key, required this.data3,required this.emisor}) : super(key: key);

  @override
  _ElectronicBillProductsScreenState createState() => _ElectronicBillProductsScreenState();//Creacion del estado
}
class _ElectronicBillProductsScreenState extends State<ElectronicBillProductsScreen> {

  late Map<String, dynamic> data3;

  //CREACIÓN DEL ARRAY DE OBJETOS DOCUMENTO DETALLE
  List<Map<String, dynamic>> documentoDetalle = [];
  final  nameProduct= TextEditingController();
  final  codeProduct= TextEditingController();
  final  description= TextEditingController();
  final  unitMeasurement= TextEditingController();
  final  numberUnit= TextEditingController();//Cantidad
  final  precioUnitario= TextEditingController();
  //Nuevos valores para documento detalle
  String hardNumeroItem= "1";
  String hardCodigoProductoSunat= "60101726";
  String hardCodigoProductoGS1= "70101465";


  //Nuevos valores para documento detalle
  String hardValorVenta= "1000";
  String hardDatosAdicionalesDetalle= "";
  String hardSumatoriaImpuestoItem= "0";
  String hardIndicadorCargo= "";
  String hardCodigoCargo= "";
  String hardFactorCargo= "0";
  String hardMontoCargo= "0";
  String hardMontoBaseCargo= "0";

  //CREACIÓN DEL ARRAY DE OBJETOS DOCUMENTO LEYENDAS
  List<Map<String, dynamic>> leyendas = [];
  String hardcodigo= "1000";

  //CREACION DEL OBJETO precioVentaUnitario
  Map<String, dynamic> precioVentaUnitario = {};
  String hardMonto= "1180";
  String hardCodigo= "01";

  //CREACION DEL OBJETO igv
  Map<String, dynamic> igv = {};
  String hardMonto2= "180";
  String harAfectacion= "10";


  //BARRA DE NAVEGACIÓN LATERAL
  bool _isMenuOpen = false;
  //Se ejecuta la funcion toggleMenu cuando el usuario presione el icono
  void toggleMenu() {//Palanca
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  //AGREGAR PRODUCTOS
  List<String> items = [];
  //String precio = 'S/000.00';
  double totalValue = 0.0;
  double resultado = 0.0;


  @override
  void initState() {
    super.initState();

    data3 = Map<String, dynamic>.from(widget.data3);
  }


  @override
  void dispose() {
    nameProduct.dispose();
    numberUnit.dispose();
    precioUnitario.dispose();
    super.dispose();
  }

  void calculateTotalValue() {
    double sum = 0.0;
    double currentResultado = 0.0;
    for (String item in items) {
      double cantidad = double.parse(item.split('-')[1].trim());
      double precioUnitario = double.parse(item.split('-')[2].trim());
      sum += cantidad * precioUnitario;

      currentResultado = cantidad * precioUnitario;
      /* double price = double.parse(item.split('-')[2].trim());
      sum += price; */
    }
    setState(() {
      totalValue = sum;
      resultado = currentResultado;


    });
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
                          child:const Text('Productos o Servicios',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                        ),

                        /*
                        Container(
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.3, 0,0, 0),
                          //margin: const EdgeInsets.only(left: 90),
                          //child:const Text('S/000.00',style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                          child:Text(precio,style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84)),),
                        ),
                        */
                        Container(
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.3, 0, 0, 0),
                          child: Text('S/${totalValue.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84))),
                        ),
                      ],
                    ),

                   //PARA AGREGAR PRODUCTOS
                    SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                            child: Card(
                              color: Color(0xFFF2F2F2),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            items[index].split('-')[0].trim(),
                                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Color(0xFF6C7480)),
                                          ),

                                          Text(
                                            items[index].split('-')[3].trim(),
                                            style: TextStyle(fontSize: 14,color: Color(0xFF6C7480)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      items[index].split('-')[1].trim(),
                                                      style: TextStyle(fontSize: 14),
                                                    ),

                                                    Text(' x '),

                                                    Text(
                                                      items[index].split('-')[2].trim(),
                                                      style: TextStyle(fontSize: 14),
                                                    ),

                                                  ],
                                                ),

                                                Text('S/${double.parse(items[index].split('-')[2].trim()) * double.parse(items[index].split('-')[1].trim())}', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF115B84))),
                                              ],
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.black38, width: 1.5),
                                              ),
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(20),
                                                onTap: () {
                                                  setState(() {
                                                    items.removeAt(index);
                                                    calculateTotalValue();
                                                  });
                                                },
                                                child: Icon(Icons.close, size: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.05, 0),
                          //margin: const EdgeInsets.symmetric(horizontal: 20),
                          child:  TextField(
                            controller:  nameProduct,
                              decoration: InputDecoration(
                                hintText: "Nombre Producto/Servicio",
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
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.05, 0),
                          //margin: const EdgeInsets.symmetric(horizontal: 20),
                          child:  TextField(
                            controller: codeProduct,
                              decoration: InputDecoration(
                                hintText: "Cod.Producto",
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
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.05, 0),
                          // margin: const EdgeInsets.symmetric(horizontal: 20),
                          child:  TextField(
                            controller: description,
                              decoration: InputDecoration(
                                hintText: "Descripción",
                                hintStyle: TextStyle(color: Colors.black26),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                ),
                              ),
                              obscureText: false
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, MediaQuery.of(context).size.width * 0.05, 0),
                          //padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: unitMeasurement,
                                  decoration: InputDecoration(
                                    hintText: 'Und.',
                                    hintStyle: TextStyle(color: Colors.black26,),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                    ),

                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: TextField(
                                  controller: numberUnit,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Cantidad',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF0EB1E6), width:1, style: BorderStyle.solid),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: TextField(
                                  controller: precioUnitario,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'P.Unitario',
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
                      ],
                    ),




                    Row(
                        children:<Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.2, 0),
                              child:OutlinedButton.icon(
                                onPressed: () {
                                  setState(() {

                                    //Para agregar el producto
                                    /*
                                    final text1 = nameProduct.text;
                                    final text2 = description.text;
                                    final text3 = precioUnitario.text;
                                    if (text1.isNotEmpty && text2.isNotEmpty && text3.isNotEmpty) {
                                      final newItem = '$text1 - $text2 - $text3';
                                      items.add(newItem);
                                      nameProduct.clear();
                                      description.clear();
                                      precioUnitario.clear();

                                      //Precio
                                      precio = "S/"+text3;
                                    }
                                    */
                                    final text1 = nameProduct.text;
                                    final text2 = numberUnit.text;
                                    final text3 = precioUnitario.text;

                                    final text4 =  description.text;
                                    final text5 =  codeProduct.text;
                                    final text6 =  unitMeasurement.text;



                                    if (text1.isNotEmpty && text2.isNotEmpty && text3.isNotEmpty && text4.isNotEmpty) {
                                      final newItem = '$text1 - $text2 - $text3 - $text4 - $text5 - $text6 ';
                                      items.add(newItem);
                                      nameProduct.clear();
                                      numberUnit.clear();
                                      precioUnitario.clear();

                                      description.clear();
                                      codeProduct.clear();
                                      unitMeasurement.clear();
                                      calculateTotalValue();

                                      //campo3Value = 'S/$resultado';
                                      // resultado = cantidad * precioUnitario;
                                    }


                                  });
                                  //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillAdditionalScreen()),(route) => false);
                                },
                                icon: Icon(
                                  Icons.add,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                                label: Text('Agregar Articulo',style: TextStyle(color:Colors.white)),
                                style: OutlinedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  side: BorderSide.none,
                                  backgroundColor: Color(0xFF0EB1E6),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),

                    SizedBox(
                      height:10.0,
                    ),

                    Column(
                      children: [
                        Row(
                            children:<Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.2, 0),
                                  child: OutlinedButton(
                                    onPressed: (){
                                      precioVentaUnitario = {
                                        "monto": int.parse(hardMonto),
                                        "codigo":hardCodigo,
                                      };

                                      igv = {
                                        "monto": int.parse(hardMonto2),
                                        "afectacion":harAfectacion,
                                      };

                                      productsApi(context);
                                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  ElectronicBillAdditionalScreen(data4:jsonDecode),(route) => false);
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
                                      //lO COMENTE AHORA
                                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  ElectronicBillCoinScreen(data2: data3,emisor:widget.emisor)),(route) => false);
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



  Future<void> productsApi(BuildContext context) async {


    if ( numberUnit.text.isNotEmpty && precioUnitario.text.isNotEmpty) {
    //Información del producto-Objeto detalle con variables
    final detalle = {
      //"nombreProducto":  nameProduct.text,
      "numeroItem":  hardNumeroItem,
      "unidadMedida":    unitMeasurement.text,
      "codigoProducto":  codeProduct.text,
      /*
      "codigoProductoSunat":hardCodigoProductoSunat,
      "codigoProductoGS1":hardCodigoProductoGS1,
      "descripcion":     description.text,
      //Sale error al parsearlo , cambiarlo luego.
      "cantidadUnidades": int.parse(numberUnit.text),
      "valorUnitario": int.parse( precioUnitario.text),
      */


      //"cantidaUnidades": numberUnit.text,
      //"precioUnitario":  precioUnitario.text,

      "precioVentaUnitario": precioVentaUnitario,
      "igv": igv,

      "valorVenta":  int.parse(hardValorVenta),
      "datosAdicionalesDetalle":  hardDatosAdicionalesDetalle,
      "sumatoriaImpuestoItem":  int.parse(hardSumatoriaImpuestoItem),
      "indicadorCargo":   hardIndicadorCargo,
      "codigoCargo":   hardCodigoCargo,
      "factorCargo":  int.parse(hardFactorCargo),
      "montoCargo":  int.parse(hardMontoCargo) ,
      "montoBaseCargo":   int.parse(hardMontoBaseCargo),
    };

    final leyenda = {
      "codigo": hardcodigo,
    };

    //El objeto detalle se agrega a la lista documentoDetalle
    documentoDetalle.add(detalle);

    leyendas.add(leyenda);


    final body = {
      "serieNumero": widget.data3['serieNumero'],
      "tipoDocumento":widget.data3['tipoDocumento'],
      "fechaEmision":widget.data3['fechaEmision'],
      "fechaVencimiento":widget.data3['fechaVencimiento'],
      //"formaPago":widget.data3['formaPago'],
      //"establecimientoAnexo":widget.data3['establecimientoAnexo'],

      "emisor": widget.emisor, // Utilizar el valor de emisor recibido

      //Informacion del cliente
      "cliente": widget.data3['cliente'],

      "moneda": widget.data3['moneda'],

      "leyendas":leyendas,
      //Informacion del producto
      "documentoDetalle": documentoDetalle,



    };

    final jsonDecode = json.encode(body);
    print(body);
    print(jsonDecode);

    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectronicBillCoinScreen(data2: data2),),);
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectronicBillAdditionalScreen (),),);

    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ElectronicBillAdditionalScreen()),(route) => false);
    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  ElectronicBillAdditionalScreen(data4:jsonDecode),(route) => false);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectronicBillAdditionalScreen(data4: body,emisor: widget.emisor),),);
    } else {
      print('El texto está vacío.');
    }
  }
}
