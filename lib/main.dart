import 'package:flutter/material.dart';
import 'pop_resize.dart'; // Import the new PopResize class

void main() {
  runApp(const ImageResizerApp());
}

class ImageResizerApp extends StatelessWidget {
  const ImageResizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageResizerScreen(),
    );
  }
}

class ImageResizerScreen extends StatefulWidget {
  @override
  _ImageResizerScreenState createState() => _ImageResizerScreenState();
}

class _ImageResizerScreenState extends State<ImageResizerScreen> {
  double _scale = 1.0;
  Alignment _alignment = Alignment.center;

  final double originalWidth = 3024;
  final double originalHeight = 4032;

  double get maxWidth => MediaQuery.of(context).size.width * 0.95;
  double get maxHeight => MediaQuery.of(context).size.height * 0.95;

  double get scaledWidth => originalWidth * _scale;
  double get scaledHeight => originalHeight * _scale;

  // Function to show the resize popup
  void _showResizePopup() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => PopResize(
        scale: _scale,
        alignment: _alignment,
        onResize: (Map<String, dynamic> newValues) {
          setState(() {
            _scale = newValues['scale'] as double;
            _alignment = newValues['alignment'] as Alignment;
          });
        },
        onScale: (double a) => {
          setState(
            () {
              _scale = a;
            },
          )
        },
        onAlign: (Alignment al) => {
          setState(
            () {
              _alignment = al;
              print(_alignment.toString());
            },
          )
        },
      ),
    );
    if (result != null) {
      setState(() {
        _scale = result['scale'] as double;
        _alignment = result['alignment'] as Alignment;
        print(_alignment.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Resizer'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _showResizePopup,
          child: Container(
            width: maxWidth,
            height: maxHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: ClipRect(
              child: Align(
                alignment: _alignment,
                child: FractionallySizedBox(
                  widthFactor: _scale,
                  heightFactor: _scale,
                  child: Image.asset('assets/sample_img.png'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
