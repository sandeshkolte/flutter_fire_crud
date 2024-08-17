import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/pages/add_postpage.dart';
import 'package:flutter_fire_crud/pages/loginpage.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;

  final dbref = FirebaseDatabase.instance.ref('Post');

  final searchFilter = TextEditingController();

  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
                controller: searchFilter,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Search')),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColorLight)),
              query: dbref,
              itemBuilder: (context, snapshot, animation, index) {
                final content = snapshot.child('content').value.toString();
                final id = snapshot.child('id').value.toString();

                if (searchFilter.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child('content').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                        child: const Icon(Icons.more_vert_rounded),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  onTap: () {
                                    showMyDialog(content, id);
                                  },
                                  value: 1,
                                  child: const ListTile(
                                    title: Text('Edit'),
                                    trailing: Icon(Icons.edit),
                                  )),
                              PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      dbref.child(id).remove();
                                    },
                                    title: const Text('Delete'),
                                    trailing: const Icon(Icons.delete),
                                  )),
                            ]),
                  );
                } else if (content
                    .toLowerCase()
                    .contains(searchFilter.text.toLowerCase().toString())) {
                  return ListTile(
                    title: Text(snapshot.child('content').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                        child: const Icon(Icons.more_vert_rounded),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      showMyDialog(content, id);
                                    },
                                    title: const Text('Edit'),
                                    trailing: const Icon(Icons.edit),
                                  )),
                              PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      dbref.child(id).remove();
                                    },
                                    title: const Text('Delete'),
                                    trailing: const Icon(Icons.delete),
                                  )),
                            ]),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPost()));
        },
        child: Icon(Icons.edit, color: Theme.of(context).canvasColor),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Posts'),
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

  Future<void> showMyDialog(String content, String id) async {
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
                  dbref.child(id).update({'content': editController.text});
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
