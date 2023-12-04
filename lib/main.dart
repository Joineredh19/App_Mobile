
import 'package:flutter/material.dart';
import 'package:primera_aplicacion/Pages/details.dart';
import 'package:primera_aplicacion/Pages/home.dart';
import 'package:primera_aplicacion/Pages/login.dart';
import 'package:primera_aplicacion/Pages/logo.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Geocom',
      initialRoute: 'logo',
      routes: {
        'logo': (_) => LogoPage(),
        'login': (_) => LoginPage(),
        'home': (_) =>  HomePage(),
        'details': (_) => DetailsAccountPage()
      },
     
    );
  }
}

//historiainicial1
//evolucion
