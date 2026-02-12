import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    super.key,
    this.shadows = const <Shadow>[],
    super.child,
  });

  final List<Shadow> shadows;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderInnerShadow(shadows: shadows);
  }

  @override
  void updateRenderObject(BuildContext context, RenderInnerShadow renderObject) {
    renderObject.shadows = shadows;
  }
}

class RenderInnerShadow extends RenderProxyBox {
  RenderInnerShadow({
    List<Shadow>? shadows,
  }) : _shadows = shadows;

  List<Shadow>? _shadows;

  List<Shadow>? get shadows => _shadows;

  set shadows(List<Shadow>? value) {
    if (_shadows == value) return;
    _shadows = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    if (_shadows == null || _shadows!.isEmpty) {
      context.paintChild(child!, offset);
      return;
    }

    final bounds = offset & size;

    context.paintChild(child!, offset);

    context.canvas.saveLayer(bounds, Paint());
    context.paintChild(child!, offset);

    for (final shadow in _shadows!) {
      final shadowPaint = Paint()
        ..blendMode = BlendMode.srcATop
        ..colorFilter = ColorFilter.mode(shadow.color, BlendMode.srcIn)
        ..imageFilter = ui.ImageFilter.blur(sigmaX: shadow.blurSigma, sigmaY: shadow.blurSigma);

      context.canvas.saveLayer(bounds, shadowPaint);
      context.canvas.translate(shadow.offset.dx, shadow.offset.dy);
      context.paintChild(child!, offset);
      context.canvas.restore();
    }

    context.canvas.restore();
  }
}
