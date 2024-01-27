import 'package:mercurius/index.dart';

class TagSelector extends StatefulWidget {
  const TagSelector({
    super.key,
    required this.defaultMessage,
  });

  final String defaultMessage;

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  DiaryTagType _selectedType = DiaryTagType.values.first;
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
            itemCount: DiaryTagType.values.length,
            itemBuilder: (context, index) {
              final tagType = DiaryTagType.values[index];
              return IconButton(
                onPressed: () => setState(() {
                  _selectedType = tagType;
                }),
                icon: Icon(tagType.iconData),
                color: _selectedType != tagType
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
              tagType: _selectedType,
              message: _textEditingController.text,
            ),
          ),
          child: Text(l10n.confirm),
        ),
      ],
    );
  }
}
