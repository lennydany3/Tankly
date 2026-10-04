import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/tankly_palette.dart';
import '../theme/tankly_tokens.dart';

/// Stylised dark map used wherever a real tile layer is not wired up yet.
///
/// Draws a plausible street grid plus the ride's route. Swapping in
/// `flutter_map` means replacing this one widget — the route data is already in
/// the normalised 0–1 form `PolylineLayer` wants.
class RouteMap extends StatelessWidget {
  const RouteMap({
    super.key,
    required this.route,
    this.height = 168,
    this.borderRadius,
    this.showMarkers = true,
    this.startLabel,
    this.endLabel,
    this.padding = 0.16,
  });

  final List<Offset> route;
  final double height;
  final BorderRadius? borderRadius;
  final bool showMarkers;
  final String? startLabel;
  final String? endLabel;

  /// Fraction of the shorter axis kept clear around the route.
  final double padding;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(Radii.thumb),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _RouteMapPainter(
            route: route,
            palette: p,
            padding: padding,
            showMarkers: showMarkers,
          ),
          child: (startLabel != null || endLabel != null)
              ? _MapLabels(
                  startLabel: startLabel,
                  endLabel: endLabel,
                  route: route,
                  padding: padding,
                )
              : null,
        ),
      ),
    );
  }
}

class _MapLabels extends StatelessWidget {
  const _MapLabels({
    required this.startLabel,
    required this.endLabel,
    required this.route,
    required this.padding,
  });

