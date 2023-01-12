import 'package:attendance_record_app/controllers/count_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountPage extends ConsumerWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countPageController = ref.read(countPageControllerProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("countPage"),
        ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Container(
                alignment: Alignment.center,
                child: Text(
                  ref.watch(timerDisplayProvider),
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      countPageController.startStopWatch();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      countPageController.stopStopWatch();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      "stop",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  countPageController.resetStopWatch();
                },
                child: const Text(
                  "reset",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, //押したときの色！！
                ),
              ),
            ],
          ),
        ));
  }
}
