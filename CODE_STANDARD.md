# CODE STANDARD - 代码规范

1. 尽可能使用 `''` 而不是 `""` 来表示字符串
2. 尽量不使用 `StatefulWidget / ConsumerStatefulWidget` 而是 `StatelessWidget / ConsumerWidget`
3. 使用 `index.dart` 简化导入
4. 尽量不要使用 `const MyWidget({Key? key}) : super(key: key);` 而是 `const MyWidget({super.key});`，对于其他变量也是如此
5. 对 `StatelessWidget / ConsumerWidget` 组件，其结构如下

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

    ```dart
    class MyWidget extends ConsumerWidget {
        const MyWidget({super.key});

        void _myFunction() {
            (...)
        }

        @override
        Widget build(BuildContext context, WidgetRef ref) {
            return Container();
        }

        Future<void> _myFuture() {
            (...)
        }
    }
    ```

6. 对 `StatefulWidget / ConsumerStatefulWidget` 组件，其结构如下

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

    ```dart
    class MyWidget extends ConsumerStatefulWidget {
        const MyWidget({super.key});
        (...)

        @override
        ConsumerState<MyWidget> createState() => _MyWidgetState();
    }

    class _MyWidgetState extends ConsumerState<MyWidget> {
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

7. 项目结构

    - `.release_tool` 文件夹
        - 该文件夹保有发布用工具，其中 `main.py` 用于构建新版本，并决定是否将 `mercurius` 发布
    - `assets` 文件夹
        - 该文件夹保有字体和图片，`assets\fonts\Saira.ttf` 用于 `Mercurius` 的主要字体
    - `lib` 文件夹
        - 该文件夹保有程序的所有代码，`common` 下存放普通类，`models` 下存放需要使用代码生成的类，`pages` 下存放所有页面，`states` 下存放所有状态管理，`widgets` 下存放所有组件，且命名规则如下：
            - `pages` 文件夹下按用处分类，除 `index.dart` 和 `mercurius_route.dart` 外，所有文件名最前面都为所在子文件夹名称，最后面都是 `page` 结尾
                - 如 `mercurius` 子文件夹下的 `mercurius_home_page.dart`，且其中保有的类按大写无下划线的形式命名，如 `class MercuriusHomePage extends ConsumerStatefulWidget`
            -
            - `states` 文件夹下按用处分类，除 `index.dart` 外，所有文件名最前面都为所在子文件夹名称，不需要多余的 `provider` 后缀
                - 如 `diary` 子文件夹下的 `diary_search_text.dart`，且其中保有的类按大写无下划线的形式命名，如 `class DiarySearchText extends _$DiarySearchText`，最后其生成的变量为 `final diarySearchTextProvider`
            -
            - `widgets` 文件夹下暂无通用规律

8. 程序入口

    1. `void main() => runApp(const ProviderScope(child: MercuriusApp()));`
        - `package:riverpod` 提供给所有 `provider` 的储存位 `ProviderScope` 包裹着 `MercuriusApp`
    2. 开始构建 `MercuriusApp` ，为读取 themeMode 初始化 MercuriusProfile，此时处于 `mercuriusProfile.when(...)` 的 `loading` 态，传入的是 `ThemeMode.system`
    3. 由于 `MercuriusApp(home: const MercuriusSplashPage(), ...)`，故展现的是 `MercuriusSplashPage`，这说明其 `initState()` 方法被调用，且接着调用其 `build()` 方法
    4. 在 `MercuriusSplashPage` 的 `build()` 中使用 `ref.watch(...)` 方法：

        ```dart
        ref.watch(githubLatestReleaseProvider);
        ref.watch(isarServiceProvider);
        ref.watch(mercuriusPositionProvider);
        ```

        这会触发 `githubLatestReleaseProvider` `isarServiceProvider` `mercuriusPositionProvider` 的 [生命周期](https://docs-v2.riverpod.dev/zh-Hans/docs/concepts/provider_lifecycles)

    5. 因为 `githubLatestReleaseProvider` 是异步的，故无视其返回时间，但一般情况下都能在 `进入主页面` 前返回，不行的话得益于 `package:riverpod` 的 `when(...)` 方法对应其状态处理 `UI` 等数据依赖项
    6. `isarServiceProvider` 不是异步的，它只是保存了一个异步的 `Future<Isar> _db` 内部属性，但同是具有无视返回时间的特性；而 `isarServiceProvider` 依赖 `mercuriusPathProvider`，故初始化 `mercuriusPathProvider`，其也是异步的
    7. `mercuriusPositionProvider` 是异步的，相关介绍略
    8. 至此有 `mercuriusProfile` `githubLatestReleaseProvider` `mercuriusPathProvider` `mercuriusPositionProvider` 四者处于异步的状态
    9. 接下来各者完成的顺序 ***严格来说*** 是没有规律的，但它们遵守着以下规则
        - `mercuriusPathProvider` 初始化完成后 `isarServiceProvider` 才会完成初始化
        - `mercuriusProfile` 初始化完成后会重新构建 `MercuriusApp` ，并根据其返回的状态选择分支
        - 数据在 `MercuriusSplashPage` 死了之后返回也没关系，`package:riverpod` 会帮我们处理

    以下是两种状况下的实例，注意每次运行时可能会有如上所说的无规律性：

    - 正常网络

        ```dart
        [log] [Mercurius] 正在构建 MercuriusApp
        [log] [Mercurius] 正在读取 MercuriusProfile 中的 themeMode
        [log] [Mercurius] 正在初始化 _MercuriusSplashPageState#27c04(lifecycle state: created)
        [log] [Mercurius] 正在构建 _MercuriusSplashPageState#27c04(ticker active)
        [log] [Mercurius] GithubLatestRelease 初始化中
        [log] [Mercurius] 数据库初始化中
        [log] [Mercurius] 现在所打开的数据库 {} 个数为零，打开 mercurius_database 中
        [log] [Mercurius] MercuriusPath 初始化中
        [log] [Mercurius] MercuriusPosition 初始化中
        [log] [Mercurius] MercuriusPath 初始化为 /storage/emulated/0/Android/data/pers.cierra_runis.mercurius/files
        [log] [Mercurius] 数据库初始化完成
        [log] [Mercurius] MercuriusProfile 初始化中
        [log] [Mercurius] MercuriusProfile 初始化完毕，且 profile 为 **
        [log] [Mercurius] 正在构建 MercuriusApp
        [log] [Mercurius] 读取完毕 MercuriusProfile 中的 themeMode
        [log] [Mercurius] 正在构建 _MercuriusSplashPageState#27c04(ticker active)
        [log] [Mercurius] 进入主页面
        [log] [Mercurius] GithubLatestRelease 连接成功
        [log] [Mercurius] GithubLatestRelease 请求成功
        [log] [Mercurius] 正在构建 _MercuriusSplashPageState#27c04(ticker inactive)
        [log] [Mercurius] _MercuriusSplashPageState#27c04(ticker inactive) 死了
        ```

    - 无网络

        ```dart
        [log] [Mercurius] 正在构建 MercuriusApp
        [log] [Mercurius] 正在读取 MercuriusProfile 中的 themeMode
        [log] [Mercurius] 正在初始化 _MercuriusSplashPageState#426c5(lifecycle state: created)
        [log] [Mercurius] 正在构建 _MercuriusSplashPageState#426c5(ticker active)
        [log] [Mercurius] GithubLatestRelease 初始化中
        [log] [Mercurius] 数据库初始化中
        [log] [Mercurius] 现在所打开的数据库 {} 个数为零，打开 mercurius_database 中
        [log] [Mercurius] MercuriusPath 初始化中
        [log] [Mercurius] MercuriusPosition 初始化中
        [log] [Mercurius] MercuriusPath 初始化为 /storage/emulated/0/Android/data/pers.cierra_runis.mercurius/files
        [log] [Mercurius] 数据库初始化完成
        [log] [Mercurius] MercuriusProfile 初始化中
        [log] [Mercurius] MercuriusProfile 初始化完毕，且 profile 为 **
        [log] [Mercurius] 正在构建 MercuriusApp
        [log] [Mercurius] 读取完毕 MercuriusProfile 中的 themeMode
        [log] [Mercurius] 正在构建 _MercuriusSplashPageState#426c5(ticker active)
        [log] [Mercurius] GithubLatestRelease 连接失败
        [log] [Mercurius] 正在构建 _MercuriusSplashPageState#426c5(ticker active)
        [log] [Mercurius] 进入主页面
        [log] [Mercurius] _MercuriusSplashPageState#426c5(ticker inactive) 死了
        ```
