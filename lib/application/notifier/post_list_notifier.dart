import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maersk_test/data/repository.dart';
import 'package:maersk_test/models/post.dart';

final postListController =
    StateNotifierProvider<PostListNotifier, List<Post>>((ref) {
  return PostListNotifier(ref);
});

class PostListNotifier extends StateNotifier<List<Post>> {
  final Ref ref;

  PostListNotifier(this.ref) : super([]);

  getPosts() {
    List<Post> posts = ref.read(repoProvider).getPosts();
    state = posts;
  }

  addPost(Post post) {
    state =  ref.read(repoProvider).addPost(post);
  }

  likePost(Post post) {
    state = ref.read(repoProvider).likePost(post);
  }

  makePostFav(Post post) {
    state = ref.read(repoProvider).makePostFav(post);
  }

  filterList(String keyword) {
    if (keyword=='') {
      List<Post> posts = ref.read(repoProvider).getPosts();
      print(posts.length);
      state = posts;
    } else {
      state = state.where((element) {
        return element.title.toLowerCase().contains(keyword.toLowerCase()) ||
            element.description.toLowerCase().contains(keyword.toLowerCase());
      }).toList();
    }
  }
}
