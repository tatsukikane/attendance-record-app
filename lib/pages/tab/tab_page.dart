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
        currentIndex: currentIndex,
        onTap: tabPageController.onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "images/hourglass.svg",
                width: 24,
                height: 24,
                color: currentIndex == 0 ? Colors.blue : null,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "images/calendar.svg",
                width: 32,
                height: 32,
                color: currentIndex == 1 ? Colors.blue : null,
              ),
              label: ''),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// import 'package:flutter/services.dart';

// class TabPageBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.put(TabPageController());
//   }
// }

// class TabPageController extends GetxController {
//   var currentIndex = 0.obs;
//   var pages = [];

//   late HomeTabPageController homeTabPageController;

//   StatelessWidget get page {
//     return pages[currentIndex.value];
//   }

//   @override
//   void onInit() async {
//     homeTabPageController =
//         Get.put<HomeTabPageController>(HomeTabPageController());
//     Get.put<BookshelfPageController>(BookshelfPageController());
//     Get.put<MyProfilePageController>(MyProfilePageController());
//     Get.put<ViewedComicsPageController>(ViewedComicsPageController());
//     Get.put<PurchasedComicsPageController>(PurchasedComicsPageController());

//     UserRepository.myProfile().then((currentUser) {
//       Get.put<User>(currentUser!);
//     });
//     pages = [HomeTabPage(), BookshelfPage(), MyProfilePage()];

//     super.onInit();
//   }

//   onItemTap(int index) {
//     if (index == currentIndex.value) {
//       _onCurrentItemTap();
//     }

//     currentIndex(index);
//     HapticFeedback.lightImpact();
//     update();
//   }

//   _onCurrentItemTap() {
//     if (page is HomeTabPage) {
//       homeTabPageController.switchTab(0);
//     }
//   }
// }

// class TabPage extends GetView<TabPageController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => controller.page,
//       ),
//       bottomNavigationBar: Obx(
//         () => Theme(
//           data: ThemeData(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             tooltipTheme: const TooltipThemeData(
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//               ),
//             ),
//           ),
//           child: BottomNavigationBar(
//             backgroundColor: SoracomiColor.surface,
//             currentIndex: controller.currentIndex.value,
//             onTap: controller.onItemTap,
//             unselectedItemColor: SoracomiColor.text,
//             selectedItemColor: SoracomiColor.primary,
//             selectedFontSize: 10.0,
//             unselectedFontSize: 10.0,
//             items: [
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   controller.currentIndex.value == 0
//                       ? "images/tab_home_on.svg"
//                       : "images/tab_home.svg",
//                   width: 24,
//                   height: 24,
//                 ),
//                 label: LocaleStrings.homeTab(),
//               ),
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   controller.currentIndex.value == 1
//                       ? "images/tab_library_on.svg"
//                       : "images/tab_library.svg",
//                   width: 24,
//                   height: 24,
//                 ),
//                 label: LocaleStrings.libraryTab(),
//               ),
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   controller.currentIndex.value == 2
//                       ? "images/tab_mypage_on.svg"
//                       : "images/tab_mypage.svg",
//                   width: 24,
//                   height: 24,
//                 ),
//                 label: LocaleStrings.mypageTab(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
