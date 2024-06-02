part of 'general_section.dart';

class _AccentColorTile extends StatelessWidget {
  const _AccentColorTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = context.colorScheme.primary;

    return BasedListTile(
      leadingIcon: Icons.color_lens_rounded,
      titleText: l10n.accentColor,
      trailing: ColorIndicator(
        color: color,
      ),
      onTap: () => context.pushDialog(
        _ColorPicker(initialColor: color),
      ),
    );
  }
}

class _ColorPicker extends HookConsumerWidget {
  const _ColorPicker({required this.initialColor});

  final Color initialColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final color = useState(initialColor);
    final setSettings = ref.watch(settingsProvider.notifier);

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.selectAccentColor),
      content: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: ColorWheelPicker(
            color: color.value,
            onWheel: (value) {},
            onChanged: (value) => color.value = value,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            setSettings.setAccentColor(null);
            context.pop();
          },
          child: Text(l10n.resetToDefault),
        ),
        TextButton(
          onPressed: () {
            setSettings.setAccentColor(color.value);
            context.pop();
          },
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}
