import 'package:mercurius/index.dart';

class ProfileModel extends ChangeNotifier {
  Profile profile = Global.profile;

  void changeProfile(Profile profile) {
    this.profile = profile;
    Global.profile = profile;
    Global.save();
    notifyListeners();
  }
}
