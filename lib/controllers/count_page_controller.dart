import 'dart:async';
import 'package:attendance_record_app/service/sql_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isStopProvider = StateProvider<bool>((ref) => true);
final isResetProvider = StateProvider<bool>((ref) => true);
final isStartProvider = StateProvider<bool>((ref) => true);

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
    ref.read(isStopProvider.notifier).state = false;
    ref.read(isStartProvider.notifier).state = true;
    postedId = await SQLHelper.createItem(
        stopWatch.elapsedMilliseconds.toString(), "");
    stopWatch.start();
    keepRunning();
  }

  stopStopWatch() {
    ref.read(isStopProvider.notifier).state = true;
    ref.read(isStartProvider.notifier).state = false;
    stopWatch.stop();
  }

  resetStopWatch() async {
    ref.read(isStopProvider.notifier).state = true;
    ref.read(isStartProvider.notifier).state = true;
    int totalTimeS = (stopWatch.elapsedMilliseconds / 1000).floor();
    //時間と分で使いやすいようにする。
    await SQLHelper.updateItem(postedId,
        totalTimeS.toString(), "");
    stopWatch.reset();
    ref.read(timerDisplayProvider.notifier).state = '00:00:00';
  }
}
