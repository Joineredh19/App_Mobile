import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'package:primera_aplicacion/Pages/home.dart';
import 'package:primera_aplicacion/Widgets/HeaderLogin.dart';
import 'package:primera_aplicacion/Widgets/LogoHeader.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 String token = '';
String nombre = '';
 String usuario ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(top: 0),
      physics: BouncingScrollPhysics(),
      children: [
        Stack(
          children: [
            HeaderLogin(),
            LogoHeader(),
          ],
        ),
        SizedBox(height: 40),
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
             usuario = _usernameController.text;
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

        /* SizedBox(height: 20),
        ElevatedButton(
        onPressed: () async {
            await _handleSignIn();
          },
          child: Text('Autenticar con Google'),
        ),*/
      ],
    ));
  }



  Future<void> fetchData(String usuario, String contrasena) async {
    final response = await http.get(Uri.parse(
        'https://sgtmovil.geocom.cl/WSSGT.php?ACCION=GET_TOKEN&USERID=$usuario&CLAVE=$contrasena'));

    final Map<String, dynamic> data = jsonDecode(response.body);
    //print('servicio: ${response.body}');


    if (data['cod_ret'] == 0) {
      // Si la solicitud es exitosa, procesa la respuesta
      //print('Status Respuesta ${data['cod_ret']}');
      print('Datos del servicio: $data');
        usuario =_usernameController.text;
        token = data['data']['TOKEN'];
        nombre = data['data']['USUARIO']['Nombre'];
print('TOKEN DEL USUARIO: $token');

print('NOMBRE DEL USUARIO: $nombre');
  //DatosParaEnviar datos = DatosParaEnviar(token,nombre);
      _navigateToHomeScreen();
    } else {
      // Si la solicitud falla, muestra el código de estado
      _navigateToHomeScreen();
      print('Error en la solicitud: ${response.statusCode}');
       // Mostrar un SnackBar con un mensaje de error
              final snackBar = SnackBar(
                content: Text('Usuario o contraseña incorrecto'),
                backgroundColor: Colors.red,
              );
                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    final localAuth = LocalAuthentication();
   try {
    if (await localAuth.canCheckBiometrics) {
      // Verificar si el dispositivo es compatible con la autenticación biométrica
      List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        // Realizar la autenticación biométrica
     
        final isAuthenticated = await localAuth.authenticate(
          localizedReason: 'Por favor, coloque su rostro o huella para la autenticación',
  
        );

        if (isAuthenticated) {
          
      _navigateToHomeScreen();
    
          print('Autenticación exitosa');
        } else {
          print('Autenticación fallida');
           // Mostrar un SnackBar con un mensaje de error
              final snackBar = SnackBar(
                content: Text('Autenticación biometrica fallida'),
                backgroundColor: Colors.red,
              );
                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
         _navigateToHomeScreen();
        print('El dispositivo no admite métodos biométricos fuertes');
         final snackBar = SnackBar(
                content: Text('El dispositivo no admite métodos biométricos fuertes'),
                backgroundColor: Colors.red,
              );
                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
       // Mostrar un SnackBar con un mensaje de error
              final snackBar = SnackBar(
                content: Text('La autenticación biométrica no está disponible en este dispositivo'),
                backgroundColor: Colors.red,
              );
                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('La autenticación biométrica no está disponible en este dispositivo');
    }
  } catch (e) {
    print('Error en la autenticación biométrica: $e');
  }
  }

  void _navigateToHomeScreen() {
  //   DatosParaEnviar datos = DatosParaEnviar(token,nombre);
    /*Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(datos: datos)),
    );*/
print('DATOS EN EL NAVIGATOR NOMBRE: $nombre');
    Navigator.pushNamed(
              context,
              'home',
              arguments: DatosParaEnviar(nombre,token,usuario),
            );
  }

  /*  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      final googleSignInAccount = await _googleSignInAuth.signIn();
      final authHeaders = await googleSignInAccount.authHeaders;
      final client = auth.authenticatedClient(
        authHeaders,
        client: _googleSignInAuth.clientViaUserConsent(),
      );

      final driveApi = drive.DriveApi(client);
      final about = await driveApi.about.get();

      print("Usuario autenticado con Google: ${about.user.displayName}");
    } catch (error) {
      print("Error al autenticar con Google: $error");
    }
  }*/
}

class DatosParaEnviar {
  final String token;
   final String nombre;
  final String usuario;

   DatosParaEnviar(this.nombre, this.token, this.usuario);
}