  final String? startLabel;
  final String? endLabel;
  final List<Offset> route;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    if (route.length < 2) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (context, constraints) {
        final fit = _fit(
          route,
          Size(constraints.maxWidth, constraints.maxHeight),
          padding,
        );
        final scale = fit.scale;
        Offset at(int i) => Offset(
          fit.offset.dx + route[i].dx * scale,
          fit.offset.dy + route[i].dy * scale,
        );

        Widget chip(String text, Alignment align, Offset at_) => Align(
          alignment: align,
          child: Padding(
            padding: const EdgeInsets.all(Gap.sm),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Gap.sm,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: p.isDark
                    ? TanklyBrand.bg.withValues(alpha: 0.82)
                    : Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(Radii.chip),
                border: Border.all(color: p.outline),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: p.text,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        );

        return Stack(
          children: [
            if (startLabel != null)
              Positioned(
                left: 0,
                top: math.max(0, at(0).dy - 34),
                width: constraints.maxWidth,
                child: chip(startLabel!, Alignment.centerLeft, at(0)),
              ),
            if (endLabel != null)
              Positioned(
                left: 0,
                top: math.min(
                  constraints.maxHeight - 32,
                  at(route.length - 1).dy + 8,
                ),
                width: constraints.maxWidth,
                child: chip(
                  endLabel!,
                  Alignment.centerRight,
                  at(route.length - 1),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Scales normalised route points into the given box, preserving aspect ratio.
class _Fit {
  const _Fit(this.scale, this.offset);
  final double scale;
  final Offset offset;
}

_Fit _fit(List<Offset> points, Size size, double padding) {
  var minX = double.infinity, maxX = -double.infinity;
  var minY = double.infinity, maxY = -double.infinity;
  for (final p in points) {
    minX = math.min(minX, p.dx);
    maxX = math.max(maxX, p.dx);
    minY = math.min(minY, p.dy);
    maxY = math.max(maxY, p.dy);
  }
  final w = math.max(0.001, maxX - minX);
  final h = math.max(0.001, maxY - minY);
  final usable = Size(
    size.width * (1 - padding * 2),
    size.height * (1 - padding * 2),
  );
  final scale = math.min(usable.width / w, usable.height / h);
  final drawn = Size(w * scale, h * scale);
  return _Fit(
    scale,
    Offset(
      (size.width - drawn.width) / 2 - minX * scale,
      (size.height - drawn.height) / 2 - minY * scale,
    ),
  );
}

class _RouteMapPainter extends CustomPainter {
  _RouteMapPainter({
    required this.route,
    required this.palette,
    required this.padding,
    required this.showMarkers,
  });

  final List<Offset> route;
  final TanklyPalette palette;
  final double padding;
  final bool showMarkers;

  /// Deterministic layout: the same street grid every launch.
  static final List<Rect> _blocks = _buildBlocks();
  static final List<List<Offset>> _roads = _buildRoads();

  static List<Rect> _buildBlocks() {
    final random = math.Random(7);
    final blocks = <Rect>[];
    for (var row = 0; row < 5; row++) {
      for (var col = 0; col < 4; col++) {
        final x = col * 0.25 + random.nextDouble() * 0.04;
        final y = row * 0.2 + random.nextDouble() * 0.03;
        final w = 0.13 + random.nextDouble() * 0.09;
        final h = 0.10 + random.nextDouble() * 0.06;
        blocks.add(Rect.fromLTWH(x, y, w, h));
      }
    }
    return blocks;
  }

  static List<List<Offset>> _buildRoads() {
    return [
      [
        const Offset(-0.05, 0.22),
        const Offset(0.45, 0.28),
        const Offset(1.05, 0.20),
      ],
      [
        const Offset(0.10, -0.05),
        const Offset(0.18, 0.52),
        const Offset(0.10, 1.05),
      ],
      [
        const Offset(0.62, -0.05),
        const Offset(0.58, 0.48),
        const Offset(0.72, 1.05),
      ],
      [
        const Offset(-0.05, 0.74),
        const Offset(0.52, 0.66),
        const Offset(1.05, 0.78),
      ],
      [
        const Offset(0.86, -0.05),
        const Offset(0.80, 0.50),
        const Offset(0.92, 1.05),
      ],
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..color = palette.mapBase);

    for (final block in _blocks) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            block.left * size.width,
            block.top * size.height,
            block.width * size.width,
            block.height * size.height,
          ),
          const Radius.circular(3),
        ),
        Paint()..color = palette.mapBlock,
      );
    }

    for (final road in _roads) {
      final path = Path()
        ..moveTo(road.first.dx * size.width, road.first.dy * size.height);
      for (final p in road.skip(1)) {
        path.lineTo(p.dx * size.width, p.dy * size.height);
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = palette.mapRoad
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round,
      );
    }

    if (route.length < 2) return;

    final fit = _fit(route, size, padding);
    final path = Path()
      ..moveTo(
        fit.offset.dx + route.first.dx * fit.scale,
        fit.offset.dy + route.first.dy * fit.scale,
      );
    for (final p in route.skip(1)) {
      path.lineTo(
        fit.offset.dx + p.dx * fit.scale,
        fit.offset.dy + p.dy * fit.scale,
      );
    }

    // Casing first, then the accent line on top.
    canvas.drawPath(
      path,
      Paint()
        ..color = palette.isDark
            ? Colors.black.withValues(alpha: 0.55)
            : Colors.white.withValues(alpha: 0.9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = palette.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    if (!showMarkers) return;

    final start = Offset(
      fit.offset.dx + route.first.dx * fit.scale,
      fit.offset.dy + route.first.dy * fit.scale,
    );
    final end = Offset(
      fit.offset.dx + route.last.dx * fit.scale,
      fit.offset.dy + route.last.dy * fit.scale,
    );

    _marker(canvas, start, filled: true);
    _marker(canvas, end, filled: false);
  }

  void _marker(Canvas canvas, Offset at, {required bool filled}) {
    canvas.drawCircle(
      at,
      7,
      Paint()..color = palette.isDark ? TanklyBrand.bg : Colors.white,
    );
    if (filled) {
      canvas.drawCircle(at, 5, Paint()..color = palette.accent);
    } else {
      canvas.drawCircle(
        at,
        5,
        Paint()
          ..color = palette.accent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );
    }
  }

  @override
  bool shouldRepaint(_RouteMapPainter old) =>
      old.route != route ||
      old.palette != palette ||
      old.padding != padding ||
      old.showMarkers != showMarkers;
}
