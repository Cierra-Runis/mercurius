import 'package:mercurius/index.dart';

class MercuriusConfirmDialogWidget extends StatelessWidget {
  const MercuriusConfirmDialogWidget({
    Key? key,
    this.title = '确认吗？',
    this.summary = '请再三思考哦～',
    this.falseString = '取消',
    this.trueString = '确认',
    required this.context,
  }) : super(key: key);

  final String title;
  final String summary;
  final String falseString;
  final String trueString;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(
            summary,
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
          child: Text(falseString),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(trueString),
        )
      ],
    );
  }

  Future<bool?> get confirm async {
    return await showDialog<bool?>(context: context, builder: (_) => this);
  }
}
