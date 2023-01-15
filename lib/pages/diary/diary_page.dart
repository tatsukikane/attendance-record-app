import 'package:attendance_record_app/components/atom/atom/text_widget.dart';
import 'package:attendance_record_app/controllers/diary_page_controller.dart';
import 'package:attendance_record_app/service/date_picker_custom_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryPage extends ConsumerWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryController = ref.read(diaryPageNotifierProvider.notifier);
    final diary = ref.watch(diaryPageNotifierProvider);
    //DiaryPage全体がリビルドされ続けていてrefreshDiaryが走り続けるため応急処置
    if (ref.watch(isLoadingProvider)) {
      diaryController.refreshDiary();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: ref.watch(isLoadingProvider)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                '${ref.watch(selectedDateProvider).year}年${ref.watch(selectedDateProvider).month}月'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await DatePicker.showPicker(context, showTitleActions: true,
                pickerModel: YearMonthModel(
                    currentTime: DateTime.now(),
                    minTime: DateTime(2022, 1, 1),
                    maxTime: DateTime.now(),
                    locale: LocaleType.jp),
                locale: LocaleType.en,
                onConfirm: (date) {
                  ref.read(selectedDateProvider.notifier).state = date;
                  diaryController.refreshDiary(date);
                },
              );
            },
            icon: const Icon(
              Icons.calendar_month,
              color: Colors.green,
            ),
            splashColor: Colors.black,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            child: TextWidget(
              text: ref.watch(monthlyTotalTimeProvider) < 60
                  ? 'トータル：${ref.watch(monthlyTotalTimeProvider)}分'
                  : 'トータル：${ref.watch(monthlyTotalTimeProvider) ~/ 60}時間${ref.watch(monthlyTotalTimeProvider) % 60}分',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ref.watch(isLoadingProvider)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: diary.length,
                      itemBuilder: (context, index) => Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                ),
                              ),
                            ),
                            height: 56,
                            child: Row(
                              children: [
                                TextWidget(
                                  text:
                                      '${diary[index].startedAt.day.toString()}日',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                const Expanded(child: SizedBox()),
                                TextWidget(
                                  text: diary[index].totalTime < 60
                                      ? '${diary[index].totalTime}分'
                                      : '${diary[index].totalTime ~/ 60}時間${diary[index].totalTime % 60}分',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                const Expanded(child: SizedBox()),
                                IconButton(
                                  onPressed: () => diaryController.showForm(
                                      diary[index].id, context),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () => diaryController.deleteItem(
                                        diary[index].id, context),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          )),
                ),
        ],
      ),
    );
  }
}
