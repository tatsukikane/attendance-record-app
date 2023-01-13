// class SignInWithSnsPage extends GetView<SignInWithSnsPageController> {


//   static show(BuildContext context) async {
//     await showBarModalBottomSheet(
//       context: context,
//       topControl: Container(),
//       builder: (context) => SizedBox(
//         height: 400,
//         child: SignInWithSnsPage(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: SoracomiColor.surface,
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 6),
//             Container(
//               width: 37,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: SoracomiColor.gray2,
//                 borderRadius: BorderRadius.circular(3),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextWidget(
//               text: LocaleStrings.makeMoreConvenientWithRegistration(),
//               fontHeight: 1.3,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               textAlign: TextAlign.center,
//               color: SoracomiColor.text,
//             ),
//             const SizedBox(height: 24),
//             for (var authDescriptiveText in authDescriptiveTexts) ...{
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SvgPicture.asset(
//                     "images/check_circle.svg",
//                     width: 24,
//                     height: 24,
//                   ),
//                   const SizedBox(width: 8),
//                   Flexible(
//                     child: TextWidget(
//                       text: authDescriptiveText,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: SoracomiColor.text,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//             },
//             const SizedBox(height: 16),
//             SnsAuthButton(
//               authProvider: AuthProvider.email,
//               onTap: () {
//                 Get.put(EmailInputPageController());
//                 Get.to(() => EmailInputPage(), fullscreenDialog: true);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }