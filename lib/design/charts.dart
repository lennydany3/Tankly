import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';
import 'package:tankly/design/surfaces.dart';

/// Chart chrome: title, hero value, caption, then the plot.
class ChartCard extends StatelessWidget {
  const ChartCard({
    super.key,
    required this.title,
    required this.child,
    this.value,
    this.caption,
    this.trailing,
  });

  final String title;
  final String? value;
  final String? caption;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TankCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TanklyType.ui(
                    TanklyType.body,
                    weight: 600,
                    color: p.text,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          if (value != null) ...[
            const SizedBox(height: Gap.sm),
            Text(
              value!,
              style: TanklyType.number(
                32,
                weight: 700,
                color: p.text,
                height: 1,
              ),
            ),
          ],
          if (caption != null) ...[
            const SizedBox(height: Gap.xs + 2),
            Text(
              caption!,
              style: TanklyType.ui(TanklyType.caption, color: p.textDim),
            ),
          ],
          const SizedBox(height: Gap.lg),
          child,
        ],
      ),
    );
  }
}

/// Line chart with end dots and x labels. Mileage trend, cost per km.
class LinePlot extends StatelessWidget {
  const LinePlot({
    super.key,
    required this.values,
    required this.labels,
    this.color,
    this.height = 132,
    this.showEndDots = true,
    this.showAxisLabels = true,
    this.unit,
  });

  final List<double> values;
  final List<String> labels;
  final Color? color;
  final double height;
  final bool showEndDots;
  final bool showAxisLabels;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SizedBox(
      height: height,
      child: CustomPaint(
        size: Size.infinite,
        painter: _LinePainter(
          values: values,
          color: color ?? p.accent,
          gridColor: p.outline,
          labelStyle: TanklyType.ui(10, color: p.textDim, weight: 500),
          showEndDots: showEndDots,
          showAxisLabels: showAxisLabels,
          fill: true,
        ),
        foregroundPainter: _AxisLabelPainter(
          labels: labels,
          labelStyle: TanklyType.ui(10, color: p.textDim, weight: 500),
          axisColor: p.outline,
          unit: unit,
        ),
      ),
    );
  }
}

/// Bar chart. Monthly spend.
class BarPlot extends StatelessWidget {
  const BarPlot({
    super.key,
    required this.values,
    required this.labels,
    this.color,
    this.height = 132,
    this.highlightLast = true,
  });

  final List<double> values;
  final List<String> labels;
  final Color? color;
  final double height;
  final bool highlightLast;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SizedBox(
      height: height,
      child: CustomPaint(
        size: Size.infinite,
        painter: _BarPainter(
          values: values,
          color: color ?? p.accent,
          mutedColor: p.accent.withValues(alpha: 0.32),
          gridColor: p.outline,
          highlightLast: highlightLast,
        ),
        foregroundPainter: _AxisLabelPainter(
          labels: labels,
          labelStyle: TanklyType.ui(10, color: p.textDim, weight: 500),
          axisColor: p.outline,
        ),
      ),
    );
  }
}

/// Bare trend line, no axes. Sits next to a big number on the stats screen.
class Sparkline extends StatelessWidget {
  const Sparkline({
    super.key,
    required this.values,
    this.color,
    this.height = 44,
    this.fill = true,
  });

  final List<double> values;
  final Color? color;
  final double height;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _LinePainter(
          values: values,
          color: color ?? p.accent,
          gridColor: Colors.transparent,
          labelStyle: TanklyType.ui(10, color: p.textDim, weight: 500),
          showEndDots: false,
          showAxisLabels: false,
          fill: fill,
        ),
      ),
    );
  }
}

/// Filled speed or elevation profile for trip detail.
class ProfilePlot extends StatelessWidget {
  const ProfilePlot({
    super.key,
    required this.values,
    required this.labels,
    this.color,
    this.height = 116,
    this.unit = '',
    this.highlightIndex,
  });

  final List<double> values;
  final List<String> labels;
  final Color? color;
  final double height;
  final String unit;

