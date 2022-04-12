import "package:dio/dio.dart";
import 'package:dio_first/model/post.dart';
import "package:flutter/foundation.dart";

class DioClient {
  Dio dio = Dio();
  static const BaseURL = "https://jsonplaceholder.typicode.com";
  static const postsEndPoint = BaseURL + "/posts";

  Future<Post> fetchPost(int postId) async {
    try {
      var response = await dio.get(postsEndPoint + "/$postId");
      debugPrint(response.toString());
      return Post.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: + ${e.response?.statusCode.toString()}");
      throw Exception("Failed to fetch data: $postId");
    }
  }

  Future<List<Post>> fetchPosts() async {
    try {
      var response = await dio.get(postsEndPoint,
          options: Options(responseType: ResponseType.json));
      debugPrint(response.toString());
      return Post.listFromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: + ${e.response?.statusCode.toString()}");
      throw Exception("Failed to fetch data");
    }
  }

  Future<Post> createPost(int userId, String title, String body) async {
    try {
      final response = await dio.post(postsEndPoint,
          data: {"userId": userId, "title": title, "body": body});
      debugPrint(response.toString());
      return Post.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: + ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create post");
    }
  }

  Future<Post> updatePost(
      int postId, int userId, String title, String body) async {
    try {
      final response = await dio.put(postsEndPoint + "/$postId",
          data: {"userId": userId, "title": title, "body": body});
      debugPrint(response.toString());
      return Post.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("status code: + ${e.response?.statusCode.toString()}");
      throw Exception("Failed to update post");
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      final response = dio.delete(postsEndPoint + "/$postId");
      debugPrint("Deleted post: $postId");
    } on DioError catch (e) {
      debugPrint("status code: + ${e.response?.statusCode.toString()}");
      throw Exception("Failed to delete post: $postId");
    }
  }
}
