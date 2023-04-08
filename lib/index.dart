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
export 'dart:async';
export 'dart:convert';
export 'dart:io';
export 'dart:math';

/// 外部包相关
export 'package:another_flushbar/flushbar.dart'; // 提示框
export 'package:badges/badges.dart'; // 小红点提示
export 'package:confetti/confetti.dart'; // 彩纸效果
export 'package:dio/dio.dart'; // 网络请求
export 'package:flutter_displaymode/flutter_displaymode.dart'; // 高刷
export 'package:flutter_localizations/flutter_localizations.dart'; // 本地化
export 'package:flutter_markdown/flutter_markdown.dart'; // markdown
export 'package:isar/isar.dart'; // 数据库
export 'package:json_annotation/json_annotation.dart'; // json 相关
export 'package:loading_animation_widget/loading_animation_widget.dart'; // 加载器组件
export 'package:open_app_file/open_app_file.dart'; // 打开文件
export 'package:path_provider/path_provider.dart'; // 路径获取
export 'package:package_info_plus/package_info_plus.dart'; // 包信息
export 'package:provider/provider.dart'; // 状态管理
export 'package:pull_to_refresh/pull_to_refresh.dart'; // 下拉刷新
export 'package:share_plus/share_plus.dart'; // 分享
export 'package:shared_preferences/shared_preferences.dart'; // 数据持久化
export 'package:sudoku_solver_generator/sudoku_solver_generator.dart'; // 数独生成器
export 'package:syncfusion_flutter_charts/charts.dart'; // 图表
export 'package:table_calendar/table_calendar.dart'; // 日历
export 'package:url_launcher/url_launcher_string.dart'; // 打开外部链接
export 'package:unicons/unicons.dart'; // 图标
export 'package:vibration/vibration.dart'; // 振动反馈
// [Interval] 和 `package:flutter/src/animation/curves.dart` 冲突，两者结构完全不同，但外部包里的这个用不到
export 'package:dart_date/dart_date.dart' hide Interval; // 日期工具
