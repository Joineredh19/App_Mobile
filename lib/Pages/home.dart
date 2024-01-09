import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgt_mobile/Pages/login.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomePage extends StatefulWidget  {
  @override
  _Inicio createState() => _Inicio();
}
class _Inicio extends State<HomePage> {
  late InAppWebViewController _webViewController;
  
   @override
  void initState() {
    super.initState();
    // Cambiar la orientación a horizontal al iniciar la vista
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

   
  
  }

  @override
  void dispose() {
    // Restaurar las preferencias de orientación al salir de la vista
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();

    
  }
  
  String usuario = '';
  String contrasena = '';
  String tokenLogin = '';

  @override
  Widget build(BuildContext context) {
   //hacerLogin();
final DatosParaEnviar datos =
        ModalRoute.of(context)?.settings.arguments as DatosParaEnviar ??
            DatosParaEnviar('', '', '');
  /*DatosParaManejar datos =  DatosParaManejar(tokenLogin, usuario);

  print('DATOS: ${datos.usuario}');*/
  // final String urls = '';
//print('URL pasa1: $urls');
 //  print('URL: $url');
    return Scaffold(
      
         body: InAppWebView(
     initialUrlRequest: URLRequest(url: Uri.parse('https://sgtmovil.geocom.cl/main.php?ACCION=ACCESO&USERID=${datos.usuario}&TOKEN=${datos.token}')),
     
     onWebViewCreated: (controller) {
          _webViewController = controller;
          
        },
         onLoadStop: (controller, url) {
          print('URL pasa2: $url');
         
            if (url.toString().contains('https://sgtmovil.geocom.cl/index.php?time=')) {
           // print('URL pasa3: $urls');
              exit(0);
           }
           
         }
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