
import 'package:flutter/material.dart';
import 'package:primera_aplicacion/Pages/login.dart';

class LogoPage extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}


class _LogoScreenState extends State<LogoPage> {
  
  @override
  void initState() {
    super.initState();
    _irAVistaLogin();
  }

  Future<void> _irAVistaLogin() async {
    // Espera 3 segundos antes de navegar a la vista de login
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
