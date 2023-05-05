import 'package:mercurius/index.dart';

class MercuriusModifiedBottomBarWidget extends StatelessWidget {
  const MercuriusModifiedBottomBarWidget({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
    this.backgroundColor,
  }) : super(key: key);

  /// 要显示的选项卡列表，即 `Home` `Likes` 等
  final List<MercuriusBottomBarItem> items;

  /// 要显示的选项卡
  final int currentIndex;

  /// 返回被点击的选项卡的索引
  final Function(int)? onTap;

  /// 选择项目时图标和文本的颜色
  final Color? selectedItemColor;

  /// 未选中项目时图标和文本的颜色
  final Color? unselectedItemColor;

  /// 选择项目时可触摸背景颜色的不透明度
  final double? selectedColorOpacity;

  /// 每个项目的边框形状
  final ShapeBorder itemShape;

  /// 整个小部件周围的边距的便利字段
  final EdgeInsets margin;

  /// 每个项目的填充
  final EdgeInsets itemPadding;

  /// 过渡持续时间
  final Duration duration;

  /// 过渡曲线
  final Curve curve;

  /// 背景色
  final Color? backgroundColor;

  List<Widget> getChildren(ThemeData theme) {
    List<TweenAnimationBuilder<double>> children = [];

    for (final item in items) {
      children.add(
        TweenAnimationBuilder<double>(
          tween: Tween(
            end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
          ),
          curve: curve,
          duration: duration,
          builder: (context, t, _) {
            final selectedColor =
                item.selectedColor ?? selectedItemColor ?? theme.primaryColor;
            final unselectedColor = item.unselectedColor ??
                unselectedItemColor ??
                theme.iconTheme.color;
            return Material(
              color: Color.lerp(selectedColor.withOpacity(0.0),
                  selectedColor.withOpacity(selectedColorOpacity ?? 0.1), t),
              shape: itemShape,
              child: InkWell(
                onTap: () => onTap?.call(items.indexOf(item)),
                customBorder: itemShape,
                focusColor: selectedColor.withOpacity(0.1),
                highlightColor: selectedColor.withOpacity(0.1),
                splashColor: selectedColor.withOpacity(0.1),
                hoverColor: selectedColor.withOpacity(0.1),
                child: Padding(
                  padding: itemPadding -
                      (Directionality.of(context) == TextDirection.ltr
                          ? EdgeInsets.only(right: itemPadding.right * t)
                          : EdgeInsets.only(left: itemPadding.left * t)),
                  child: Row(
                    children: [
                      IconTheme(
                        data: IconThemeData(
                          color: Color.lerp(unselectedColor, selectedColor, t),
                          size: 24,
                        ),
                        child: items.indexOf(item) == currentIndex
                            ? item.activeIcon ?? item.icon
                            : item.icon,
                      ),
                      ClipRect(
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                          height: 20,
                          child: Align(
                            alignment: const Alignment(-0.2, 0.0),
                            widthFactor: t,
                            child: Padding(
                              padding: Directionality.of(context) ==
                                      TextDirection.ltr
                                  ? EdgeInsets.only(
                                      left: itemPadding.left / 2,
                                      right: itemPadding.right)
                                  : EdgeInsets.only(
                                      left: itemPadding.left,
                                      right: itemPadding.right / 2),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  color: Color.lerp(
                                      selectedColor.withOpacity(0.0),
                                      selectedColor,
                                      t),
                                  fontWeight: FontWeight.w600,
                                ),
                                child: item.title,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(24),
            spreadRadius: 0.2,
            blurRadius: 0.8,
          ),
        ],
      ),
      child: SafeArea(
        minimum: margin,
        child: Row(
          // 当有 2 个或更少的项目时使用不同的对齐方式，因此它的行为与 `BottomNavigationBar` 相同
          mainAxisAlignment: items.length <= 2
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.spaceBetween,
          children: getChildren(theme),
        ),
      ),
    );
  }
}

/// 在 [MercuriusModifiedBottomBarWidget] 中显示的选项卡
class MercuriusBottomBarItem {
  /// 要显示的图标
  final Widget icon;

  /// 此选项卡栏处于活动状态时显示的图标
  final Widget? activeIcon;

  /// 要显示的文本，如 `'Home'`
  final Widget title;

  /// 用于此选项卡的原色
  final Color? selectedColor;

  /// 未选择此选项卡时显示的颜色
  final Color? unselectedColor;

  MercuriusBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });
}
