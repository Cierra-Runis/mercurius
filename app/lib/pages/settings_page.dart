import 'package:mercurius/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: const Center(
        child: BasedListView(
          children: [
            BasedListSection(
              children: [
                _ThemeSelectListTile(),
                _AccentColorListTile(),
                _BackgroundImageListTile(),
                _LanguageSelectListTile(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSelectListTile extends ConsumerWidget {
  const _ThemeSelectListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.dark_mode_rounded,
      titleText: l10n.darkMode,
      trailing: const _ThemeSelector(),
    );
  }
}

class _ThemeSelector extends ConsumerWidget {
  const _ThemeSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return SegmentedButton<ThemeMode>(
      showSelectedIcon: false,
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
      ),
      segments: [
        ButtonSegment(
          value: ThemeMode.system,
          tooltip: l10n.followTheSystem,
          label: Icon(App.themeModeIcon[ThemeMode.system]),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          tooltip: l10n.alwaysDark,
          label: Icon(App.themeModeIcon[ThemeMode.dark]),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          tooltip: l10n.alwaysBright,
          label: Icon(App.themeModeIcon[ThemeMode.light]),
        ),
      ],
      selected: {settings.themeMode},
      onSelectionChanged: (p0) => settingsNotifier.setThemeMode(p0.first),
    );
  }
}

class _AccentColorListTile extends ConsumerWidget {
  const _AccentColorListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final color = context.colorScheme.primary;

    return BasedListTile(
      leadingIcon: Icons.color_lens_rounded,
      titleText: l10n.accentColor,
      trailing: ColorIndicator(
        color: color,
      ),
      onTap: () => context.pushDialog(
        _ColorPicker(color: color),
      ),
    );
  }
}

class _ColorPicker extends ConsumerStatefulWidget {
  const _ColorPicker({
    required this.color,
  });

  final Color color;
  @override
  ConsumerState<_ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends ConsumerState<_ColorPicker> {
  late Color _color = widget.color;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dynamicColor = ref.watch(dynamicColorProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return AlertDialog(
      scrollable: true,
      title: Text(l10n.selectAccentColor),
      content: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: ColorWheelPicker(
            color: _color,
            onWheel: (value) {},
            onChanged: (value) => setState(() => _color = value),
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
            setSettings.setAccentColor(dynamicColor.seedColor);
            context.pop();
          },
          child: Text(l10n.resetToDefault),
        ),
        TextButton(
          onPressed: () {
            setSettings.setAccentColor(_color);
            context.pop();
          },
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}

class _BackgroundImageListTile extends ConsumerWidget {
  const _BackgroundImageListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);

    return BasedListTile(
      leadingIcon: Icons.flip_to_back_rounded,
      titleText: l10n.backgroundImage,
      detailText: settings.bgImgPath == null ? l10n.noImageSelected : '',
      onTap: () => context.push(const _BackgroundImagePage()),
    );
  }
}

class _BackgroundImagePage extends ConsumerWidget {
  const _BackgroundImagePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.watch(settingsProvider.notifier);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.backgroundImage),
        actions: [
          TextButton(
            onPressed: () => settingsNotifier.setBgImgPath(null),
            child: Text(l10n.clear),
          ),
        ],
      ),
      body: Gallery(
        onCardTap: (context, filename) {
          settingsNotifier.setBgImgPath(filename);
          context.pop();
        },
      ),
    );
  }
}

class _LanguageSelectListTile extends StatelessWidget {
  const _LanguageSelectListTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.translate_rounded,
      titleText: l10n.language,
      onTap: () => context.push(const LanguagePage()),
    );
  }
}
