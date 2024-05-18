import 'dart:math' as math;

import 'package:mercurius/index.dart';

class GeneralSettingsSection extends StatelessWidget {
  const GeneralSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListSection(
      titleText: l10n.generalSettings,
      children: const [
        _ThemeSelectListTile(),
        _AccentColorListTile(),
        _BackgroundImageListTile(),
        _LanguageSelectListTile(),
        _CacheCleaningTile(),
      ],
    );
  }
}

class _ThemeSelectListTile extends StatelessWidget {
  const _ThemeSelectListTile();

  @override
  Widget build(BuildContext context) {
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
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
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

class _AccentColorListTile extends StatelessWidget {
  const _AccentColorListTile();

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
        _ColorPicker(color: color),
      ),
    );
  }
}

class _ColorPicker extends ConsumerStatefulWidget {
  const _ColorPicker({required this.color});

  final Color color;
  @override
  ConsumerState<_ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends ConsumerState<_ColorPicker> {
  late Color _color = widget.color;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
            setSettings.setAccentColor(null);
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
      detailText: settings.bgImgPath ?? l10n.noImageSelected,
      onTap: () => context.push(const _BackgroundImagePage()),
    );
  }
}

class _BackgroundImagePage extends ConsumerWidget {
  const _BackgroundImagePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paths = ref.watch(pathsProvider);
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
        directory: paths.imageDirectory,
        onCardTap: (context, filename) {
          settingsNotifier.setBgImgPath(filename);
          context.pop();
        },
      ),
    );
  }
}

class _LanguageSelectListTile extends ConsumerWidget {
  const _LanguageSelectListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);

    final humanString = App.supportLanguages[settings.locale];

    return BasedListTile(
      leadingIcon: Icons.translate_rounded,
      titleText: l10n.language,
      detailText: humanString ?? l10n.followTheSystem,
      onTap: () => context.push(const _LanguagePage()),
    );
  }
}

class _LanguagePage extends ConsumerWidget {
  const _LanguagePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BasedRadioListTile<Locale?>(
              value: null,
              groupValue: settings.locale,
              titleText: l10n.followTheSystem,
              onChanged: setSettings.setLocale,
            ),
          ),
          SliverList.builder(
            itemCount: App.supportLanguages.length,
            itemBuilder: (context, index) {
              final MapEntry(key: locale, value: humanString) =
                  App.supportLanguages.entries.elementAt(index);
              return BasedRadioListTile<Locale>(
                value: locale,
                groupValue: settings.locale,
                titleText: '$humanString ($locale)',
                onChanged: setSettings.setLocale,
              );
            },
          ),
        ],
      ),
    );
  }
}

abstract class _Bytes {
  static String format({
    required int bytes,
    int decimals = 2,
  }) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

extension _FileSystemEntityExt on FileSystemEntity {
  int getBytes() => switch (this) {
        final File file => file.lengthSync(),
        final Directory directory => directory.getBytes(),
        _ => 0,
      };
}

extension _DirectoryExt on Directory {
  int getBytes() {
    var sum = 0;
    for (final file in listSync()) {
      sum += file.getBytes();
    }
    return sum;
  }
}

class _CacheCleaningTile extends ConsumerWidget {
  const _CacheCleaningTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final paths = ref.watch(pathsProvider);
    final appCache = paths.appCache;
    return BasedListTile(
      leadingIcon: Icons.cleaning_services_rounded,
      titleText: l10n.cacheCleaning,
      onTap: () {
        final files = appCache.listSync();
        for (final file in files) {
          try {
            file.deleteSync(recursive: true);
          } catch (e) {
            App.printLog('File / Directory delete Failed', error: e);
          }
        }
        ref.invalidate(pathsProvider);
      },
      detailText: _Bytes.format(bytes: appCache.getBytes()),
    );
  }
}
