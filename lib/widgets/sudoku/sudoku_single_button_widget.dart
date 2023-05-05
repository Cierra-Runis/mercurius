import 'package:mercurius/index.dart';

class SudokuSingleButtonWidget extends StatefulWidget {
  const SudokuSingleButtonWidget({
    Key? key,
    required this.rowIndex,
    required this.columnIndex,
    required this.showNum,
    required this.buttonColor,
    required this.disable,
    required this.checkAnswer,
  }) : super(key: key);

  final int rowIndex;
  final int columnIndex;
  final int showNum;
  final Color buttonColor;
  final bool disable;
  final ValueChanged checkAnswer;

  @override
  State<SudokuSingleButtonWidget> createState() =>
      _SudokuSingleButtonWidgetState();
}

class _SudokuSingleButtonWidgetState extends State<SudokuSingleButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FrameSeparateWidget(
      child: SizedBox(
        height: 30,
        width: 30,
        child: TextButton(
          key: Key('grid-button-${widget.rowIndex}-${widget.columnIndex}'),
          onPressed: widget.disable
              ? null
              : () async {
                  int? selectedNum = await showDialog<int>(
                    context: context,
                    builder: (context) {
                      return SudokuNumSelectorWidget(
                        row: widget.rowIndex,
                        column: widget.columnIndex,
                      );
                    },
                  );
                  if (selectedNum == null) return;
                  setState(() {});
                },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(widget.buttonColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(
                width: 0.4,
                style: BorderStyle.solid,
                color: Colors.black54,
              ),
            ),
          ),
          child: Text(
            widget.disable ? '${widget.showNum}' : '',
            style: widget.disable
                ? TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white54
                        : Colors.black54,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