  /// Draws a marker here, e.g. the fastest point on the speed graph.
  final int? highlightIndex;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SizedBox(
      height: height,
      child: CustomPaint(
        size: Size.infinite,
        painter: _LinePainter(
          values: values,
          color: color ?? p.accent,
          gridColor: p.outline,
          labelStyle: TanklyType.ui(10, color: p.textDim, weight: 500),
          showEndDots: false,
          showAxisLabels: false,
          fill: true,
          gridLines: 3,
        ),
        foregroundPainter: _ProfileOverlayPainter(
          labels: labels,
          unit: unit,
          values: values,
          highlightIndex: highlightIndex,
          labelStyle: TanklyType.ui(10, color: p.textDim, weight: 500),
          valueStyle: TanklyType.number(13, weight: 700, color: p.text),
          pillColor: p.surfaceHigh,
          borderColor: p.outline,
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter({
    required this.values,
    required this.color,
    required this.gridColor,
    required this.labelStyle,
    this.showEndDots = true,
    this.showAxisLabels = true,
    this.fill = false,
    this.gridLines = 0,
  });

  final List<double> values;
  final Color color;
  final Color gridColor;
  final TextStyle labelStyle;
  final bool showEndDots;
  final bool showAxisLabels;
  final bool fill;
  final int gridLines;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;

    final bottomInset = showAxisLabels ? 18.0 : 4.0;
    final topInset = 8.0;
    final plotHeight = size.height - bottomInset - topInset;

    if (gridLines > 0 && gridColor != Colors.transparent) {
      final paint = Paint()
        ..color = gridColor.withValues(alpha: 0.6)
        ..strokeWidth = 1;
      for (var i = 0; i <= gridLines; i++) {
        final y = topInset + plotHeight * i / gridLines;
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      }
    }

    var min = values.first, max = values.first;
    for (final v in values) {
      min = math.min(min, v);
      max = math.max(max, v);
    }
    // Flat series should sit on a centred line, not collapse to the bottom.
    final span = (max - min).abs() < 1e-6 ? 1.0 : max - min;
    final paddedMin = min - span * 0.18;
    final paddedMax = max + span * 0.18;

    Offset at(int i) => Offset(
      size.width * i / (values.length - 1),
      topInset +
          plotHeight * (1 - (values[i] - paddedMin) / (paddedMax - paddedMin)),
    );

    final path = Path()..moveTo(at(0).dx, at(0).dy);
    for (var i = 1; i < values.length; i++) {
      // Smooth with a midpoint quadratic, which keeps the curve calm without
      // overshooting the way a cubic spline does on sparse data.
      final previous = at(i - 1);
      final current = at(i);
      final mid = Offset(
        (previous.dx + current.dx) / 2,
        (previous.dy + current.dy) / 2,
      );
      path.quadraticBezierTo(previous.dx, previous.dy, mid.dx, mid.dy);
      if (i == values.length - 1) path.lineTo(current.dx, current.dy);
    }

    if (fill) {
      final area = Path.from(path)
        ..lineTo(size.width, size.height - bottomInset)
        ..lineTo(0, size.height - bottomInset)
        ..close();
      canvas.drawPath(
        area,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withValues(alpha: 0.26),
              color.withValues(alpha: 0.0),
            ],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
      );
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    if (showEndDots) {
      for (final index in [0, values.length - 1]) {
        final point = at(index);
        canvas.drawCircle(
          point,
          5.5,
          Paint()..color = color.withValues(alpha: 0.22),
        );
        canvas.drawCircle(point, 3, Paint()..color = color);
      }
    }
  }

  @override
  bool shouldRepaint(_LinePainter old) =>
      old.values != values || old.color != color || old.fill != fill;
}

class _BarPainter extends CustomPainter {
  _BarPainter({
    required this.values,
    required this.color,
    required this.mutedColor,
    required this.gridColor,
    required this.highlightLast,
  });

  final List<double> values;
  final Color color;
  final Color mutedColor;
  final Color gridColor;
  final bool highlightLast;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    const bottomInset = 18.0;
    final plotHeight = size.height - bottomInset - 6;

    final max = values.reduce(math.max);
    final slot = size.width / values.length;
    final barWidth = math.min(26.0, slot * 0.52);

    final baseline = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, size.height - bottomInset + 4),
      Offset(size.width, size.height - bottomInset + 4),
      baseline,
    );

