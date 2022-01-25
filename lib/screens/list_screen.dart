import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maersk_test/application/notifier/post_list_notifier.dart';
import 'package:maersk_test/data/repository.dart';
import 'package:maersk_test/models/post.dart';
import 'package:maersk_test/screens/new_post_screen.dart';
import 'package:maersk_test/widgets/list_item.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(postListController.notifier).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        List<Post> postList = ref.watch(postListController);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const NewPostScreen();
              },));
            },
          ),
          appBar: AppBar(
            title: Text('Feed'),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {

                    ref.read(postListController.notifier).filterList(value);
                  },
                  controller: searchTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Search',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListItem(post:postList[index]);
                  },
                  itemCount: postList.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
