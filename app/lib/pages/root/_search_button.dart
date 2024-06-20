import 'package:mercurius/index.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: l10n.searchDiary,
      onPressed: () => context.push(const SearchPage()),
      icon: const Icon(Icons.search),
    );
  }
}
