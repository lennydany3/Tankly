import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:tankly/domain/models/fuel.dart';
import 'package:tankly/theme/tankly_palette.dart';
import 'package:tankly/theme/tankly_tokens.dart';
import 'package:tankly/theme/tankly_type.dart';

/// Slow breathing loop for critical fuel. Never a flash.
class Pulse extends StatefulWidget {
  const Pulse({super.key, required this.child, this.enabled = true});

  final Widget child;
  final bool enabled;

  @override
  State<Pulse> createState() => _PulseState();
}

class _PulseState extends State<Pulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Motion.pulse,
  );

  @override
  void initState() {
    super.initState();
    // Create the ticker here, never lazily from dispose(). Assigning the value
    // does not start it, so a disabled Pulse costs no frames.
    _controller.value = 1;
    if (widget.enabled) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(Pulse old) {
    super.didUpdateWidget(old);
    if (widget.enabled == old.enabled) return;
    if (widget.enabled) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled || MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.7,
        end: 1,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: widget.child,
    );
  }
}

/// Colour for a fuel status. The only place green/yellow/orange/red appear.
Color fuelColor(BuildContext context, FuelStatus status) => switch (status) {
  FuelStatus.good => context.palette.good,
  FuelStatus.medium => context.palette.medium,
  FuelStatus.low => context.palette.low,
  FuelStatus.critical => context.palette.critical,
};

/// Icon paired with every fuel colour so state never depends on hue alone.
IconData fuelIcon(FuelStatus status) => switch (status) {
  FuelStatus.good => Icons.local_gas_station_rounded,
  FuelStatus.medium => Icons.local_gas_station_rounded,
  FuelStatus.low => Icons.error_outline_rounded,
  FuelStatus.critical => Icons.warning_rounded,
};

/// The hero element. A 240° arc with the estimate in the middle.
class FuelGauge extends StatelessWidget {
  const FuelGauge({
    super.key,
    required this.snapshot,
    this.size = 260,
    this.showLegend = true,
  });

  final FuelSnapshot snapshot;
  final double size;
  final bool showLegend;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = fuelColor(context, snapshot.status);
    final critical = snapshot.status == FuelStatus.critical;

