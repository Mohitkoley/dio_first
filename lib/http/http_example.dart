import 'dart:convert';

import 'package:dio_first/model/post.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class PostClient {
  static const baseURL = "https://jsonplaceholder.typicode.com";
  static const postsEndPoint = baseURL + "/posts";

  Future<Post> fetchPost(int postId) async {
    final url = Uri.parse(postsEndPoint + "/$postId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      debugPrint("Response: ${response.body}");
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load post: $postId");
    }
  }

  Future<List<Post>> fetchPosts() async {
    final url = Uri.parse(postsEndPoint);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      debugPrint("Response: ${response.body}");
      return Post.listFromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load posts.");
    }
  }

  Future<Post> createPost(int postId, String title, String body) async {
    final url = Uri.parse(postsEndPoint);
    final response =
        await http.post(url, body: {postId: postId, title: title, body: body});
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception("flutter error: ${response.statusCode.toString()}");
    }
  }

  Future<Post> updatePost(
      int userId, int postId, String title, String body) async {
    final url = Uri.parse(postsEndPoint + "/$postId");
    final response =
        await http.put(url, body: {userId: userId, title: title, body: body});
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception("flutter error: ${response.statusCode.toString()}");
    }
  }

  Future<void> deletePost(int postId) async {
    final url = Uri.parse(postsEndPoint + "/$postId");
    final response = await http.delete(url);
    debugPrint("Deleted Post: $postId");
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception("flutter error: ${response.statusCode.toString()}");
    }
  }
}
