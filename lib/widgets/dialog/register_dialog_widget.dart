import 'package:mercurius/index.dart';

const String _url = 'https://github.com/Cierra-Runis/';

class RegisterDialogWidget extends StatefulWidget {
  const RegisterDialogWidget({super.key});

  @override
  State<RegisterDialogWidget> createState() => _RegisterDialogWidgetState();
}

class _RegisterDialogWidgetState extends State<RegisterDialogWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('注册'),
          Text(
            '欢迎来到 Mercurius',
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
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '邮箱',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '密码',
                  ),
                  obscureText: true,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '确认密码',
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => launchUrlString(
              _url,
              mode: LaunchMode.externalApplication,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: const Align(
              heightFactor: 3,
              child: Text(
                '遇到问题？联系我们～',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          )
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          onPressed: () {
            /// TODO: 写逻辑
            Navigator.of(context).pop();
          },
          child: const Text('确认'),
        ),
      ],
    );
  }
}
