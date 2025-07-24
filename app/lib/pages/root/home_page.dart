import 'package:mercurius/index.dart';

import '_app_bar_title.dart';
import '_search_button.dart';

class HomePage extends HookWidget {
  final ScrollController controller;

  const HomePage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SearchButton(),
        title: AppBarTitle(controller: controller),
        actions: [
          IconButton(
            onPressed: () => context.push(const SettingsPage()),
            icon: _BottomBarMorePageIcon(),
          ),
        ],
      ),
      body: _DiaryListView(controller: controller),
      floatingActionButton: const _FloatingButton(),
    );
  }
}

class _BottomBarMorePageIcon extends ConsumerWidget {
  const _BottomBarMorePageIcon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubHasUpdate = ref.watch(githubHasUpdateProvider);
    final hasUpdate = githubHasUpdate.value ?? false;

    return Badge(
      isLabelVisible: hasUpdate,
      child: const Icon(Icons.settings_rounded),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FloatingActionButton(
      heroTag: 'create',
      tooltip: l10n.createNewDiary,
      onPressed: () => _createDiary(context),
      child: const Icon(UniconsLine.diary),
    );
  }

  void _createDiary(BuildContext context) async {
    final belongTo = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      useRootNavigator: false,
      initialDate: DateTimeExtension.today,
      firstDate: DateTime(1949, 10),
      lastDate: DateTimeExtension.today.add(
        const Duration(days: 20000),
      ),
    );

    if (context.mounted && belongTo != null) {
      final today = DateTimeExtension.today;
      final diary = Diary(
        belongTo: belongTo,
        editAt: today,
        createAt: today,
        content: Document().toDelta().toJson(),
        editing: true,
      );
      context.push(
        EditorPage(diary: diary, autoSave: true),
      );
    }
  }
}

class _DiaryListView extends HookWidget {
  final ScrollController controller;

  const _DiaryListView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemBuilder: (context, index) => BasedListTile(
        titleText: '$index',
        onTap: () {},
      ),
    );
  }
}

class _EditingButton extends HookWidget {
  const _EditingButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FloatingActionButton.small(
      tooltip: l10n.continueEditingDiary,
      onPressed: () => context.pushDialog(
        const _EditingDialog(),
      ),
      child: const Icon(Icons.drafts_rounded),
    );
  }
}

class _EditingDialog extends HookWidget {
  const _EditingDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.continueEditingDiary),
      content: SizedBox(
        width: double.maxFinite,
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      direction: Axis.vertical,
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _ThisDayLastYearButton(),
        _EditingButton(),
        _CreateButton(),
      ],
    );
  }
}

class _ThisDayLastYearButton extends HookWidget {
  const _ThisDayLastYearButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FloatingActionButton.small(
      heroTag: 'thisDayLastYear',
      tooltip: l10n.thisDayLastYear,
      onPressed: () => context.pushDialog(
        const _ThisDayLastYearDialog(),
      ),
      child: const Icon(Icons.nights_stay_rounded),
    );
  }
}

class _ThisDayLastYearDialog extends HookWidget {
  const _ThisDayLastYearDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.thisDayLastYear),
      content: SizedBox(
        width: double.maxFinite,
      ),
    );
  }
}