    for (var i = 0; i < values.length; i++) {
      final ratio = max <= 0 ? 0.0 : values[i] / max;
      final barHeight = math.max(4.0, plotHeight * ratio);
      final left = slot * i + (slot - barWidth) / 2;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, 6 + plotHeight - barHeight, barWidth, barHeight),
        const Radius.circular(6),
      );
      final isLast = i == values.length - 1;
      canvas.drawRRect(
        rect,
        Paint()..color = isLast && highlightLast ? color : mutedColor,
      );
    }
  }

  @override
  bool shouldRepaint(_BarPainter old) =>
      old.values != values || old.color != color;
}

class _AxisLabelPainter extends CustomPainter {
  _AxisLabelPainter({
    required this.labels,
    required this.labelStyle,
    required this.axisColor,
    this.unit,
  });

  final List<String> labels;
  final TextStyle labelStyle;
  final Color axisColor;
  final String? unit;

  @override
  void paint(Canvas canvas, Size size) {
    if (labels.isEmpty) return;
    final painter = TextPainter(textDirection: TextDirection.ltr);
    final slot = size.width / labels.length;

    for (var i = 0; i < labels.length; i++) {
      painter.text = TextSpan(text: labels[i], style: labelStyle);
      painter.layout();
      var dx = slot * i + (slot - painter.width) / 2;
      dx = dx.clamp(0.0, math.max(0.0, size.width - painter.width));
      painter.paint(canvas, Offset(dx, size.height - painter.height + 4));
    }

    if (unit != null && unit!.isNotEmpty) {
      painter.text = TextSpan(text: unit!, style: labelStyle);
      painter.layout();
      painter.paint(canvas, Offset(size.width - painter.width, 0));
    }
  }

  @override
  bool shouldRepaint(_AxisLabelPainter old) =>
      old.labels != labels || old.unit != unit;
}

class _ProfileOverlayPainter extends CustomPainter {
  _ProfileOverlayPainter({
    required this.labels,
    required this.unit,
    required this.values,
    required this.highlightIndex,
    required this.labelStyle,
    required this.valueStyle,
    required this.pillColor,
    required this.borderColor,
  });

  final List<String> labels;
  final String unit;
  final List<double> values;
  final int? highlightIndex;
  final TextStyle labelStyle;
  final TextStyle valueStyle;
  final Color pillColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (labels.isEmpty) return;
    final painter = TextPainter(textDirection: TextDirection.ltr);
    final slot = size.width / labels.length;

    for (var i = 0; i < labels.length; i++) {
      painter.text = TextSpan(text: labels[i], style: labelStyle);
      painter.layout();
      final dx = (slot * i + (slot - painter.width) / 2)
          .clamp(0.0, math.max(0.0, size.width - painter.width))
          .toDouble();
      painter.paint(canvas, Offset(dx, size.height - painter.height + 2));
    }

    final index = highlightIndex;
    if (index == null || index < 0 || index >= values.length) return;

    final text = TextPainter(
      text: TextSpan(
        text: '${values[index].toStringAsFixed(unit == 'L' ? 2 : 0)}$unit',
        style: valueStyle,
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final x = size.width * index / math.max(1, values.length - 1);
    final box = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        x - text.width / 2 - 8,
        0,
        text.width + 16,
        text.height + 8,
      ),
      const Radius.circular(Radii.chip),
    );
    canvas.drawRRect(box, Paint()..color = pillColor);
    canvas.drawRRect(
      box,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    text.paint(canvas, Offset(x - text.width / 2, 4));
  }

  @override
  bool shouldRepaint(_ProfileOverlayPainter old) =>
      old.highlightIndex != highlightIndex || old.values != values;
}