    return SizedBox.square(
      dimension: size,
      child: Pulse(
        enabled: critical,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: snapshot.fillRatio),
          duration: Motion.gauge,
          curve: Motion.easeOut,
          builder: (context, fill, _) => CustomPaint(
            painter: _ArcPainter(
              fillRatio: fill,
              reserveRatio: snapshot.reserveRatio,
              color: color,
              trackColor: p.surfaceHigh,
              tickColor: p.textDim,
            ),
            child: Center(
              child: Padding(
                // Lift the readout above the arc's optical centre.
                padding: EdgeInsets.only(bottom: size * 0.10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _Estimate(
                      value: snapshot.litresLeft.toStringAsFixed(2),
                      unit: 'L',
                      color: p.text,
                      tildeColor: p.textDim,
                      unitColor: p.textDim,
                      size: size * 0.215,
                    ),
                    SizedBox(height: size * 0.045),
                    Text(
                      '${snapshot.rangeKm.toStringAsFixed(0)} km range',
                      style: TanklyType.ui(
                        TanklyType.title - 2,
                        weight: 700,
                        color: p.text,
                      ),
                    ),
                    if (showLegend) ...[
                      SizedBox(height: size * 0.06),
                      FuelLegend(status: snapshot.status, color: color),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// `~0.40 L` with the tilde and unit set smaller and dimmer than the digits.
class _Estimate extends StatelessWidget {
  const _Estimate({
    required this.value,
    required this.unit,
    required this.color,
    required this.tildeColor,
    required this.unitColor,
    this.size = TanklyType.hero,
  });

  final String value;
  final String unit;
  final Color color;
  final Color tildeColor;
  final Color unitColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '~',
            style: TanklyType.number(
              size * 0.5,
              weight: 600,
              color: tildeColor,
            ),
          ),
          TextSpan(
            text: value,
            style: TanklyType.number(
              size,
              weight: 700,
              color: color,
              height: 0.95,
              tracking: -0.035,
            ),
          ),
          TextSpan(
            text: ' $unit',
            style: TanklyType.number(
              size * 0.36,
              weight: 600,
              color: unitColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Status pill: icon + word + "estimated". Redundant encoding on purpose.
class FuelLegend extends StatelessWidget {
  const FuelLegend({super.key, required this.status, required this.color});

  final FuelStatus status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 12, 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: p.isDark ? 0.14 : 0.12),
        borderRadius: BorderRadius.circular(Radii.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(fuelIcon(status), size: 15, color: color),
          const SizedBox(width: 6),
          Flexible(
            flex: 3,
            child: Text(
              status.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TanklyType.ui(
                TanklyType.label - 1,
                weight: 700,
                color: color,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              ' · estimated',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TanklyType.ui(TanklyType.caption, color: p.textDim),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact fuel readout for the Live Trip screen.
class FuelStrip extends StatelessWidget {
  const FuelStrip({super.key, required this.snapshot, this.dense = false});

  final FuelSnapshot snapshot;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = fuelColor(context, snapshot.status);
    final critical = snapshot.status == FuelStatus.critical;

    return Pulse(
      enabled: critical,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: Gap.lg,
          vertical: dense ? Gap.md : Gap.lg - 2,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: p.isDark ? 0.13 : 0.10),
          borderRadius: BorderRadius.circular(Radii.card),
          border: Border.all(color: color.withValues(alpha: 0.55)),
        ),
        child: Row(
          children: [
            Icon(
              fuelIcon(snapshot.status),
              color: color,
              size: dense ? 20 : 24,
            ),
            SizedBox(width: dense ? Gap.sm : Gap.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Petrol left · estimated',
                    style: TanklyType.ui(TanklyType.caption, color: p.textDim),
                  ),
                  const SizedBox(height: 2),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '~${snapshot.litresLeft.toStringAsFixed(2)}',
                          style: TanklyType.number(
                            dense ? 22 : 26,
                            weight: 700,
                            color: p.text,
                            height: 1,
                          ),
                        ),
                        TextSpan(
                          text: ' L',
                          style: TanklyType.ui(
                            13,
                            weight: 600,
                            color: p.textDim,
                          ),
                        ),
                        TextSpan(
                          text: '   ~${snapshot.rangeKm.toStringAsFixed(0)} km',
                          style: TanklyType.number(
                            dense ? 22 : 26,
                            weight: 700,
                            color: color,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              snapshot.status.label,
              style: TanklyType.ui(
                TanklyType.label - 2,
                weight: 700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  const _ArcPainter({
    required this.fillRatio,
    required this.reserveRatio,
    required this.color,
    required this.trackColor,
    required this.tickColor,
  });

  final double fillRatio;
  final double reserveRatio;
  final Color color;
  final Color trackColor;
  final Color tickColor;

  /// 240°, opening at the bottom.
  static const _start = math.pi * 0.8333;
  static const _sweep = math.pi * 1.3333;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.56);
    final stroke = size.width * 0.075;
    final radius = size.width / 2 - stroke / 2 - size.width * 0.075;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = trackColor;
    canvas.drawArc(rect, _start, _sweep, false, track);

    if (fillRatio > 0) {
      final fill = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..color = color;
      canvas.drawArc(
        rect,
        _start,
        _sweep * fillRatio.clamp(0.0, 1.0),
        false,
        fill,
      );
    }

    // Reserve notch: a short bright tick sitting inside the track.
    final reserveAngle = _start + _sweep * reserveRatio;
    final inner =
        center +
        Offset(math.cos(reserveAngle), math.sin(reserveAngle)) *
            (radius - stroke * 0.78);
    final outer =
        center +
        Offset(math.cos(reserveAngle), math.sin(reserveAngle)) *
            (radius - stroke * 0.22);
    canvas.drawLine(
      inner,
      outer,
      Paint()
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..color = trackColor,
    );

    // Quarter ticks, drawn clear of the arc.
    final tick = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = tickColor.withValues(alpha: 0.55);
    for (final ratio in const [0.0, 0.25, 0.5, 1.0]) {
      final angle = _start + _sweep * ratio;
      final from =
          center +
          Offset(math.cos(angle), math.sin(angle)) * (radius + stroke * 0.55);
      final to =
          center +
          Offset(math.cos(angle), math.sin(angle)) * (radius + stroke * 0.95);
      canvas.drawLine(from, to, tick);
    }
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.fillRatio != fillRatio ||
      old.reserveRatio != reserveRatio ||
      old.color != color ||
      old.trackColor != trackColor;
}
