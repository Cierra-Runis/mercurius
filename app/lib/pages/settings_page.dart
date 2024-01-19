import 'package:mercurius/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

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
                // _BackgroundImageListTile(),
                _LanguageSelectListTile(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class _BackgroundImageListTile extends ConsumerWidget {
//   const _BackgroundImageListTile();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l10n = L10N.maybeOf(context) ?? L10N.current;
//     final settings = ref.watch(settingsProvider);
//     final settingsNotifier = ref.watch(settingsProvider.notifier);

//     return BasedListTile(
//       leadingIcon: Icons.flip_to_back_rounded,
//       titleText: l10n.backgroundImage,
//       detailText: settings.bgImgId == null ? l10n.noImageSelected : '',
//       onTap: () {
//         context.push(
//           GalleryPage(
//             onTap: (context, image) {
//               settingsNotifier.setBgImgId(image.id);
//               context.pop();
//             },
//           ),
//         );
//       },
//     );
//   }
// }

class _AccentColorListTile extends ConsumerWidget {
  const _AccentColorListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dynamicColor = ref.watch(dynamicColorProvider);
    final settings = ref.watch(settingsProvider);
    final color = settings.accentColor ?? dynamicColor.seedColor;
    return BasedListTile(
      leadingIcon: Icons.color_lens_rounded,
      titleText: '主题色',
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
    final l10n = L10N.maybeOf(context) ?? L10N.current;
    final dynamicColor = ref.watch(dynamicColorProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return AlertDialog(
      title: Text(l10n.selectAccentColor),
      content: ColorWheelPicker(
        color: _color,
        onWheel: (value) {},
        onChanged: (value) => setState(() => _color = value),
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

class _ThemeSelectListTile extends ConsumerWidget {
  const _ThemeSelectListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return BasedListTile(
      leadingIcon: Icons.dark_mode_rounded,
      titleText: l10n.darkMode,
      trailing: const ThemeSelector(),
    );
  }
}

class _LanguageSelectListTile extends StatelessWidget {
  const _LanguageSelectListTile();

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return BasedListTile(
      leadingIcon: Icons.translate_rounded,
      titleText: l10n.language,
      onTap: () => context.push(const LanguagePage()),
    );
  }
}
