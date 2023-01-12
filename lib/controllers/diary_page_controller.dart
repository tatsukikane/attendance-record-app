import 'package:attendance_record_app/models/attendace_recoard.dart';
import 'package:attendance_record_app/service/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateProvider<bool>((ref) => true);

//Providerでラップすることで、変更を監視する
final diaryPageNotifierProvider =
    StateNotifierProvider<DiaryPageNotifier, List<AttendaceRecoard>>((ref) {
  return DiaryPageNotifier(ref);
});

//監視対象の変数とそれに対する処理を書くところ
class DiaryPageNotifier extends StateNotifier<List<AttendaceRecoard>> {
  DiaryPageNotifier(this.ref) : super([]);
  final Ref ref;

  void refreshDiary() async {
    final data = await SQLHelper.getItems();
    ref.watch(isLoadingProvider.notifier).state = false;
    state = data;
  }

  void deleteItem(int id, BuildContext context) async {
    await SQLHelper.deleteItem(id);
    //TODO: POPUPに変更
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successfully deleted a journal!"),
    ));
    refreshDiary();
  }
}

