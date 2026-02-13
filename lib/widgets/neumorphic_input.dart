import 'package:flutter/material.dart';

class NeumorphicInputContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget? child;
  final Color pressedColor;
  final Color shadowColorTop;
  final Color shadowColorBottom;

  const NeumorphicInputContainer({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.child,
    this.pressedColor = const Color(0xFF262626),
    this.shadowColorTop = const Color(0x40FFFFFF), // rgba(255, 255, 255, 0.25)
    this.shadowColorBottom = const Color(0x73000000), // rgba(0, 0, 0, 0.45)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: pressedColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: const Color(0xFF353535),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius - 2), // Adjust for border
        child: CustomPaint(
          foregroundPainter: _InnerShadowPainter(
             radius: borderRadius - 2,
             shadowColorTop: shadowColorTop,
             shadowColorBottom: shadowColorBottom,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _InnerShadowPainter extends CustomPainter {
  final double radius;
  final Color shadowColorTop;
  final Color shadowColorBottom;

  _InnerShadowPainter({
    required this.radius,
    required this.shadowColorTop,
    required this.shadowColorBottom,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // We render shadows by drawing the *inverse* shape with a shadow, clipped to the actual shape.
    canvas.save();
    canvas.clipRRect(rrect);

    // Shadow 1: inset -1px -2px 4px 0px rgba(255, 255, 255, 0.25)
    // Offset (-1, -2). Blur 4.
    // To cast shadow *inside* from Top/Left? No, negative offset?
    // "inset 2px 3px" -> Shadow on Top/Left (dark). Light from Bottom/Right.
    // "inset -1px -2px" -> Shadow on Bottom/Right (light). Light from Top/Left.
    // Let's implement generic inner shadow drawer.
    
    _drawShadow(canvas, rect, rrect, 
       offset: const Offset(2, 3), 
       blur: 4, 
       color: shadowColorBottom); // Dark shadow

     _drawShadow(canvas, rect, rrect, 
       offset: const Offset(-1, -2), 
       blur: 4, 
       color: shadowColorTop); // Light shadow

    canvas.restore();
  }

  void _drawShadow(Canvas canvas, Rect rect, RRect rrect, {
    required Offset offset, 
    required double blur, 
    required Color color
  }) {
    // Create a path that is the "inverse" of the rrect.
    // We make a very large rect around the canvas, and subtract the rrect.
    final outerRect = rect.inflate(blur + 10.0);
    var dirtyPath = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(outerRect)
      ..addRRect(rrect);
      
    // Shift it by -offset so the shadow falls into the hole correctly?
    // No, paint "elevation" shadow.
    // Standard approach:
    // Draw the "inverse" shape. Then the shadow of that inverse shape will fall *inside* the hole.
    // To shift the shadow by `offset`, we shift the inverse shape by `offset`.
    
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    
    final paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur); // standard blur
      
    // Draw the holey path
    canvas.drawPath(dirtyPath, paint);
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _InnerShadowPainter oldDelegate) => true;
}
