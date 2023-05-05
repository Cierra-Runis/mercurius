import 'package:mercurius/index.dart';

class DiaryEditorToolbarImageButtonWidget extends QuillIconButton {
  DiaryEditorToolbarImageButtonWidget({
    required this.controller,
    Key? key,
  }) : super(
          key: key,
          size: 18 * 1.77,
          borderRadius: 12,
          onPressed: () async {
            /// TIPS: 这里返还的是图片地址
            /// TIPS: 缓存于 `/data/user/0/pers.cierra_runis.mercurius/cache/` 下
            /// TIPS: 而不是可见于 `/storage/emulated/0/Android/data/pers.cierra_runis.mercurius/cache/` 下
            /// TIPS: 这会导致用户清除缓存后图片无法加载的问题
            /// TIPS: 故修改图片地址至 `/storage/emulated/0/Android/data/pers.cierra_runis.mercurius/image/` 下
            /// TIPS: 并删除所需的中间缓存图片

            XFile? pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );

            if (pickedFile != null) {
              String sourceFilePath = pickedFile.path;
              String targetFilePath =
                  '${mercuriusPathNotifier.path}/image/${pickedFile.name}';

              MercuriusKit.printLog('$sourceFilePath, $targetFilePath');

              await XFile(sourceFilePath).saveTo(targetFilePath);
              await File(sourceFilePath).delete();

              controller.document
                  .insert(controller.selection.extentOffset, '\n');
              controller.updateSelection(
                TextSelection.collapsed(
                  offset: controller.selection.extentOffset + 1,
                ),
                ChangeSource.LOCAL,
              );

              controller.document.insert(
                controller.selection.extentOffset,
                DiaryImageBlockEmbed(targetFilePath),
              );

              controller.updateSelection(
                TextSelection.collapsed(
                  offset: controller.selection.extentOffset + 1,
                ),
                ChangeSource.LOCAL,
              );

              controller.document
                  .insert(controller.selection.extentOffset, ' ');
              controller.updateSelection(
                TextSelection.collapsed(
                  offset: controller.selection.extentOffset + 1,
                ),
                ChangeSource.LOCAL,
              );

              controller.document
                  .insert(controller.selection.extentOffset, '\n');
              controller.updateSelection(
                TextSelection.collapsed(
                  offset: controller.selection.extentOffset + 1,
                ),
                ChangeSource.LOCAL,
              );
            }
          },
        );

  @override
  Widget? get icon => const Icon(Icons.image_rounded);

  final QuillController controller;
}
