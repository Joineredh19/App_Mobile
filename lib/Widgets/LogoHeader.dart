

import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Positioned(
      top: 75,
      left: MediaQuery.of(context).size.width * 0.38,
      child: Container(
        height: 90,
        width:90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Color.fromRGBO(248, 248, 248, 1))
          ]
        ),
        child: Align(
          alignment: Alignment.center,
           child: Image.asset('assets/logo.png')
        ),
        ),
        );
  }
}