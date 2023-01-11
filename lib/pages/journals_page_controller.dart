import 'package:attendance_record_app/service/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateProvider<bool>((ref) => true);

//Providerでラップすることで、変更を監視する
final journalsNotifierProvider =
    StateNotifierProvider<JournalsNotifier, List<Map<String, dynamic>>>((ref) {
  return JournalsNotifier(ref);
});

//監視対象の変数とそれに対する処理を書くところ
class JournalsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  JournalsNotifier(this.ref) : super([]);
  final Ref ref;

  void refreshJournals() async {
    final data = await SQLHelper.getItems();
    ref.watch(isLoadingProvider.notifier).state = false;
    state = data;
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void showForm(int? id, BuildContext context) async {
    if (id != null) {
      final existingJounal = state.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJounal['title'];
      _descriptionController.text = existingJounal['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 120),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      _titleController.text = "";
                      _descriptionController.text = "";

                      if (!mounted) return;
                      Navigator.of(context).pop;
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    refreshJournals();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    refreshJournals();
  }

  void deleteItem(int id, BuildContext context) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successfully deleted a journal!"),
    ));
    refreshJournals();
  }
}
