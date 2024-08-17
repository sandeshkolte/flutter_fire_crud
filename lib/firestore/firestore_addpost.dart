import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/utils/round_button.dart';
import 'package:flutter_fire_crud/utils/util.dart';

class FirestoreAddPost extends StatefulWidget {
  const FirestoreAddPost({super.key});

  @override
  State<FirestoreAddPost> createState() => _AddPostState();
}

class _AddPostState extends State<FirestoreAddPost> {
  final postController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection("data");
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Post'),
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
                fireStore
                    .doc(id)
                    .set({
                      'id': id,
                      'message': postController.text.toString(),
                    })
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
