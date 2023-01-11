import 'package:attendance_record_app/pages/journals_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JournalsPage(),
    );
  }
}


// import 'package:attendance_record_app/service/sql_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // ignore: todo
// //TODO: GetX利用。クラス分ける

// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AttendanceRecord',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Map<String, dynamic>> _journals = [];

//   bool _isLoading = true;

//   void _refreshJournals() async {
//     final data = await SQLHelper.getItems();
//     setState(() {
//       _journals = data;
//       _isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _refreshJournals();
//   }

//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   void _showForm(int? id) async {
//     if (id != null) {
//       final existingJounal =
//           _journals.firstWhere((element) => element['id'] == id);
//       _titleController.text = existingJounal['title'];
//       _descriptionController.text = existingJounal['description'];
//     }

//     showModalBottomSheet(
//         context: context,
//         elevation: 5,
//         isScrollControlled: true,
//         builder: (_) => Container(
//               padding: EdgeInsets.only(
//                   top: 15,
//                   left: 15,
//                   right: 15,
//                   bottom: MediaQuery.of(context).viewInsets.bottom + 120),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   TextField(
//                     controller: _titleController,
//                     decoration: const InputDecoration(hintText: 'Title'),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: _descriptionController,
//                     decoration: const InputDecoration(hintText: 'Description'),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (id == null) {
//                         await _addItem();
//                       }

//                       if (id != null) {
//                         await _updateItem(id);
//                       }

//                       _titleController.text = "";
//                       _descriptionController.text = "";

//                       Navigator.of(context).pop;
//                     },
//                     child: Text(id == null ? 'Create New' : 'Update'),
//                   )
//                 ],
//               ),
//             ));
//   }

//   Future<void> _addItem() async {
//     await SQLHelper.createItem(
//         _titleController.text, _descriptionController.text);
//     _refreshJournals();
//   }

//   Future<void> _updateItem(int id) async {
//     await SQLHelper.updateItem(
//         id, _titleController.text, _descriptionController.text);
//     _refreshJournals();
//   }

//   void _deleteItem(int id) async {
//     await SQLHelper.deleteItem(id);
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text("Successfully deleted a journal!"),
//     ));
//     _refreshJournals();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("AttendanceRecord"),
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: _journals.length,
//               itemBuilder: (context, index) => Card(
//                 color: Colors.orange[200],
//                 margin: const EdgeInsets.all(15),
//                 child: ListTile(
//                   title: Text(_journals[index]['title']),
//                   subtitle: Text(_journals[index]['description']),
//                   trailing: SizedBox(
//                     width: 100,
//                     child: Row(
//                       children: [
//                         IconButton(
//                           onPressed: () => _showForm(_journals[index]['id']),
//                           icon: const Icon(Icons.edit),
//                         ),
//                         IconButton(
//                             onPressed: () =>
//                                 _deleteItem(_journals[index]['id']),
//                             icon: const Icon(Icons.delete))
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//       floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add), onPressed: () => _showForm(null)),
//     );
//   }
// }
