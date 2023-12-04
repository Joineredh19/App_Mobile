import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nombre de Usuario'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Llamada a la función para realizar la solicitud
                String usuario = _usernameController.text;
                String contrasena = _passwordController.text;

                await fetchData(usuario, contrasena);
              },
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticateWithBiometrics,
              child: Text('Autenticar con Biometría'),
            ),
          ],
        ),
      ),
    );
  }

  // Aquí podrías realizar la autenticación con tu backend.
  // En este ejemplo, se simula una autenticación exitosa.
  // Función para realizar la solicitud HTTP
  Future<void> fetchData(String usuario, String contrasena) async {
    final response = await http.get(Uri.parse(
        'https://sgtmovil.geocom.cl/WSSGT.php?ACCION=GET_TOKEN&USERID=$usuario&CLAVE=$contrasena'));

     final Map<String, dynamic> data = jsonDecode(response.body);
       print('servicio: ${response.body}');

    if ( data['cod_ret'] ==0) {
      // Si la solicitud es exitosa, procesa la respuesta
      print('Status Respuesta ${data['cod_ret']}');
     print('Datos del servicio: $data');
      _navigateToHomeScreen();
    } else {
      // Si la solicitud falla, muestra el código de estado
      print('Error en la solicitud: ${response.statusCode}');
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool isAuthenticated = false;

    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Autenticación biométrica requerida',
      );
    } catch (e) {
      print('Error en la autenticación biométrica: $e');
    }

    if (isAuthenticated) {
      _navigateToHomeScreen();
    }
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Center(
        child: Text('Has iniciado sesión con éxito.'),
      ),
    );
  }
}
