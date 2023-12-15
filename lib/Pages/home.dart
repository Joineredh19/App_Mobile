import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:primera_aplicacion/Pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatelessWidget {

  String usuario = '';
  String contrasena = '';
  String tokenLogin = '';

  
/*Future<String> obtenerToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

 /* print('+++++++VALOR GUARDADO+++++++++++');
  print(prefs.getString('token') ?? '');*/
  return prefs.getString('token') ?? '';
}*/

/*Future<void> hacerLogin() async {
  final String token = await obtenerToken();

  final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

  usuario = decodedToken['usuario'];
  contrasena = decodedToken['contrasena'];

  print('ESTE ES EL TOKEN DECODIFICADO: $decodedToken');

  final respuesta = await http.get(Uri.parse(
      'https://sgtmovil.geocom.cl/WSSGT.php?ACCION=GET_TOKEN&USERID=$usuario&CLAVE=$contrasena'));

  final Map<String, dynamic> data = jsonDecode(respuesta.body);
    tokenLogin=  data['data']['TOKEN'];

//DatosParaManejar(tokenLogin, usuario);
 /*print('ESTE ES EL USUARIO DECODIFICADO: $usuario');
print('ESTE ES LA CONTRASEÑA DECODIFICADO: $contrasena');
print('ESTE ES EL TOKEN DECODIFICADO: $tokenLogin');*/
}*/

  @override
  Widget build(BuildContext context) {
   //hacerLogin();
final DatosParaEnviar datos =
        ModalRoute.of(context)?.settings.arguments as DatosParaEnviar ??
            DatosParaEnviar('', '', '');
  /*DatosParaManejar datos =  DatosParaManejar(tokenLogin, usuario);

  print('DATOS: ${datos.usuario}');*/
   final String url = 'https://sgtmovil.geocom.cl/main.php?ACCION=ACCESO&USERID=${datos.usuario}&TOKEN=${datos.token}';

 //  print('URL: $url');
    return Scaffold(
      
      body: WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    )
    );

  }
}

/*class WebViewPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    hacerLogin();
    final String url = 'https://sgtmovil.geocom.cl/main.php?ACCION=ACCESO&USERID=$usuario&TOKEN=$tokenLogin';
    
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
}
}*/
// Uso:

/*
https://sgtmovil.geocom.cl/main.php?
ACCION=ACCESO&USERID=francis.elier
&TOKEN=TOK_52e89925e9754d80d1cabba65c2d405130ff314a574959327f25ab65fe5152b24f436ce38545cbaa63f201218ac26e6f5bb2c3c5f5acc565392e959ce7714bae
*/ /*initialUrl: 'https://sgtmovil.geocom.cl/main.php?ACCION=ACCESO&USERID=$usuario&TOKEN=$tokenLogin',
        javascriptMode: JavascriptMode.unrestricted,
*/

/*class DatosParaManejar {
  final String token;
  final String usuario;

  DatosParaManejar(this.token, this.usuario);
}*/