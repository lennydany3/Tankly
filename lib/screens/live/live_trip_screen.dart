import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../data/models.dart';
import '../../design/fuel_gauge.dart';
import '../../design/route_map.dart';
import '../../domain/fuel.dart';
import '../../theme/tankly_palette.dart';
import '../../theme/tankly_tokens.dart';
import '../../theme/tankly_type.dart';

/// Live Trip. Pure black in dark theme, white in light — maximum contrast for
/// a handlebar mount in direct sun.
class LiveTripScreen extends StatelessWidget {
  const LiveTripScreen({
    super.key,
    this.snapshot,
    this.gps = LiveGps.locked,
    this.speedKmph = DemoData.liveSpeedKmph,
    this.distanceKm = DemoData.liveDistanceKm,
    this.elapsedS = DemoData.liveElapsedS,
    this.onStop,
  });

  final FuelSnapshot? snapshot;
  final LiveGps gps;
  final double speedKmph;
  final double distanceKm;
  final int elapsedS;
  final VoidCallback? onStop;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    // Text scaling is honoured up to 130 %. Past that the speed readout would
    // push the stop button off screen on a handlebar mount.
    final media = MediaQuery.of(context);
    return MediaQuery(
      data: media.copyWith(
        textScaler: media.textScaler.clamp(
          minScaleFactor: 1,
          maxScaleFactor: 1.3,
        ),
      ),
      child: Scaffold(
        backgroundColor: p.liveBg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Gap.lg, Gap.md, Gap.lg, Gap.lg),
            child: Column(
              children: [
                _StatusRow(gps: gps),
                const Spacer(flex: 2),
                _SpeedReadout(speedKmph: speedKmph, gps: gps),
                const Spacer(flex: 2),
                Row(
                  children: [
                    Expanded(
                      child: _LiveTile(
                        label: 'Distance',
                        value: distanceKm.toStringAsFixed(1),
                        unit: 'km',
                      ),
                    ),
                    const SizedBox(width: Gap.md),
                    Expanded(
                      child: _LiveTile(
                        label: 'Duration',
                        value: TimeLabel.stopwatch(elapsedS),
                        unit: 'min:s',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Gap.md),
                if (snapshot != null)
                  FuelStrip(snapshot: snapshot!, dense: true),
                const SizedBox(height: Gap.md),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: RouteMap(
                          route: DemoData.eveningRide.route,
                          borderRadius: BorderRadius.circular(Radii.card),
                        ),
                      ),
                      if (gps == LiveGps.searching)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: p.isDark
                                  ? Colors.black.withValues(alpha: 0.72)
                                  : Colors.white.withValues(alpha: 0.78),
                              borderRadius: BorderRadius.circular(Radii.card),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(Gap.md),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        TanklyIcons.gpsSearching,
                                        color: p.info,
                                        size: 30,
                                      ),
                                      const SizedBox(height: Gap.sm),
                                      Text(
                                        'Looking for GPS',
                                        textAlign: TextAlign.center,
                                        style: TanklyType.ui(
                                          TanklyType.label,
                                          weight: 700,
                                          color: p.text,
                                        ),
                                      ),
                                      Text(
                                        'Distance is paused until it locks on.',
                                        textAlign: TextAlign.center,
                                        style: TanklyType.ui(
                                          TanklyType.caption,
                                          color: p.textDim,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: Gap.md),
                _StopButton(onPressed: onStop),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// GPS signal state on the Live Trip screen.
enum LiveGps { locked, searching }

extension on LiveGps {
  IconData get icon => switch (this) {
    LiveGps.locked => TanklyIcons.gpsLocked,
    LiveGps.searching => TanklyIcons.gpsSearching,
  };

  String get label => switch (this) {
    LiveGps.locked => 'GPS ±${DemoData.gpsAccuracyM.toStringAsFixed(0)} m',
    LiveGps.searching => 'No GPS',
  };
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.gps});

  final LiveGps gps;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final gpsColor = gps == LiveGps.locked ? p.good : p.info;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Gap.md, vertical: 7),
          decoration: BoxDecoration(
            color: p.surface,
            borderRadius: BorderRadius.circular(Radii.chip),
            border: Border.all(color: p.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _RecordingDot(),
              const SizedBox(width: Gap.sm),
              Text(
                'Recording',
                style: TanklyType.ui(
                  TanklyType.label - 1,
                  weight: 700,
                  color: p.text,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(gps.icon, size: 17, color: gpsColor),
            const SizedBox(width: 6),
            Text(
              gps.label,
              style: TanklyType.ui(
                TanklyType.caption + 1,
                weight: 600,
                color: gpsColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RecordingDot extends StatefulWidget {
  @override
  State<_RecordingDot> createState() => _RecordingDotState();
}

class _RecordingDotState extends State<_RecordingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(
          color: p.critical.withValues(alpha: 0.45 + 0.55 * _controller.value),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _SpeedReadout extends StatelessWidget {
  const _SpeedReadout({required this.speedKmph, required this.gps});

  final double speedKmph;
  final LiveGps gps;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    // Below 2 km/h the display is held at zero: GPS noise at a standstill
    // should never show as 3 km/h.
    final shown = gps == LiveGps.searching ? 0.0 : speedKmph;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          shown.toStringAsFixed(0),
          style: TanklyType.number(
            TanklyType.speedHero,
            weight: 700,
            color: p.text,
            height: 0.86,
            tracking: -0.05,
          ),
        ),
        const SizedBox(height: Gap.sm),
        Text('km/h', style: TanklyType.ui(26, weight: 600, color: p.textDim)),
      ],
    );
  }
}

class _LiveTile extends StatelessWidget {
  const _LiveTile({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      height: 96,
      padding: const EdgeInsets.all(Gap.md + 2),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(Radii.card),
        border: Border.all(color: p.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TanklyType.ui(TanklyType.caption, color: p.textDim),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TanklyType.number(
                    30,
                    weight: 700,
                    color: p.text,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: TanklyType.ui(
                  TanklyType.caption,
                  weight: 600,
                  color: p.textDim,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StopButton extends StatelessWidget {
  const _StopButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SizedBox(
      height: Sizes.rideButton,
      width: double.infinity,
      child: Material(
        color: p.critical,
        borderRadius: BorderRadius.circular(Radii.riding),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.stop_rounded, color: Colors.white, size: 28),
              const SizedBox(width: Gap.md),
              Text(
                'Stop ride',
                style: TanklyType.ui(
                  TanklyType.title,
                  weight: 700,
                  color: Colors.white,
                  tracking: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
