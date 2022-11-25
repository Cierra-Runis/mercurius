import 'package:mercurius/index.dart';

class DiaryListCardWidget extends StatefulWidget {
  const DiaryListCardWidget({super.key});

  @override
  State<DiaryListCardWidget> createState() => _DiaryListCardWidgetState();
}

class _DiaryListCardWidgetState extends State<DiaryListCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 290,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '25',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Saira',
                          ),
                        ),
                        Text(
                          '周五',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: 6),
                      ],
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 240,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '19:37',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '2022-11-25',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '大量客户未付款氯化铵未付款了卡哈的空间',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(UniconsLine.smile),
                  Icon(UniconsLine.cloud),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
