import 'package:attendance_record_app/controllers/tab_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabPage extends ConsumerWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabPageController = ref.read(tabPageControllerProvider);
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      body: TabPageController.pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: currentIndex,
        onTap: tabPageController.onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "images/hourglass.svg",
                width: 24,
                height: 24,
                color: currentIndex == 0 ? Colors.green : null,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "images/calendar.svg",
                width: 32,
                height: 32,
                color: currentIndex == 1 ? Colors.green : null,
              ),
              label: ''),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
