import 'package:attendance_record_app/pages/journals_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalsPage extends ConsumerWidget {
  const JournalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final journalsController = ref.read(journalsNotifierProvider.notifier);
    final journals = ref.watch(journalsNotifierProvider);
    journalsController.refreshJournals();

    return Scaffold(
      appBar: AppBar(
        title: const Text("AttendanceRecord"),
      ),
      body: ref.watch(isLoadingProvider)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: journals.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(journals[index]['title']),
                  subtitle: Text(journals[index]['description']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => journalsController.showForm(
                              journals[index]['id'], context),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                            onPressed: () => journalsController
                                .deleteItem(journals[index]['id'], context),
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => journalsController.showForm(null, context)),
    );
  }
}
