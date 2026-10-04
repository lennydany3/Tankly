import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/tankly_palette.dart';
import '../theme/tankly_tokens.dart';
import '../theme/tankly_type.dart';

/// Large numeric input for litres, rupees and odometer readings.
///
/// Deliberately bigger than a normal text field: these get typed with gloves
/// on, often one-handed at a fuel pump.
class NumericField extends StatefulWidget {
  const NumericField({
    super.key,
    required this.label,
    this.value,
    this.unit,
    this.helper,
    this.prefix,
    this.icon,
    this.onChanged,
    this.autofocus = false,
    this.errorText,
  });

  final String label;
  final String? value;
  final String? unit;
  final String? helper;
  final String? prefix;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final String? errorText;

  @override
  State<NumericField> createState() => _NumericFieldState();
}

class _NumericFieldState extends State<NumericField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TanklyType.ui(
              TanklyType.label,
              weight: 500,
              color: p.textDim,
            ),
          ),
          const SizedBox(height: Gap.sm),
          TextField(
            controller: _controller,
            autofocus: widget.autofocus,
            onChanged: widget.onChanged,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            style: TanklyType.number(
              28,
              weight: 700,
              color: p.text,
              height: 1.1,
            ),
            decoration: InputDecoration(
              errorText: widget.errorText,
              hintText: '0',
              hintStyle: TanklyType.number(28, weight: 700, color: p.textDim),
              prefixIcon: widget.icon == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: Gap.lg,
                        right: Gap.sm,
                      ),
                      child: Icon(widget.icon, color: p.textDim, size: 22),
                    ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              prefixStyle: TanklyType.number(28, weight: 700, color: p.textDim),
              prefixText: widget.prefix,
              suffixText: widget.unit,
              suffixStyle: TanklyType.ui(
                TanklyType.body,
                weight: 600,
                color: p.textDim,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Gap.lg,
                vertical: Gap.lg - 2,
              ),
            ),
          ),
          if (widget.helper != null)
            Padding(
              padding: const EdgeInsets.only(top: Gap.xs + 2, left: Gap.xs),
              child: Text(
                widget.helper!,
                style: TanklyType.ui(
                  TanklyType.caption,
                  color: p.textDim,
                  height: 1.35,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Plain labelled text input, for names and titles.
class LabelledField extends StatefulWidget {
  const LabelledField({
    super.key,
    required this.label,
    this.value,
    this.helper,
    this.icon,
    this.onChanged,
  });

  final String label;
  final String? value;
  final String? helper;
  final IconData? icon;
  final ValueChanged<String>? onChanged;

  @override
  State<LabelledField> createState() => _LabelledFieldState();
}

class _LabelledFieldState extends State<LabelledField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TanklyType.ui(
              TanklyType.label,
              weight: 500,
              color: p.textDim,
            ),
          ),
          const SizedBox(height: Gap.sm),
          TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            style: TanklyType.ui(
              TanklyType.body + 2,
              weight: 600,
              color: p.text,
            ),
            decoration: InputDecoration(
              hintText: widget.label,
              prefixIcon: widget.icon == null
                  ? null
                  : Icon(widget.icon, color: p.textDim, size: 20),
            ),
          ),
          if (widget.helper != null)
            Padding(
              padding: const EdgeInsets.only(top: Gap.xs + 2, left: Gap.xs),
              child: Text(
                widget.helper!,
                style: TanklyType.ui(
                  TanklyType.caption,
                  color: p.textDim,
                  height: 1.35,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Read-only summary block used for the refuel preview.
class PreviewCard extends StatelessWidget {
  const PreviewCard({
    super.key,
    required this.title,
    required this.value,
    required this.secondary,
    this.color,
    this.icon = Icons.auto_graph_rounded,
  });

  final String title;
  final String value;
  final String secondary;
  final Color? color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final tint = color ?? p.accent;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Gap.card),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: p.isDark ? 0.12 : 0.09),
        borderRadius: BorderRadius.circular(Radii.card),
        border: Border.all(color: tint.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Icon(icon, color: tint, size: 24),
          const SizedBox(width: Gap.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TanklyType.ui(
                    TanklyType.caption,
                    weight: 600,
                    color: p.textDim,
                  ),
                ),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: TanklyType.number(
                          24,
                          weight: 700,
                          color: p.text,
                          height: 1.1,
                        ),
                      ),
                      TextSpan(
                        text: '   $secondary',
                        style: TanklyType.number(
                          24,
                          weight: 700,
                          color: tint,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
