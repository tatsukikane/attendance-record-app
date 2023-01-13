import 'package:attendance_record_app/pages/count/count_page.dart';
import 'package:attendance_record_app/pages/diary/diary_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabPageControllerProvider = Provider((ref) {
  return TabPageController(ref: ref);
});

final currentIndexProvider = StateProvider<int>((ref) => 0);


class TabPageController {
  final ProviderRef ref;
  TabPageController({required this.ref});

  static const pages = [
    CountPage(),
    DiaryPage(),
  ];
  void onItemTapped(int index) {
    ref.read(currentIndexProvider.notifier).state = index;
    
  }

}
