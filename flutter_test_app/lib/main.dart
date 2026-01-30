import 'package:flutter/material.dart';

void main() => runApp(const RenderTreeDemo());

class RenderTreeDemo extends StatelessWidget {
  const RenderTreeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Render Tree Demo')),
        body: Column(
          children: [
            const Center(
              child: ColoredBox(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Hola Flutter Engineer!'),
                ),
              ),
            ),
            Circle()
          ],
        ),
      ),
    );
  }
}

class RenderCircle extends RenderBox {
  @override
  void performLayout() {
    // Decide el tamaño final
    size = constraints.constrain(
      const Size(100, 100),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final paint = Paint()..color = Colors.blue;

    canvas.drawCircle(
      offset + Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }
}

class Circle extends LeafRenderObjectWidget {
  const Circle({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCircle();
  }
}
