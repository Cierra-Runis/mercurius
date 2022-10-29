import 'package:mercurius/index.dart';

class LoginDialogWidget extends StatefulWidget {
  const LoginDialogWidget({super.key});

  @override
  State<LoginDialogWidget> createState() => _LoginDialogWidgetState();
}

class _LoginDialogWidgetState extends State<LoginDialogWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('登录'),
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
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'mercuriusId',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '密码',
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _registerDialog(context),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: const Align(
              heightFactor: 3,
              child: Text(
                '没有帐号？点此注册～',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          )
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // TODO: 写逻辑
            Navigator.of(context).pop();
          },
          child: const Text('确认'),
        ),
      ],
    );
  }

  Future<void> _registerDialog(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const RegisterDialogWidget();
      },
    );
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const PrivacyDialogWidget();
      },
    );
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AgreementDialogWidget();
      },
    );
  }
}
