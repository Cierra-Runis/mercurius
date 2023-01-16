import 'package:mercurius/index.dart';

class LoginDialogWidget extends StatefulWidget {
  const LoginDialogWidget({super.key});

  @override
  State<LoginDialogWidget> createState() => _LoginDialogWidgetState();
}

class _LoginDialogWidgetState extends State<LoginDialogWidget> {
  final TextEditingController _mercuriusId = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _mercuriusId,
                  decoration: const InputDecoration(
                    hintText: 'Mercurius Id',
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Mercurius Id 不能为空';
                    }
                    try {
                      int.parse(value);
                    } catch (e) {
                      return '请仅输入数字';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(
                    hintText: '密码',
                  ),
                  validator: (value) =>
                      value!.trim().isNotEmpty ? null : '密码不能为空',
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
      actions: [
        Consumer<ProfileModel>(
          builder: (context, profileModel, childe) {
            return TextButton(
              onPressed: () {
                if ((_formKey.currentState as FormState).validate()) {
                  _fetchUser(
                    int.parse(_mercuriusId.text),
                    _password.text,
                    context,
                  );
                }
              },
              child: const Text('确认'),
            );
          },
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

  Future<void> _fetchUser(
    num mercuriusId,
    String password,
    BuildContext context,
  ) async {
    User newUser = User()
      ..mercuriusId = mercuriusId
      ..username = '田所浩二'
      ..email = 'byrdsaron@gmail.com';
    profileModel.changeProfile(profileModel.profile..user = newUser);
    Navigator.of(context).pop();
  }
}
