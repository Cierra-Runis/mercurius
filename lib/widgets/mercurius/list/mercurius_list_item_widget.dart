import 'package:mercurius/index.dart';

/// [MercuriusListItemWidget] 是由 [ConsumerWidget] 衍生出的列表系列组件的基类
class MercuriusListItemWidget extends ConsumerWidget {
  const MercuriusListItemWidget({
    super.key,
    this.padding,
    this.icon,
    this.iconData,
    this.titleText,
    this.titleTextStyle,
    this.summaryText,
    this.summaryTextStyle,
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
  });

  final EdgeInsets? padding;
  final Widget? icon;
  final IconData? iconData;
  final String? titleText;
  final TextStyle? titleTextStyle;
  final String? summaryText;
  final TextStyle? summaryTextStyle;
  final String? detailText;
  final TextStyle? detailTextStyle;
  final Widget? accessoryView;
  final bool? showIconBadge;
  final bool? showTitleTextBadge;
  final bool? showDetailTextBadge;
  final bool? showAccessoryViewBadge;
  final Widget? bottomView;
  final bool disabled;
  final VoidCallback? onTap;

  void _onTap(WidgetRef ref) {
    if (onTap != null) onTap!();
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

  Widget buildAccessoryView(BuildContext context) {
    return Badge(
      showBadge: showAccessoryViewBadge ?? false,
      child: accessoryView ??
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Icon(
              Icons.navigate_next,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
            ),
          ),
    );
  }

  Widget buildBottomView(BuildContext context) => bottomView ?? Container();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: disabled ? null : () => _onTap(ref),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: 56.0,
            ),
            padding: padding ?? const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              children: [
                if (icon != null)
                  Container(
                    margin: const EdgeInsets.fromLTRB(8.0, 0, 24.0, 0),
                    child: Badge(
                      showBadge: showIconBadge ?? false,
                      child: icon,
                    ),
                  )
                else
                  Container(
                    margin: const EdgeInsets.fromLTRB(8.0, 0, 24.0, 0),
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
                if (titleText != null || summaryText != null)
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
                        if (summaryText != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
                            child: Text(
                              summaryText ?? '',
                              style: summaryTextStyle ??
                                  TextStyle(
                                    fontSize: 8,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                            ),
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
    );
  }
}

/// 由 [MercuriusListItemWidget] 衍生的组件，其右边被替换为开关
class MercuriusModifiedListSwitchItem extends MercuriusListItemWidget {
  final bool? value;
  final ValueChanged<bool>? onChanged;

  const MercuriusModifiedListSwitchItem({
    required this.value,
    required this.onChanged,
    super.key,
    super.icon,
    super.iconData,
    super.titleText,
    super.titleTextStyle,
    super.summaryText,
    super.summaryTextStyle,
    super.detailText,
    super.detailTextStyle,
    super.accessoryView,
    super.onTap,
  });

  @override
  void _onTap(WidgetRef ref) {
    onChanged!(!value!);
    super._onTap(ref);
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

/// 由 [MercuriusListItemWidget] 衍生的组件，其中部被替换为 [TextField] 输入框
class MercuriusModifiedListTextFieldItem extends MercuriusListItemWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  const MercuriusModifiedListTextFieldItem({
    super.key,
    super.icon,
    super.iconData,
    super.titleText,
    super.titleTextStyle,
    super.summaryText,
    super.summaryTextStyle,
    super.accessoryView = const Padding(
      padding: EdgeInsets.only(left: 4),
      child: Icon(null),
    ),
    super.onTap,
    this.hintText,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  });

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
