import 'package:mercurius/index.dart';

class UserModel extends ChangeNotifier {
  User user = User();

  void changeUser(User user) {
    this.user = user;
    notifyListeners();
  }
}
