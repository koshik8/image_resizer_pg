import 'package:flutter/material.dart';

class PopResize extends StatefulWidget {
  final double scale;
  final Alignment alignment;
  final ValueChanged<Map<String, dynamic>> onResize;
  final ValueChanged<double> onScale;
  final ValueChanged<Alignment> onAlign;

  const PopResize({
    super.key,
    required this.scale,
    required this.alignment,
    required this.onResize,
    required this.onScale,
    required this.onAlign,
  });

  @override
  State<PopResize> createState() => _PopResizeState();
}

class _PopResizeState extends State<PopResize> {
  late double _scale;
  late Alignment _alignment;

  @override
  void initState() {
    super.initState();
    _scale = widget.scale;
    _alignment = widget.alignment;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.topRight,
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Scale - ${(_scale * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: _scale,
                min: 0.1,
                max: 2.0,
                onChanged: (value) {
                  setState(() {
                    _scale = value;
                  });
                  widget.onScale(value);
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Alignment',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon:  Icon(Icons.format_align_left,color: (_alignment == Alignment.centerLeft)?Colors.blue:Colors.black,),
                    onPressed: () {
                      setState(() {
                        _alignment = Alignment.centerLeft;
                        print("left");
                        
                      });
                      widget.onAlign(Alignment.centerLeft);
                    },
                  ),
                  IconButton(
                    icon:  Icon(Icons.format_align_center,color: (_alignment == Alignment.center)?Colors.blue:Colors.black,),
                    onPressed: () {
                      setState(() {
                        _alignment = Alignment.center;
                        print("center");
                      });
                      widget.onAlign(Alignment.center);
                    },
                  ),
                  IconButton(
                    icon:  Icon(Icons.format_align_right,color: (_alignment == Alignment.centerRight)?Colors.blue:Colors.black,),
                    onPressed: () {
                      setState(() {
                        _alignment = Alignment.centerRight;
                        print("rgt");
                      });
                      widget.onAlign(Alignment.centerRight);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Size: ${(_scale * 3024).toInt()} x ${(_scale * 4032).toInt()}',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _scale = 1.0;
                        _alignment = Alignment.center;
                      });
                      widget.onScale(1);
                      widget.onAlign(Alignment.center);
                    },
                    child: const Text('Revert'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Send the updated scale and alignment back to the parent
                      widget.onResize({
                        'scale': _scale,
                        'alignment': _alignment,
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
