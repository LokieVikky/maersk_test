import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maersk_test/application/notifier/post_list_notifier.dart';
import 'package:maersk_test/models/post.dart';

class ListItem extends StatefulWidget {
  final Post post;
  const ListItem({Key? key, required this.post}) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late MediaQueryData screenDimens;
  late double fontMultiplier;

  @override
  Widget build(BuildContext context) {
    screenDimens = MediaQuery.of(context);
    fontMultiplier = screenDimens.size.height * 0.01;

    return Consumer(
      builder: (context, ref, child) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.title,
                  style: TextStyle(fontSize: fontMultiplier * 3),
                ),
                Text(
                  widget.post.description,
                  style: TextStyle(fontSize: fontMultiplier * 2),
                ),
                Padding(
                  padding: EdgeInsets.only(top:10,bottom: 10),
                  child: SizedBox(
                    height: screenDimens.size.height / 10,
                    width: double.infinity,
                    child: Image.file(File(widget.post.imagePath)),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ref.read(postListController.notifier).likePost(widget.post);
                      },
                      icon: Icon(Icons.thumb_up),
                    ),
                    Text(widget.post.likeCount.toString()),
                    IconButton(
                      onPressed: () {
                        ref.read(postListController.notifier).makePostFav(widget.post);
                      },
                      icon: Icon(widget.post.isFav?Icons.favorite:Icons.favorite_border),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
