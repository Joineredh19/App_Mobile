
import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onHorizontalDragStart: (details) => Navigator.pushNamed(context,'login'),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
          body: Center(
            child: Image.asset('assets/logo.png')
            ),
      ),
    );
  }
}