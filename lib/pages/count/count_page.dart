import 'package:attendance_record_app/components/atom/atom/button.dart';
import 'package:attendance_record_app/controllers/count_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

//TODO: ボタンがアクティブで無い時に押せないようにする
class CountPage extends ConsumerWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countPageController = ref.read(countPageControllerProvider);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Column(
              children: [
                Lottie.asset('images/space-ride.json'),
              ],
            ),
            SizedBox(
              child: Column(
                children: [
                  const SizedBox(height: 280),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      ref.watch(timerDisplayProvider),
                      style: GoogleFonts.dotGothic16(
                          fontSize: 64, color: Colors.green),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Button(
                    title: "業務開始",
                    isActive: ref.read(isStartProvider),
                    onTap: () {
                      countPageController.startStopWatch();
                    },
                    height: 48,
                    width: 160,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Button(
                        title: "ReStart",
                        isActive: ref.read(isReStartProvider),
                        onTap: () {
                          //関数変更
                          countPageController.reStartStopWatch();
                        },
                        height: 48,
                        width: 104,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      Button(
                        title: "Stop",
                        isActive: ref.read(isStopProvider),
                        onTap: () {
                          countPageController.stopStopWatch();
                        },
                        height: 48,
                        width: 104,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Button(
                    title: "業務終了",
                    isActive: ref.read(isResetProvider),
                    onTap: () {
                      countPageController.resetStopWatch();
                    },
                    height: 48,
                    width: 160,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ],
        ));
  }
}
