import 'package:mercurius/index.dart';

class TagSelectorWidget extends StatefulWidget {
  const TagSelectorWidget({super.key, required this.defaultMessage});

  static const List<IconData> iconDataList = [
    Icons.access_time_rounded,
    Icons.access_time_filled_rounded,
    Icons.access_alarm_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.ad_units_rounded,
    Icons.assignment_outlined,
    Icons.attractions_rounded,
    Icons.audiotrack_rounded,
    Icons.auto_awesome_rounded,
    Icons.badge_rounded,
    Icons.balance_rounded,
    Icons.bathtub_rounded,
    Icons.beach_access_rounded,
    Icons.bed_rounded
  ];

  final String defaultMessage;

  @override
  State<TagSelectorWidget> createState() => _TagSelectorWidgetState();
}

class _TagSelectorWidgetState extends State<TagSelectorWidget> {
  IconData _selectedIcon = TagSelectorWidget.iconDataList[0];
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.defaultMessage);
  }

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return AlertDialog(
      title: Text(l10n.insertTagTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 64,
                ),
                itemCount: TagSelectorWidget.iconDataList.length,
                itemBuilder: (context, index) {
                  IconData iconData = TagSelectorWidget.iconDataList[index];
                  return IconButton(
                    onPressed: () => setState(() {
                      _selectedIcon = iconData;
                    }),
                    icon: Icon(iconData),
                    color: iconData != _selectedIcon
                        ? null
                        : Theme.of(context).colorScheme.primary,
                  );
                },
              ),
            ),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: l10n.insertTagMessage,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            DiaryTag(
              codePoint: _selectedIcon.codePoint,
              fontFamily: _selectedIcon.fontFamily,
              fontPackage: _selectedIcon.fontPackage,
              matchTextDirection: _selectedIcon.matchTextDirection,
              message: _textEditingController.text,
            ),
          ),
          child: Text(l10n.confirm),
        )
      ],
    );
  }
}
