import 'package:mercurius/index.dart';

/// [MercuriusListItem] 是由 [StatelessWidget] 衍生出的列表系列组件的基类
class MercuriusListItem extends StatelessWidget {
  final EdgeInsets? padding;
  final Icon? icon;
  final IconData? iconData;
  final String? titleText;
  final TextStyle? titleTextStyle;
  final Widget? summary;
  final String? detailText;
  final TextStyle? detailTextStyle;
  final Widget? accessoryView;
  final bool? showIconBadge;
  final bool? showTitleTextBadge;
  final bool? showDetailTextBadge;
  final bool? showAccessoryViewBadge;
  final Widget? bottomView;
  final bool? disabled;
  final VoidCallback? onTap;

  const MercuriusListItem({
    Key? key,
    this.padding,
    this.icon,
    this.iconData,
    this.titleText,
    this.titleTextStyle,
    this.summary,
    this.detailText,
    this.detailTextStyle,
    this.showTitleTextBadge,
    this.showIconBadge,
    this.showDetailTextBadge,
    this.showAccessoryViewBadge,
    this.accessoryView,
    this.bottomView,
    this.disabled = false,
    this.onTap,
  }) : super(key: key);

  _onTap() {
    if (onTap != null) {
      onTap!();
    }
  }

  Widget buildDetailText(BuildContext context) {
    return Badge(
      showBadge: showDetailTextBadge ?? false,
      child: detailText != null
          ? Text(
              detailText!,
              style: detailTextStyle ??
                  TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.outline,
                  ),
            )
          : Container(),
    );
  }

  Widget buildAccessoryView(BuildContext context) => Badge(
        showBadge: showAccessoryViewBadge ?? false,
        child: accessoryView ??
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(
                Icons.navigate_next,
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
              ),
            ),
      );

  Widget buildBottomView(BuildContext context) => bottomView ?? Container();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: disabled! ? null : _onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 48,
              ),
              padding: padding ?? const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                children: [
                  if (icon != null)
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Badge(
                        showBadge: showIconBadge ?? false,
                        child: icon,
                      ),
                    )
                  else
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Badge(
                        showBadge: showIconBadge ?? false,
                        child: Icon(
                          iconData,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.38),
                        ),
                      ),
                    ),
                  if (titleText != null || summary != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (titleText != null)
                            Badge(
                              showBadge: showTitleTextBadge ?? false,
                              child: Text(
                                titleText ?? '',
                                style: titleTextStyle ??
                                    const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Saira',
                                    ),
                              ),
                            ),
                          if (summary != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4),
                              child: summary,
                            ),
                        ],
                      ),
                    ),
                  buildDetailText(context),
                  buildAccessoryView(context),
                ],
              ),
            ),
            buildBottomView(context),
          ],
        ),
      ),
    );
  }
}

/// 由 [MercuriusListItem] 衍生的组件，其右边被替换为开关
class MercuriusListSwitchItem extends MercuriusListItem {
  final bool? value;
  final ValueChanged<bool>? onChanged;

  const MercuriusListSwitchItem({
    Key? key,
    Icon? icon,
    IconData? iconData,
    String? titleText,
    TextStyle? titleTextStyle,
    Widget? summary,
    String? detailText,
    TextStyle? detailTextStyle,
    Widget? accessoryView,
    VoidCallback? onTap,
    @required this.value,
    @required this.onChanged,
  }) : super(
          key: key,
          icon: icon,
          iconData: iconData,
          titleText: titleText,
          titleTextStyle: titleTextStyle,
          summary: summary,
          detailText: detailText,
          detailTextStyle: detailTextStyle,
          accessoryView: accessoryView,
          onTap: onTap,
        );

  @override
  void _onTap() {
    onChanged!(!value!);
    super._onTap();
  }

  @override
  Widget buildAccessoryView(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        value: value!,
        onChanged: onChanged,
      ),
    );
  }
}

/// 由 [MercuriusListItem] 衍生的组件，其中部被替换为 [TextField] 输入框
class MercuriusListTextFieldItem extends MercuriusListItem {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  const MercuriusListTextFieldItem({
    Key? key,
    Icon? icon,
    IconData? iconData,
    String? titleText,
    TextStyle? titleTextStyle,
    Widget? summary,
    Widget? accessoryView = const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Icon(null),
    ),
    VoidCallback? onTap,
    this.hintText,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  }) : super(
          key: key,
          icon: icon,
          iconData: iconData,
          titleText: titleText,
          titleTextStyle: titleTextStyle,
          summary: summary,
          accessoryView: accessoryView,
          onTap: onTap,
        );

  @override
  bool get disabled => true;

  @override
  Widget buildDetailText(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(hintText: hintText),
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
