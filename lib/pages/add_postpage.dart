import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/utils/round_button.dart';

import '../utils/util.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final postController = TextEditingController();
  final dbreference = FirebaseDatabase.instance.ref().child('Post');

  @override
  Widget build(BuildContext context) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: const InputDecoration(
                  hintText: 'idhar likho', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
              title: 'Add',
              onTap: () {
                Navigator.pop(context);
                dbreference
                    .child(id)
                    .set({'content': postController.text.toString(), 'id': id})
                    .then((value) => Util().toastMessage('Post Added'))
                    .onError((error, stackTrace) =>
                        Util().toastMessage(error.toString()));
              },
            )
          ],
        ),
      ),
    );
  }
}
