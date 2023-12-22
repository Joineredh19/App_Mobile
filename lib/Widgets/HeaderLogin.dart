import 'package:flutter/material.dart';

class HeaderLogin extends StatelessWidget
{

 @override
 Widget build(BuildContext context)
 {
    return Container(
      height: 270,
      width: double.infinity,
      // color: Colors.red,
      child: CustomPaint(
        painter: _LoginGeocom(),
      ),
    );
  }
}

class _LoginGeocom extends CustomPainter
{
  @override
  void paint(Canvas canvas, Size size) {

    final Rect rect = new Rect.fromCircle(center: Offset(150.0, 50.0), radius: 180);

    final Gradient gradient = new LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromARGB(255, 20, 52, 158),
          Color.fromARGB(255, 20, 52, 158)
      ]
    );


    final paint = new Paint().. shader = gradient.createShader(rect);
    paint.style = PaintingStyle.fill;

final path = Path();
path.moveTo(size.width * 1.2, 0); // Vértice superior derecho
path.lineTo(0, 0); // Línea hacia el vértice superior izquierdo
path.lineTo(0, size.height *1.2); // Línea hacia el vértice inferior izquierdo
path.close(); // Cierra el triángulo

canvas.drawPath(path, paint);

  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}
