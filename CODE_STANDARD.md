# 代码规范

- 尽量不使用 StatefulWidget 而是 StatelessWidget
- 使用 index.dart 简化导入
- 对 StatelessWidget 组件，其结构如下

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

- 对 StatefulWidget 组件，其结构如下

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

- （待补充）
