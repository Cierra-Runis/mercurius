import 'package:mercurius/index.dart';

class MercuriusOriginalConfirmDialogWidget extends StatelessWidget {
  const MercuriusOriginalConfirmDialogWidget({
    Key? key,
    this.itemName = '这张照片',
  }) : super(key: key);

  final String itemName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('确认删除吗？'),
          Text(
            '抛弃$itemName？',
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('取消')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('确认'))
      ],
    );
  }
}
