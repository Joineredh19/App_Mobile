import 'package:flutter/material.dart';

class DetailsAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de tu cuenta'),
      ),
      body: Center(
        child: Text('En esta pagina se verán los detalles de tu cuenta.'),
      ),
    );
  }
}