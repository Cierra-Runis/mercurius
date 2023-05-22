###### 最新版本
v0.5.0+65

###### 更新内容

修改📖
1. 版本号进行至 0.5.0+65
2. 暂时性删去 hitokoto 组件
3. 不再使用 shared_preferences 包保存数据
4. isarService 摆脱 riverpod
5. mercurius_kit 与 mercurius_constance 合并为 mercurius
6. 不再缓存 position
7. 不再使用 profile，也不再提供注册、登录入口，设置由 isar 保存
8. 不再显示侧拉栏
9. 破坏性更新，isar 数据库存放位置修改，需要使用导出功能重新导入日记

###### 历史更新

- 见 [Github Releases 界面](https://github.com/Cierra-Runis/mercurius_warehouse/releases)

###### 破坏性更新版本列表

- `0.5.0+65 版本`
	- isar 数据库存放位置修改，需要使用导出功能重新导入日记

- `0.3.0+59 版本`
  - 使用枚举类型规范日记心情、天气及数独难度的类型
  - 会失去所有数据，请手动移动数据
