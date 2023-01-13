import 'package:attendance_record_app/components/atom/atom/text_widget.dart';
import 'package:attendance_record_app/controllers/diary_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryPage extends ConsumerWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryController = ref.read(diaryPageNotifierProvider.notifier);
    final diary = ref.watch(diaryPageNotifierProvider);
    diaryController.refreshDiary();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Diary"),
      ),
      body: Column(
        children: [
          Container(
            child: TextWidget(text: "月の合計時間や、月の切り替えを表示、年月も表示",),
          ),
          ref.watch(isLoadingProvider)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                child: ListView.builder(
                    itemCount: diary.length,
                    itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
            border: const Border(
              top: const BorderSide(
                color: Colors.green,
                width: 2,
              ),
            ),
                          ),
                          height: 56,
                          child: Row(
                            children: [
                              TextWidget(
                                text: '${diary[index].startedAt.day.toString()}日',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              const Expanded(child: SizedBox()),
                              TextWidget(
                                text: diary[index].totalTime < 60 
                                ? '${diary[index].totalTime}分'
                                : '${diary[index].totalTime ~/ 60}時間${diary[index].totalTime % 60}分',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              const Expanded(child: SizedBox()),
                              IconButton(
                                onPressed: () => diaryController.showForm(
                                    diary[index].id, context),
                                icon: const Icon(Icons.edit, color: Colors.green,),
                              ),
                              IconButton(
                                  onPressed: () => diaryController.deleteItem(
                                      diary[index].id, context),
                                  icon: const Icon(Icons.delete, color: Colors.red,))
                            ],
                          ),
                        )),
              ),
        ],
      ),

      // : ListView.builder(
      //     itemCount: diary.length,
      //     itemBuilder: (context, index) => Card(
      //       color: Colors.orange[200],
      //       margin: const EdgeInsets.all(15),
      //       child: ListTile(
      //         title: Text(diary[index].totalTime.toString()),
      //         subtitle: Text(diary[index].startedAt.day.toString()),
      //         trailing: SizedBox(
      //           width: 100,
      //           child: Row(
      //             children: [
      //               IconButton(
      //                 // onPressed: () => journalsController.showForm(
      //                 //     journals[index].id, context),
      //                 onPressed: () {},
      //                 icon: const Icon(Icons.edit),
      //               ),
      //               IconButton(
      //                   onPressed: () => diaryController.deleteItem(
      //                       diary[index].id, context),
      //                   icon: const Icon(Icons.delete))
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
    );
  }
}
