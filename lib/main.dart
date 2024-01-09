
import 'package:flutter/material.dart';
import 'package:sgt_mobile/Pages/home.dart';
import 'package:sgt_mobile/Pages/login.dart';
import 'package:sgt_mobile/Pages/logo.dart';


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
      //  'details': (_) => DetailsAccountPage()
      },
     
    );
  }
}

//historiainicial1
//evolucion
