import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maersk_test/models/post.dart';

Provider<Repository> repoProvider = Provider<Repository>((ref) => Repository());

class Repository {
  // Repository._internal();
  //
  // factory Repository() {
  //   return _repository;
  // }
  //
  // static final Repository _repository = Repository._internal();

  List<Post> _posts = [];

  List<Post> getPosts() {
    return _posts;
  }

  addPost(Post post) {
    _posts = [..._posts, post];
    return _posts;
  }

  int getNewPostId() {
    if (_posts.isEmpty) {
      return 0;
    }
    int lastID = _posts.last.id;
    int newID = lastID + 1;
    return newID;
  }

  likePost(Post post) {
    _posts = _posts.map((e) {
      return e.id == post.id
          ? Post(post.id, post.title, post.description, post.imagePath, () {
              int likeCount = post.likeCount;
              likeCount = likeCount + 1;
              return likeCount;
            }(), post.isFav)
          : post;
    }).toList();
    return _posts;
  }

  makePostFav(Post post) {
    _posts = _posts.map((e) {
      return e.id == post.id
          ? Post(post.id, post.title, post.description, post.imagePath,
              post.likeCount, !post.isFav)
          : post;
    }).toList();
    return _posts;
  }
}
