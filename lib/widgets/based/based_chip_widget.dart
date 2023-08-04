import 'package:mercurius/index.dart';

class BaseChipWidget extends StatelessWidget {
  const BaseChipWidget({
    super.key,
    required this.label,
    this.borderRadius = 8,
    this.keepLeadingArea = true,
    this.keepTracingArea = false,
    this.labelLeadingSpacing = 4,
    this.labelTracingSpacing = 4,
    this.labelWidth,
    this.labelColor,
    this.fontWeight,
    this.leadingIconData,
    this.tracingIconData,
    this.leadingIconColor,
    this.tracingIconColor,
    this.onTap,
  });

  final String label;
  final double borderRadius;
  final bool keepLeadingArea;
  final bool keepTracingArea;
  final double labelLeadingSpacing;
  final double labelTracingSpacing;
  final double? labelWidth;
  final Color? labelColor;
  final FontWeight? fontWeight;
  final IconData? leadingIconData;
  final Color? leadingIconColor;
  final IconData? tracingIconData;
  final Color? tracingIconColor;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(
            children: [
              if (keepLeadingArea || leadingIconData != null)
                Icon(
                  leadingIconData,
                  color: leadingIconColor ?? colorScheme.onSurface,
                  size: 20,
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  labelLeadingSpacing,
                  0,
                  labelTracingSpacing,
                  0,
                ),
                child: SizedBox(
                  width: labelWidth,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: labelColor,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
              ),
              if (keepTracingArea || tracingIconData != null)
                Icon(
                  tracingIconData,
                  color: tracingIconColor ?? colorScheme.onSurface,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
