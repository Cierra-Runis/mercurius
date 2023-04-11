# CODE NOTE - 代码笔记

[TOC]

## 版本号构建问题

请使用 `.release_tool/main.py` 进行修改版本号, 简化自 [此链接](https://www.jianshu.com/p/5058eb7505d3)

`Flutter` 使用 `android/app/build.gradle` 来打包 `apk`, 且其引入了 `flutter.gradle` 如 `D:/flutter/packages/flutter_tools/gradle/flutter.gradle`

约在 `flutter.gradle` 的 `810` 行

```js
def addFlutterDeps = { variant ->
    if (shouldSplitPerAbi()) {
        variant.outputs.each { output ->
            def abiVersionCode = ABI_VERSION.get(output.getFilter(OutputFile.ABI))
            if (abiVersionCode != null) {
                output.versionCodeOverride =
                    abiVersionCode * 1000 + variant.versionCode
            }
        }
    }
    (...)
}
```

我们知道 `flutter` 将判断是否使用了 `'split-per-abi'` 命令, 是则在 `ABI_VERSION` 选择一个版本 `*1000` 再加上构建号

官方解释见 [此链接](https://developer.android.com/studio/build/configure-apk-splits)

我们只需修改 `ABI_VERSION map` 如下

```js
private static final Map ABI_VERSION = [
    (ARCH_ARM32)        : 0,
    (ARCH_ARM64)        : 0,
    (ARCH_X86)          : 0,
    (ARCH_X86_64)       : 0,
]
```

***注意若进行了 `Flutter` 版本更新，应重新修改该 `flutter.gradle` 文件***

## `vivo` 系手机无法调试 `Flutter` 程序

`vivo` 系列手机升至 `Origin3` 后发现调试 `Flutter` 应用卡在启动页，并且没有任何报错，详见 [github issue](https://github.com/flutter/flutter/issues/117019)，简化自 [此链接](https://blog.csdn.net/qq910689331/article/details/128790897)

答案是 `vivo` 系统发大病连日志都隐藏，我们需要提供 `IMEI 1` 码至 `vivo` 官方进行授权

1. 拨号盘输入 `*#06#` 复制 `IMEI 1` 值
2. 添加企业 QQ 号 `3002261823`（或通过 [官方网站](https://dev.vivo.com.cn/connectus/customerService?from=header) 联系）
3. 提交相关问题和信息，要求一键授权自己的手机
4. 等待授权成功后拨号盘输入 `*#*#112#*#*`，`“右上角按钮”->“更多”->“一键授权”` 即可

## `AlertDialog` `content` 传入 `ListView` 时在调试模式下报错

这是个怪问题，`release` 版本正常运行，解决方法如下：

```dart
AlertDialog(
  title: (...),
  content: SizedBox(
    width: double.minPositive, // 可选 double.maxFinite 但建议为 double.minPositive,
    child: ListView(
      shrinkWrap: true,
      children: (...),
    ),
  ),
  contentPadding: (...),
  actions: (...),
);
```
