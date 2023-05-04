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
            /// TIPS: 如 `/data/user/0/pers.cierra_runis.mercurius/cache/3155b28b-e9b8-4883-815f-624fa5e6694b/Screenshot_20230412_204800.jpg`
            /// TIPS: 这会导致用户清除缓存后图片无法加载的问题
            /// TIPS: 故修改图片地址至 `/storage/emulated/0/Android/data/pers.cierra_runis.mercurius/image/` 下

            XFile? pickedFile = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );

            if (pickedFile != null) {
              String copyFilePath =
                  '${mercuriusPathNotifier.path}/image/${pickedFile.name}';
              await XFile(pickedFile.path).saveTo(copyFilePath);

              controller.document
                  .insert(controller.selection.extentOffset, '\n');
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

              controller.document.insert(
                controller.selection.extentOffset,
                DiaryImageBlockEmbed(copyFilePath),
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
