import 'package:mercurius/index.dart';

class TagSelector extends StatefulWidget {
  const TagSelector({super.key, required this.defaultMessage});

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
    Icons.bed_rounded,
  ];

  final String defaultMessage;

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  IconData _selectedIcon = TagSelector.iconDataList[0];
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.defaultMessage);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.insertTagTitle),
      content: BasedListView(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 64,
            ),
            itemCount: TagSelector.iconDataList.length,
            itemBuilder: (context, index) {
              final iconData = TagSelector.iconDataList[index];
              return IconButton(
                onPressed: () => setState(() {
                  _selectedIcon = iconData;
                }),
                icon: Icon(iconData),
                color: iconData != _selectedIcon
                    ? null
                    : context.colorScheme.primary,
              );
            },
          ),
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: l10n.insertTagMessage,
            ),
          ),
        ],
      ).adaptAlertDialog,
      actions: [
        TextButton(
          onPressed: () => context.pop(
            DiaryTag(
              codePoint: _selectedIcon.codePoint,
              fontFamily: _selectedIcon.fontFamily,
              fontPackage: _selectedIcon.fontPackage,
              matchTextDirection: _selectedIcon.matchTextDirection,
              message: _textEditingController.text,
            ),
          ),
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}
