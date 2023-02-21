import 'package:mercurius/index.dart';

import 'package:flutter/cupertino.dart';

class MercuriusListItem extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget? icon;
  final Widget? title;
  final Widget? summary;
  final Widget? detailText;
  final Widget? accessoryView;
  final Widget? bottomView;
  final bool? disabled;
  final VoidCallback? onTap;

  const MercuriusListItem({
    Key? key,
    this.padding,
    this.icon,
    this.title,
    this.summary,
    this.detailText,
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

  Widget buildDetailText(BuildContext context) => detailText ?? Container();

  Widget buildAccessoryView(BuildContext context) =>
      accessoryView ??
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Icon(
          Icons.navigate_next,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
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
                      child: icon,
                    ),
                  if (title != null || summary != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (title != null) title!,
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

class MercuriusListRadioItem<T> extends MercuriusListItem {
  final T? value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;

  const MercuriusListRadioItem({
    Key? key,
    Widget? icon,
    Widget? title,
    Widget? summary,
    Widget? detailText,
    Widget? accessoryView,
    VoidCallback? onTap,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
  }) : super(
          key: key,
          icon: icon,
          title: title,
          summary: summary,
          detailText: detailText,
          accessoryView: accessoryView,
          onTap: onTap,
        );

  @override
  void _onTap() {
    onChanged!(value!);
    super._onTap();
  }

  @override
  Widget buildAccessoryView(BuildContext context) {
    if (value != null && value == groupValue) {
      return Icon(
        CupertinoIcons.checkmark_alt_circle_fill,
        size: 22,
        color: Theme.of(context).primaryColor,
      );
    }
    return Container();
  }
}

class MercuriusListSwitchItem extends MercuriusListItem {
  final bool? value;
  final ValueChanged<bool>? onChanged;

  const MercuriusListSwitchItem({
    Key? key,
    Widget? icon,
    Widget? title,
    Widget? summary,
    Widget? detailText,
    Widget? accessoryView,
    VoidCallback? onTap,
    @required this.value,
    @required this.onChanged,
  }) : super(
          key: key,
          icon: icon,
          title: title,
          summary: summary,
          detailText: detailText,
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
    return SizedBox(
      height: 22,
      width: 34,
      child: Transform.scale(
        scale: 0.8,
        child: CupertinoSwitch(
          value: value!,
          onChanged: onChanged,
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class MercuriusListTextFieldItem extends MercuriusListItem {
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  const MercuriusListTextFieldItem({
    Key? key,
    Widget? icon,
    Widget? title,
    Widget? summary,
    Widget? accessoryView,
    VoidCallback? onTap,
    this.placeholder,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  }) : super(
          key: key,
          icon: icon,
          title: title,
          summary: summary,
          accessoryView: accessoryView,
          onTap: onTap,
        );

  @override
  bool get disabled => true;

  @override
  Widget buildDetailText(BuildContext context) {
    return Expanded(
      child: CupertinoTextField(
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(),
        placeholder: placeholder,
        style: const TextStyle(
          fontSize: 14,
        ),
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
