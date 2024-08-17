import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/firestore/firestore_addpost.dart';
import 'package:flutter_fire_crud/pages/loginpage.dart';
import 'package:flutter_fire_crud/utils/util.dart';

class FirestorePost_Screen extends StatefulWidget {
  const FirestorePost_Screen({super.key});

  @override
  State<FirestorePost_Screen> createState() => _PostScreenState();
}

class _PostScreenState extends State<FirestorePost_Screen> {
  final auth = FirebaseAuth.instance;

  final editController = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection("data").snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection("data");

  late User? currentUser = auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final message =
                            snapshot.data!.docs[index]['message'].toString();
                        final title = snapshot.data!.docs[index].id.toString();

                        return Card(
                          child: ListTile(
                              subtitle: currentUser != null
                                  ? Text(currentUser!.email ?? "")
                                  : const Text("Unknown"),
                              title: Text(snapshot.data!.docs[index]['message']
                                  .toString()),
                              trailing: PopupMenuButton(
                                  child: const Icon(Icons.more_vert_rounded),
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                            value: 1,
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.pop(context);
                                                showMyDialog(message, title);
                                              },
                                              title: const Text('Edit'),
                                              trailing: const Icon(Icons.edit),
                                            )),
                                        PopupMenuItem(
                                            value: 2,
                                            child: ListTile(
                                              onTap: () {
                                                Navigator.pop(context);
                                                ref.doc(title).delete();
                                              },
                                              title: const Text('Delete'),
                                              trailing:
                                                  const Icon(Icons.delete),
                                            )),
                                      ])),
                        );
                      }),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FirestoreAddPost()));
        },
        child: Icon(Icons.edit, color: Theme.of(context).canvasColor),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Firestore'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage())));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
    );
  }

  Future<void> showMyDialog<QuerySnapshot>(String content, String id) async {
    editController.text = content;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref
                      .doc(id)
                      .update({'message': editController.text})
                      .then((value) => Util().toastMessage("Updated"))
                      .onError((error, stackTrace) =>
                          Util().toastMessage(error.toString()));
                },
                child: const Text('Update'))
          ],
        );
      },
    );
  }
}

// Expanded(
//             child: StreamBuilder(
//           stream: dbref.onValue,
//           builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//             if (!snapshot.hasData) {
//               return const CircularProgressIndicator();
//             } else {
//               Map<dynamic, dynamic> mp =
//                   snapshot.data!.snapshot.value as dynamic;

//               List<dynamic> list = [];

//               list.clear();
//               list = mp.values.toList();

//               return ListView.builder(
//                 itemCount: snapshot.data!.snapshot.children.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(list[index]['content']),
//                     subtitle: Text(list[index]['id']),
//                   );
//                 },
//               );
//             }
//           },
//         )),
