import 'package:attendance_record_app/models/attendace_recoard.dart';
import 'package:attendance_record_app/service/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateProvider<bool>((ref) => true);
final monthlyTotalTimeProvider = StateProvider<int>((ref) => 0);
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

//Providerでラップすることで、変更を監視する
final diaryPageNotifierProvider =
    StateNotifierProvider<DiaryPageNotifier, List<AttendaceRecoard>>((ref) {
  return DiaryPageNotifier(ref);
});

//監視対象の変数とそれに対する処理を書くところ
class DiaryPageNotifier extends StateNotifier<List<AttendaceRecoard>> {
  DiaryPageNotifier(this.ref) : super([]);

  final Ref ref;

  void refreshDiary([DateTime? selectedDate]) async {
    //ずっと実行されてる
    var date = selectedDate == null
        ? ref.watch(diaryPageControllerProvider).getNowDateForQuery()
        : ref
            .watch(diaryPageControllerProvider)
            .getSelectedDateForQuery(selectedDate);
    final data = await SQLHelper.getItemsSortedByDate(date[0], date[1]);
    ref.watch(isLoadingProvider.notifier).state = false;
    getMonthlyTotalTime(data);
    state = data;
  }

  final TextEditingController _titleController = TextEditingController();
  void showForm(int? id, BuildContext context) async {
    if (id != null) {
      final selectedDiary = state.firstWhere((element) => element.id == id);
      _titleController.text = selectedDiary.totalTime.toString();
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      //TODO:container以下コンポーネント化
      builder: (_) => Container(
        padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            // bottom: MediaQuery.of(context).viewInsets.bottom + 120),
            bottom: 336),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                keyboardType: TextInputType.number,
                autofocus: true,
                controller: _titleController,
                decoration: const InputDecoration(hintText: '分'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (id != null) {
                  await _updateItem(id);
                }

                _titleController.text = "";

                if (!mounted) return;
                Navigator.of(context).pop;
              },
              child: const Text('Update'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, _titleController.text);
    refreshDiary(ref.watch(selectedDateProvider));
  }

  void deleteItem(int id, BuildContext context) async {
    await SQLHelper.deleteItem(id);
    //TODO: POPUPに変更
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successfully deleted a journal!"),
    ));
    refreshDiary(ref.watch(selectedDateProvider));
  }

  getMonthlyTotalTime(List<AttendaceRecoard> diary) {
    ref.watch(monthlyTotalTimeProvider.notifier).state = 0;
    for (int i = 0; i < diary.length; i++) {
      ref.read(monthlyTotalTimeProvider.notifier).state += diary[i].totalTime;
    }
  }

  selectDateForGetDiary(List<AttendaceRecoard> diary) {
    ref.watch(monthlyTotalTimeProvider.notifier).state = 0;
    for (int i = 0; i < diary.length; i++) {
      ref.read(monthlyTotalTimeProvider.notifier).state += diary[i].totalTime;
    }
  }
}

final diaryPageControllerProvider = Provider((ref) {
  return DiaryPageController(ref: ref);
});

class DiaryPageController {
  final ProviderRef ref;
  DiaryPageController({required this.ref});

  List<String> dateConverterToYearAndMonth(DateTime dateTime) {
    String now = dateTime.toString();
    String nowDate = now.split(' ')[0];
    return nowDate.split("-");
  }

  List<String> getNowDateForQuery() {
    List nowYearMonth = dateConverterToYearAndMonth(DateTime.now());
    String startDateTime = '${nowYearMonth[0]}-${nowYearMonth[1]}-01 00:00:00';
    String endDateTime = '${nowYearMonth[0]}-${nowYearMonth[1]}-31 23:59:59';
    return [startDateTime, endDateTime];
  }

  List<String> getSelectedDateForQuery(DateTime selectedDate) {
    List nowYearMonth = dateConverterToYearAndMonth(selectedDate);
    String startDateTime = '${nowYearMonth[0]}-${nowYearMonth[1]}-01 00:00:00';
    String endDateTime = '${nowYearMonth[0]}-${nowYearMonth[1]}-31 23:59:59';
    return [startDateTime, endDateTime];
  }
}
