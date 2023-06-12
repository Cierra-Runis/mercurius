import 'package:mercurius/index.dart';

class DiaryEditorToolbarImageButtonWidget extends QuillIconButton {
  DiaryEditorToolbarImageButtonWidget({
    super.key,
    required this.controller,
    required this.context,
    required String path,
  }) : super(
          size: 18 * 1.77,
          borderRadius: 12,
          onPressed: () => _onPressed(controller, context, path),
        );

  final BuildContext context;
  final QuillController controller;

  @override
  Widget? get icon => const Icon(Icons.image_rounded);

  static void _onPressed(
    QuillController controller,
    BuildContext context,
    String path,
  ) async {
    bool? newImage = await MercuriusConfirmDialogWidget(
      context: context,
      title: '从何处插入？',
      summary: '已有图片库还是系统文件呢？',
      trueString: '系统文件',
      falseString: '图片库',
    ).confirm;

    switch (newImage) {
      case true:

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
          String targetFilePath = '$path/image/${pickedFile.name}';

          await XFile(sourceFilePath).saveTo(targetFilePath);
          await File(sourceFilePath).delete();
          _insertImage(controller, targetFilePath);
        }
        break;
      case false:
        if (context.mounted) {
          String? targetFilePath = await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const MercuriusGalleryPage(
                readOnly: true,
              ),
            ),
          );
          if (targetFilePath != null) {
            _insertImage(controller, targetFilePath);
          }
        }
        break;
      default:
        return;
    }
  }

  static void _insertImage(QuillController controller, String targetFilePath) {
    Mercurius.printLog(targetFilePath);

    controller.document.insert(controller.selection.extentOffset, '\n');
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

    controller.document.insert(controller.selection.extentOffset, ' ');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.LOCAL,
    );

    controller.document.insert(controller.selection.extentOffset, '\n');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.LOCAL,
    );
  }
}