import 'package:mercurius/index.dart';

const String _updateDate = '更新于 2022 年 10 月 28 日';

const String _declarationContent = '''
欢迎使用 Cierra_Runis 提供的 Mercurius 软件及服务。

本次 Cierra_Runis 编写了《Mercurius 引入声明》（以下简称「本声明」）。

一、字体声明
1. Mercurius 引入了 HarmonyOS Sans 字体作为 Mercurius 的主要字体，未对 HarmonyOS Sans 字体或其任何单独组件进行任何修改。
2. Mercurius 引入了 cmdysj 字体作为 Mercurius 的次要字体，未对 cmdysj 字体或其任何单独组件进行任何修改。

二、图标声明
1. Mercurius 引入了 Material Icons 作为 Mercurius 的主要图标，未对 Material Icons 图标或其任何单独组件进行任何修改。
''';

class ImportDeclarationDialogWidget extends StatefulWidget {
  const ImportDeclarationDialogWidget({super.key});

  @override
  State<ImportDeclarationDialogWidget> createState() =>
      _ImportDeclarationDialogWidgetState();
}

class _ImportDeclarationDialogWidgetState
    extends State<ImportDeclarationDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Mercurius 引入声明'),
          Text(
            _updateDate,
            style: TextStyle(
              fontSize: 10,
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.white54
                  : Colors.black54,
            ),
          ),
        ],
      ),
      content: ListView(
        shrinkWrap: true,
        children: const <Widget>[
          Text(_declarationContent),
        ],
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('返回'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    );
  }
}
