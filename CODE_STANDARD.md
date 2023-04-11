# CODE STANDARD - 代码规范

[TOC]

## 1. 尽量不使用 `StatefulWidget` 而是 `StatelessWidget`

## 2. 使用 `index.dart` 简化导入

## 3. 对 `StatelessWidget` 组件，其结构如下

```dart
class MyWidget extends StatelessWidget {
    const MyWidget({super.key});

    void _myFunction() {
        (...)
    }

    @override
    Widget build(BuildContext context) {
        return Container();
    }

    Future<void> _myFuture() {
        (...)
    }
}
```

## 4. 对 `StatefulWidget` 组件，其结构如下

```dart
class MyWidget extends StatefulWidget {
    const MyWidget({super.key});
    (...)

    @override
    State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
    (...)

    @override
    void initState() {
        super.initSate();
        (...)
    }

    @override
    void dispose() {
        (...)
        super.dispose();
    }

    void _myFunction() {
        (...)
    }

    @override
    Widget build(BuildContext context) {
        return Container();
    }

    Future<void> _myFuture() {
        (...)
    }
}
```

## 5. 项目结构

### `.release_tool` 文件夹

该文件夹保有发布用工具，其中 `main.py` 用于构建新版本，并决定是否将 `mercurius_warehouse` 发布

### `assets` 文件夹

该文件夹保有字体和图片，其中 `assets\fonts\QWeather_Icons.ttf` 用于天气图标，`assets\fonts\Saira.ttf` 用于 `Mercurius` 的主要字体

### `lib` 文件夹

该文件夹保有程序的所有代码，`common` 下存放普通类，`models` 下存放需要使用代码生成的类，`pages` 下存放所有页面，`states` 下存放所有状态管理，`widgets` 下存放所有组件

且命名规则如下

- `pages` 文件夹下按用处分类，除 `index.dart` 和 `mercurius_route.dart` 外，所有文件名最前面都为子文件夹名称，最后面都是 `page` 结尾，如 `mercurius` 子文件夹下的 `mercurius_home_page.dart`，且其中保有的类按大写无下划线的形式命名，如 `class MercuriusHomePage extends StatefulWidget`
-
- `states` 文件夹下按用处分类，除 `index.dart` 外，所有文件名最前面都为子文件夹名称，最后面都是 `notifier` 结尾，如 `diary` 子文件夹下的 `diary_editor_notifier.dart`，且其中保有的类按大写无下划线的形式命名，如 `class DiaryEditorNotifier extends ChangeNotifier`
-
- `widgets` 文件夹下按用处和是否为 `Dialog` 分类，除 `index.dart` 外，所有文件名最前面都为子文件夹名称，最后面都是 `widget` 结尾，如 `sudoku` 子文件夹下的 `sudoku_num_selector_widget.dart`，且其中保有的类按大写无下划线的形式命名，如 `class SudokuNumSelectorWidget extends StatefulWidget`。***注意若按用处分类了，则无视该类是否为 `Dialog`，就如此处的 `SudokuNumSelectorWidget` 实际上是一个 `Dialog`***
