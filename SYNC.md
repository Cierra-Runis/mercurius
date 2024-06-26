## Sync

`A => B`

| id  | createAt | editAt | hash |         情形         |                 处理                  |
| :-: | :------: | :----: | :--: | :------------------: | :-----------------------------------: |
| `=` |   `=`    |  `=`   | `=`  |     两方完全相同     |        不做处理，两者步进 `id`        |
| `=` |   `=`    |  `=`   | `!=` |     各自创建日记     |      两者新建错开，两者步进 `id`      |
| `=` |   `=`    |  `!=`  | `=`  |    各自修改未更新    | 两者都取 `editAt` 大者，两者步进 `id` |
| `=` |   `=`    |  `!=`  | `!=` |     各自修改更新     |      两者新建错开，两者步进 `id`      |
| `=` |   `!=`   |  `=`   | `=`  |     各自创建日记     |      两者新建错开，两者步进 `id`      |
| `=` |   `!=`   |  `=`   | `!=` |     各自创建日记     |      两者新建错开，两者步进 `id`      |
| `=` |   `!=`   |  `!=`  | `=`  |     各自创建日记     |      两者新建错开，两者步进 `id`      |
| `=` |   `!=`   |  `!=`  | `!=` |     各自创建日记     |      两者新建错开，两者步进 `id`      |
| `>` |   `-`    |  `-`   | `-`  | `A` 删除小 `id` 日记 |  `B` 删除小 `id` 日记，`B` 步进 `id`  |
| `<` |   `-`    |  `-`   | `-`  | `A` 新建小 `id` 日记 |  `B` 新增小 `id` 日记，`A` 步进 `id`  |

## NOTE

- [关于离线优先应用的多端同步的思考和总结](https://www.auroras.xyz/blog/post/关于离线优先应用的多端同步的思考和总结/)
- [Isar CRDT](https://github.com/kerero/isar-crdt)
- [数据同步原理](https://segmentfault.com/a/1190000004887200)

## 同步思路

监听文件夹内文件变动，获取
