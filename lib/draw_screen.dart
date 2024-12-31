import 'package:flutter/material.dart';

class DrawScreen extends StatefulWidget {
  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  List<Offset?> _points = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draw Something'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _points.add(details.localPosition);
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    _points.add(null); // Add a null to separate lines
                  });
                },
                child: CustomPaint(
                  size: Size.infinite,
                  painter: DrawingPainter(_points),
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
                  onPressed: (){
                setState(() {
                  _points = [];
                });
              }, child: const Text("Clear")),
            ),
          )
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red // Set the drawing color to red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0; // Adjust the stroke width as needed

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
