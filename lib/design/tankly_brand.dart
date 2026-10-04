import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_type.dart';

/// The Tankly mark: a droplet cradling a gauge arc.
///
/// One shape, no text. Drawn rather than shipped as an asset so it stays crisp
/// at any size and recolours with the theme.
class TanklyMark extends StatelessWidget {
  const TanklyMark({super.key, this.size = 32, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _MarkPainter(color ?? context.palette.accent),
      ),
    );
  }
}

/// Full app icon: the mark on a near-black rounded square.
class TanklyAppIcon extends StatelessWidget {
  const TanklyAppIcon({super.key, this.size = 96, this.monochrome = false});

  final double size;

  /// Android themed icon variant: single flat colour, no background plate.
  final bool monochrome;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final radius = size * 0.2237; // Android adaptive-icon safe zone
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _IconPainter(
          plate: monochrome ? null : TanklyBrand.bg,
          plateRadius: radius,
          markColor: monochrome ? p.text : p.accent,
          notchColor: monochrome ? TanklyBrand.bg : TanklyBrand.bg,
        ),
      ),
    );
  }
}

/// Wordmark. Lowercase, slightly heavy, tabular so it does not shimmer.
class TanklyWordmark extends StatelessWidget {
  const TanklyWordmark({super.key, this.size = 26, this.showMark = true});

  final double size;
  final bool showMark;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showMark) ...[
          TanklyMark(size: size * 1.12),
          SizedBox(width: size * 0.28),
        ],
        Flexible(
          child: Text(
            'tankly',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TanklyType.number(
              size,
              weight: 700,
              color: p.text,
              tracking: -0.03,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _MarkPainter extends CustomPainter {
  const _MarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final cx = w / 2;
    final cy = size.height * 0.68;
    final r = w * 0.29;

    final drop = Path()
      ..moveTo(cx, size.height * 0.04)
      ..cubicTo(
        cx + w * 0.13,
        size.height * 0.32,
        cx + r,
        size.height * 0.45,
        cx + r,
        cy,
      )
      ..arcToPoint(
        Offset(cx - r, cy),
        radius: Radius.circular(r),
        clockwise: true,
      )
      ..cubicTo(
        cx - r,
        size.height * 0.45,
        cx - w * 0.13,
        size.height * 0.32,
        cx,
        size.height * 0.04,
      )
      ..close();

    canvas.drawPath(drop, Paint()..color = color);

    // Gauge arc carved out of the lower bulb.
    final arcRect = Rect.fromCircle(
      center: Offset(cx, cy - r * 0.42),
      radius: r * 0.74,
    );
    canvas.drawArc(
      arcRect,
      math.pi * 0.18,
      math.pi * 0.64,
      false,
      Paint()
        ..color = TanklyBrand.bg
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1.2, w * 0.075)
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_MarkPainter old) => old.color != color;
}

class _IconPainter extends CustomPainter {
  const _IconPainter({
    required this.plate,
    required this.plateRadius,
    required this.markColor,
    required this.notchColor,
  });

  final Color? plate;
  final double plateRadius;
  final Color markColor;
  final Color notchColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (plate != null) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(plateRadius),
        ),
        Paint()..color = plate!,
      );
    }
    final inset = size.width * 0.26;
    canvas.save();
    canvas.translate(inset, inset);
    _MarkPainter(
      markColor,
    ).paint(canvas, Size(size.width - inset * 2, size.width - inset * 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(_IconPainter old) =>
      old.plate != plate || old.markColor != markColor;
}
