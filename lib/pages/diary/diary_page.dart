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
      appBar: AppBar(
        title: const Text("AttendanceRecord"),
      ),
      body: ref.watch(isLoadingProvider)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: diary.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(diary[index].totalTime.toString()),
                  subtitle: Text(diary[index].startedAt.day.toString()),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          // onPressed: () => journalsController.showForm(
                          //     journals[index].id, context),
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                            onPressed: () => diaryController.deleteItem(
                                diary[index].id, context),
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
