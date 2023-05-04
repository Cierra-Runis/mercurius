/// 各路由下的 index.dart
export 'common/index.dart';
export 'models/index.dart';
export 'pages/index.dart';
export 'states/index.dart';
export 'widgets/index.dart';
export 'main.dart';

/// flutter 相关
// [RefreshCallback] 和 `export 'package:flutter/material.dart'` 冲突，两者近似
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/rendering.dart';
export 'package:flutter/services.dart';
// [Badge] 和 `export 'package:badges/badges.dart'; // 小红点提示` 冲突，我想用外部包
// [RefreshIndicator] 和 [RefreshIndicatorState] 被 `export 'package:pull_to_refresh/pull_to_refresh.dart'; // 下拉刷新` 重写
export 'package:flutter/material.dart'
    hide Badge, RefreshIndicator, RefreshIndicatorState;

/// dart 相关
export 'dart:async' hide AsyncError;
export 'dart:convert';
export 'dart:io';
export 'dart:math';
export 'dart:ui' show ImageFilter;

/// 外部包相关
export 'package:another_flushbar/flushbar.dart'; // 提示框
export 'package:badges/badges.dart'; // 小红点提示
export 'package:confetti/confetti.dart'; // 彩纸效果
export 'package:cross_file/cross_file.dart'; // 文件操作
export 'package:dio/dio.dart'; // 网络请求
// [Interval] 和 `package:flutter/src/animation/curves.dart` 冲突，两者结构完全不同，但外部包里的这个用不到
export 'package:dart_date/dart_date.dart' // 日期工具
    hide
        Interval;
export 'package:file_picker/file_picker.dart'; // 文件选择
export 'package:flutter_displaymode/flutter_displaymode.dart'; // 高刷
export 'package:flutter_localizations/flutter_localizations.dart'; // 本地化
export 'package:flutter_markdown/flutter_markdown.dart'; // markdown
// [Text] 和 `export 'package:flutter/material.dart` 冲突，两者结构完全不同，但外部包里的这个用不到
export 'package:flutter_quill/flutter_quill.dart' hide Text; // 富文本
export 'package:flutter_riverpod/flutter_riverpod.dart' // 状态管理
    hide
        ChangeNotifierProvider,
        Consumer;
export 'package:image_picker/image_picker.dart'; // 图片选择
export 'package:isar/isar.dart'; // 数据库
export 'package:json_annotation/json_annotation.dart'; // json 相关
export 'package:keframe/keframe.dart'; // 列表优化
export 'package:loading_animation_widget/loading_animation_widget.dart'; // 加载器组件
export 'package:open_app_file/open_app_file.dart'; // 打开文件
export 'package:path_provider/path_provider.dart'; // 路径获取
export 'package:package_info_plus/package_info_plus.dart'; // 包信息
export 'package:photo_view/photo_view.dart'; // 图片视图
export 'package:provider/provider.dart' // 状态管理
    hide
        StreamProvider,
        Provider,
        Locator,
        FutureProvider;
export 'package:pull_to_refresh/pull_to_refresh.dart'; // 下拉刷新
export 'package:share_plus/share_plus.dart'; // 分享
export 'package:shared_preferences/shared_preferences.dart'; // 数据持久化
export 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart'; // 粘性头部与分组列表
export 'package:sudoku_solver_generator/sudoku_solver_generator.dart'; // 数独生成器
export 'package:syncfusion_flutter_charts/charts.dart'; // 图表
export 'package:table_calendar/table_calendar.dart'; // 日历
export 'package:url_launcher/url_launcher_string.dart'; // 打开外部链接
export 'package:unicons/unicons.dart'; // 图标
export 'package:vibration/vibration.dart'; // 振动反馈
export 'package:waterfall_flow/waterfall_flow.dart' // 图片网格流
    hide
        ViewportBuilder;
