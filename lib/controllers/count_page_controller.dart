import 'dart:async';
import 'package:attendance_record_app/controllers/diary_page_controller.dart';
import 'package:attendance_record_app/service/sql_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isStopProvider = StateProvider<bool>((ref) => false);
final isResetProvider = StateProvider<bool>((ref) => false);
final isStartProvider = StateProvider<bool>((ref) => true);
final isReStartProvider = StateProvider<bool>((ref) => false);


final timerDisplayProvider = StateProvider<String>((ref) => '00:00:00');

final countPageControllerProvider = Provider((ref) {
  return CountPageController(ref: ref);
});

class CountPageController {
  final ProviderRef ref;
  var stopWatch = Stopwatch();
  final stopWatchDuration = const Duration(seconds: 1);
  var postedId = 0;

  CountPageController({required this.ref});

  startTimer() {
    Timer(stopWatchDuration, keepRunning);
  }

  keepRunning() {
    if (stopWatch.isRunning) {
      startTimer();
    }
    ref.read(timerDisplayProvider.notifier).state =
        stopWatch.elapsed.inHours.toString().padLeft(2, "0") +
            ":" +
            (stopWatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
            ':' +
            (stopWatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
  }

  startStopWatch() async {
    ref.read(isStopProvider.notifier).state = true;
    ref.read(isResetProvider.notifier).state = true;
    ref.read(isStartProvider.notifier).state = false;
    postedId = await SQLHelper.createItem(
        stopWatch.elapsedMilliseconds.toString(), "");
    stopWatch.start();
    keepRunning();
  }

  stopStopWatch() {
    ref.read(isStopProvider.notifier).state = false;
    ref.read(isStartProvider.notifier).state = false;
    ref.read(isReStartProvider.notifier).state = true;
    ref.read(isResetProvider.notifier).state = true;

    stopWatch.stop();
  }

  reStartStopWatch() async {
    ref.read(isStopProvider.notifier).state = true;
    ref.read(isStartProvider.notifier).state = false;
    ref.read(isReStartProvider.notifier).state = false;
    ref.read(isResetProvider.notifier).state = true;

    stopWatch.start();
    keepRunning();
  }

  resetStopWatch() async {
    ref.read(isStopProvider.notifier).state = false;
    ref.read(isStartProvider.notifier).state = true;
    ref.read(isReStartProvider.notifier).state = false;
    ref.read(isResetProvider.notifier).state = false;
    int totalTimeS = (stopWatch.elapsedMilliseconds / 1000).round();
    int totalTimeM = (totalTimeS / 60).round();

    await SQLHelper.updateItem(postedId, totalTimeM.toString());
    ref.read(diaryPageNotifierProvider.notifier).refreshDiary();
    stopWatch.reset();
    ref.read(timerDisplayProvider.notifier).state = '00:00:00';
  }
}
