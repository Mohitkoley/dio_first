import 'package:dio_first/dio/dio_client.dart';
import 'package:dio_first/model/post.dart';
import "package:flutter/material.dart";

class DioExample extends StatefulWidget {
  DioExample({Key? key}) : super(key: key);

  @override
  State<DioExample> createState() => _DioExampleState();
}

class _DioExampleState extends State<DioExample> {
  var requesting = false;
  late DioClient dioClient;
  late Future<Post> post;
  late Future<List<Post>> posts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (requesting)
          FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text("Title: ${snapshot.data!.title}"),
                      Text("Body: ${snapshot.data!.body}"),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        // FutureBuilder<List<Post>>(
        //   future: posts,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return Padding(
        //         padding: EdgeInsets.all(24.0),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text("Title: ${snapshot.data![0].title}"),
        //             Text("Body: ${snapshot.data![0].body}"),
        //             SizedBox(
        //               height: 10,
        //             ),
        //             Text("Title: ${snapshot.data![1].title}"),
        //             Text("Body: ${snapshot.data![1].body}"),
        //           ],
        //         ),
        //       );
        //     } else if (snapshot.hasError) {
        //       return Text("${snapshot.error}");
        //     }
        //     return CircularProgressIndicator();
        //   },
        // ),
        SizedBox(height: 10),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () {
                  post = dioClient.fetchPost(1);
                  setState(() {
                    requesting = true;
                  });
                },
                child: Text("Get Post"),
              ),
              ElevatedButton(
                onPressed: () {
                  posts = dioClient.fetchPosts();
                  setState(() {
                    requesting = true;
                  });
                },
                child: Text("Get Post list"),
              ),
              ElevatedButton(
                onPressed: () {
                  post = dioClient.createPost(1, "test title", "test body");
                  setState(() {
                    requesting = true;
                  });
                },
                child: const Text("Create Post"),
              ),
              ElevatedButton(
                onPressed: () {
                  post =
                      dioClient.updatePost(2, 1, "Update title", "Update body");
                  setState(() {
                    requesting = true;
                  });
                },
                child: const Text("Update Post"),
              ),
              ElevatedButton(
                onPressed: () {
                  dioClient.deletePost(2);
                  setState(() {
                    requesting = true;
                  });
                },
                child: const Text("Delete Post"),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
