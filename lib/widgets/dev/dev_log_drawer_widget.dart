import 'package:mercurius/index.dart';

class DevLogDrawerWidget extends StatelessWidget {
  const DevLogDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(backgroundColor: Colors.transparent, child: Container()),
    );
  }
}
