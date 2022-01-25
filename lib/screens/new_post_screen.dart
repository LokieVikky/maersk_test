import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maersk_test/application/notifier/post_list_notifier.dart';
import 'package:maersk_test/data/repository.dart';
import 'package:maersk_test/models/post.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  TextEditingController titelTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  File? imagePath;
  late MediaQueryData screenDimens;

  @override
  Widget build(BuildContext context) {
    screenDimens = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: TextField(
                controller: titelTextController,
                decoration: getInputDecoration('Title'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: TextField(
                controller: descriptionTextController,
                decoration: getInputDecoration('Description'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: () {
                return GestureDetector(
                  onTap: () async {
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    setState(() {
                      imagePath = File(image!.path);
                    });
                  },
                  child: Container(
                    color: Colors.black12,
                    height: screenDimens.size.height / 4,
                    width: double.infinity,
                    child: () {
                      if (imagePath == null) {
                        return const Center(child: Text('Select Image'));
                      } else {
                        return Image(
                          fit: BoxFit.fitWidth,
                          image: FileImage(imagePath!),
                        );
                      }
                    }(),
                  ),
                );
              }(),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, top: 10),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return ElevatedButton(
                    onPressed: () {
                      Post newPost = Post(
                        ref.read(repoProvider).getNewPostId(),
                        titelTextController.text.toString(),
                        descriptionTextController.text.toString(),
                        imagePath!.path,
                        0,
                        false,
                      );
                      ref.read(postListController.notifier).addPost(newPost);
                      Navigator.of(context).pop();
                    },
                    child: Text('CREATE POST'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getInputDecoration(String hint) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      hintText: hint,
    );
  }
}
