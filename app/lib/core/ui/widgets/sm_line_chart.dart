import 'package:flutter/widgets.dart';

import '../tokens/tokens.dart';

/// A smooth glowing line over a soft gradient. It draws itself in once, and
/// shows a marker plus [label] for the point under the pointer or finger.
class SmLineChart extends StatefulWidget {
  const SmLineChart({
    required this.values,
    required this.label,
    this.height = 180,
    super.key,
  });

  /// At least two values, oldest first.
  final List<double> values;

  /// Text for the tooltip of the point at [index].
  final String Function(int index) label;
  final double height;

  @override
  State<SmLineChart> createState() => _SmLineChartState();
}

class _SmLineChartState extends State<SmLineChart> {
  int? _hover;

  void _pick(double dx, double width) {
    final n = widget.values.length;
    final i = (dx / width * (n - 1)).round().clamp(0, n - 1);
    if (i != _hover) setState(() => _hover = i);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, box) => MouseRegion(
          onHover: (e) => _pick(e.localPosition.dx, box.maxWidth),
          onExit: (_) => setState(() => _hover = null),
          child: GestureDetector(
            onPanUpdate: (d) => _pick(d.localPosition.dx, box.maxWidth),
            onPanEnd: (_) => setState(() => _hover = null),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: SmMotion.of(context, SmMotion.slow),
              curve: SmMotion.emphasis,
              builder: (context, t, _) => CustomPaint(
                size: Size(box.maxWidth, widget.height),
                painter: _ChartPainter(
                  values: widget.values,
                  progress: t,
                  hover: _hover,
                  tooltip: _hover == null ? null : widget.label(_hover!),
                  textDirection: Directionality.of(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  _ChartPainter({
    required this.values,
    required this.progress,
    required this.hover,
    required this.tooltip,
    required this.textDirection,
  });

  final List<double> values;
  final double progress;
  final int? hover;
  final String? tooltip;
  final TextDirection textDirection;

  static const double _pad = 12;
  static const double _stroke = 3;
  static const double _glowBlur = 8;
  static const double _dot = 5;

  Offset _at(int i, Size size, double lo, double span) {
    final x = _pad + (size.width - 2 * _pad) * i / (values.length - 1);
    final y = _pad + (size.height - 2 * _pad) * (1 - (values[i] - lo) / span);
    return Offset(x, y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final lo = values.reduce((a, b) => a < b ? a : b);
    final hi = values.reduce((a, b) => a > b ? a : b);
    final span = hi == lo ? 1.0 : hi - lo;
    final pts = [
      for (var i = 0; i < values.length; i++) _at(i, size, lo, span),
    ];
    final line = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      final mid = (pts[i - 1].dx + pts[i].dx) / 2;
      line.cubicTo(mid, pts[i - 1].dy, mid, pts[i].dy, pts[i].dx, pts[i].dy);
    }
    canvas
      ..save()
      ..clipRect(Rect.fromLTWH(0, 0, size.width * progress, size.height));
    final fill = Path.from(line)
      ..lineTo(pts.last.dx, size.height)
      ..lineTo(pts.first.dx, size.height)
      ..close();
    canvas
      ..drawPath(
        fill,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [SmColors.glassGlow, SmColors.transparent],
          ).createShader(Offset.zero & size),
      )
      ..drawPath(
        line,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _stroke * 2
          ..color = SmColors.accent.withValues(alpha: 0.35)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, _glowBlur),
      )
      ..drawPath(
        line,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _stroke
          ..strokeCap = StrokeCap.round
          ..color = SmColors.accent,
      )
      ..restore();
    final i = hover;
    if (i != null) _paintHover(canvas, size, pts[i]);
  }

  void _paintHover(Canvas canvas, Size size, Offset p) {
    canvas
      ..drawLine(
        Offset(p.dx, 0),
        Offset(p.dx, size.height),
        Paint()
          ..strokeWidth = 1
          ..color = SmColors.glassBorder,
      )
      ..drawCircle(p, _dot, Paint()..color = SmColors.accent);
    final text = TextPainter(
      text: TextSpan(text: tooltip, style: SmType.caption),
      textDirection: textDirection,
    )..layout();
    const padX = 10.0;
    const padY = 6.0;
    final w = text.width + padX * 2;
    final left = (p.dx - w / 2).clamp(0.0, size.width - w);
    final box = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, 0, w, text.height + padY * 2),
      const Radius.circular(10),
    );
    canvas.drawRRect(box, Paint()..color = SmColors.glassFillStrong);
    text.paint(canvas, Offset(left + padX, padY));
  }

  @override
  bool shouldRepaint(_ChartPainter old) =>
      old.progress != progress || old.hover != hover || old.values != values;
}
