/// 各路由下的 index.dart
library app;

export 'common/index.dart';
export 'database/index.dart';
export 'l10n/l10n.dart';
export 'models/index.dart';
export 'pages/index.dart';
export 'platform/index.dart';
export 'riverpod/index.dart';
export 'widgets/index.dart';
export 'main.dart';

/// flutter 相关
/// [RefreshCallback] 和 `export 'package:flutter/material.dart'` 冲突，两者近似
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart' hide describeIdentity, shortHash;
export 'package:flutter/material.dart';
export 'package:flutter/gestures.dart';

/// dart 相关
export 'dart:async' show Timer, StreamSubscription;
export 'dart:convert';
export 'dart:io';
export 'dart:ui' show ImageFilter, FontFeature;

/// 外部包相关
export 'package:another_flushbar/flushbar.dart'; // 提示框
export 'package:based_list/based_list.dart';
export 'package:based_local_first_image/based_local_first_image.dart';
export 'package:based_splash_page/based_splash_page.dart';
export 'package:based_split_view/based_split_view.dart';
export 'package:cross_file/cross_file.dart'; // 文件操作
export 'package:dio/dio.dart'; // 网络请求
/// [Interval] 和 `package:flutter/src/animation/curves.dart` 冲突，两者结构完全不同，但外部包里的这个用不到
export 'package:dart_date/dart_date.dart' hide Interval; // 日期工具
export 'package:dynamic_color/dynamic_color.dart';
export 'package:flex_color_picker/flex_color_picker.dart';
export 'package:file_picker/file_picker.dart'; // 文件选择
export 'package:flutter_displaymode/flutter_displaymode.dart'; // 高刷
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:flutter_localizations/flutter_localizations.dart'; // 本地化
export 'package:flutter_markdown/flutter_markdown.dart'; // markdown
export 'package:flutter_quill/flutter_quill.dart'; // 富文本
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart'; // 状态管理
export 'package:image_picker/image_picker.dart'; // 图片选择
export 'package:image_picker_android/image_picker_android.dart'; // 图片选择
export 'package:image_picker_platform_interface/image_picker_platform_interface.dart'; // 图片选择
export 'package:isar/isar.dart'; // 数据库
export 'package:intl/intl.dart' hide TextDirection; // 国际化
export 'package:json_annotation/json_annotation.dart'; // json 相关
export 'package:keframe/keframe.dart'; // 列表优化
export 'package:loading_animation_widget/loading_animation_widget.dart'; // 加载器组件
export 'package:material_color_utilities/material_color_utilities.dart'
    show CorePalette;
export 'package:path/path.dart' show join;
export 'package:path_provider/path_provider.dart'; // 路径获取
export 'package:pausable_timer/pausable_timer.dart'; // 可暂停计时器
export 'package:package_info_plus/package_info_plus.dart'; // 包信息
export 'package:photo_view/photo_view.dart'; // 图片视图
export 'package:qweather_icons/qweather_icons.dart'; // QWeather 图标
export 'package:share_plus/share_plus.dart'; // 分享
export 'package:shared_preferences/shared_preferences.dart';
export 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart'; // 粘性头部与分组列表
export 'package:syncfusion_flutter_charts/charts.dart'; // 图表
export 'package:url_launcher/url_launcher_string.dart'; // 打开外部链接
export 'package:unicons/unicons.dart'; // 图标
export 'package:vibration/vibration.dart'; // 振动反馈
export 'package:window_manager/window_manager.dart'; // 窗口管理
