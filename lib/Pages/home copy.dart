import 'dart:async';
//import 'dart:convert';
//import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:primera_aplicacion/Pages/details.dart';
import 'package:primera_aplicacion/Pages/login.dart';
import 'package:primera_aplicacion/Widgets/CustomAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Widgets/HeaderHome.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recibir datos de Pantalla A
    final DatosParaEnviar datos =
        ModalRoute.of(context)?.settings.arguments as DatosParaEnviar ??
            DatosParaEnviar('', '', '');

    print('VALOR TRANSPORTADO NOMBRE ${(datos.nombre)}');
    print('VALOR TRANSPORTADO TOKEN ${(datos.token)}');
    return Scaffold(
      backgroundColor: Color(0xffDCE9EF),
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: "Hola, ${(datos.nombre)}",
        //leading: Icon(Icons.home, color: Colors),
        showActionIcon: true,
        onMenuActionTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailsAccountPage()));
        },
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              HeaderHome(color: Color(0xff004481)),
              //_AppBarCustomHome(widget: Icon(Icons.sort, color: Colors.white, size: 35)),
              //_AppBarCustomHome(widget: Text('Hola, PRUEBA', style: TextStyle(fontSize: 20,color: Colors.white))),

              Positioned(
                  top: 50,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/logo.png'),
                    maxRadius: 18,
                  )),

              _TarjetaBlancaHeader(),
            ],
          ),
          _Grafica()
          //  _MyLineChartState() ,
        ],
      ),
    );
  }
}

class _TarjetaBlancaHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 240,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('FACTURACION',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xff004481),
                          fontWeight: FontWeight.bold)),
                  Icon(Icons.more_horiz, size: 30, color: Color(0xff9CAFC1))
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _Grafica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DatosParaEnviar datos =
        ModalRoute.of(context)?.settings.arguments as DatosParaEnviar ??
            DatosParaEnviar('', '', '');
obtenerToken();
    return Positioned(
        top: 110,
        child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                future: cargarDatosDesdeJSON(datos.usuario,datos.token),
                builder: (context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(),
                          series: <ChartSeries>[
                            BarSeries<Map<String, dynamic>, String>(
                              dataSource: snapshot.data!,
                              xValueMapper: (datum, index) => datum['x'].toString(),
                              yValueMapper: (datum, index) => datum['y'],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          
        );
     
  }

  Future<List<Map<String, dynamic>>> cargarDatosDesdeJSON(
    String usuario, String token) async {
print('USUARIO $usuario - TOKEN $token');
  final response = await http.get(Uri.parse(
      'https://sgtmovil.geocom.cl/WSSGT.php?ACCION=GET_FACTURACION_COMPARATIVA_ANUAL_ST&USERID=$usuario&TOKEN=$token'));
      
    final String jsonString = '''
      [
        {"x": 1, "y": 10},
        {"x": 2, "y": 5},
        {"x": 3, "y": 15},
        {"x": 4, "y": 7},
        {"x": 5, "y": 12}
      ]
    ''';

    final List<dynamic> jsonData = json.decode(jsonString);

    return jsonData.cast<Map<String, dynamic>>();
  }


}
  Future<String> obtenerToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

   print('+++++++VALOR GUARDADO+++++++++++');
  print(prefs.getString('token') ?? '');
  return prefs.getString('token') ?? '';
  
}

// Uso:
