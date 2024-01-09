
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sgt_mobile/Pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LogoPage extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}


class _LogoScreenState extends State<LogoPage> {
    String token = '';
  String nombre = '';
  String usuario = '';
  String contrasena = '';

  @override
  void initState() {
    super.initState();
    //_irAVistaLogin();
  }

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: FutureBuilder<bool>(
      future: validacion(),
      builder: (context, snapshot) {
        validacion();
         return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Coloca aquí el widget de tu logo
            Image.asset('assets/logo.png', width: 250, height: 250),
            SizedBox(height: 20),
          ],
        ),
        ));
        } 
        ),
    );
  }

 Future<String> obtenerToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

 /* print('+++++++VALOR GUARDADO+++++++++++');
  print(prefs.getString('token') ?? '');*/
  return prefs.getString('token') ?? '';
}
  Future<void> hacerLogin() async {
  final String tokenGuardado = await obtenerToken();

  final Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenGuardado);

  usuario = decodedToken['usuario'];
  contrasena = decodedToken['contrasena'];

  print('ESTE ES EL TOKEN DECODIFICADO: $decodedToken');

  final respuesta = await http.get(Uri.parse(
      'https://sgtmovil.geocom.cl/WSSGT.php?ACCION=GET_TOKEN&USERID=$usuario&CLAVE=$contrasena'));

  final Map<String, dynamic> data = jsonDecode(respuesta.body);
    token=  data['data']['TOKEN'];

_navigateToHomeScreen();

}
Future<bool> validacion() async{
   String tokenGuardado = await obtenerToken();
 if (tokenGuardado!='') {
   hacerLogin();
  
 }else{

    // Espera 3 segundos antes de navegar a la vista de login
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  
 
 }
  return true;
}

  void _navigateToHomeScreen() {
    
    print('DATOS EN EL NAVIGATOR NOMBRE: $nombre');
    Navigator.pushNamed(
      context,
      'home',
      arguments: DatosParaEnviar(nombre, token, usuario),
    );
  }
}