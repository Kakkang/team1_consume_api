import 'package:team1_consume_api/controllers/post_controller.dart';
import 'package:team1_consume_api/models/comment.dart' as c;
import 'package:team1_consume_api/models/post.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.post});
  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    final PostController postController = PostController();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Post"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width,
                child: Text(
                  widget.post.body,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Expanded(
                  child: FutureBuilder<List<c.Comment>>(
                future: postController.fetchComments(widget.post.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      List<c.Comment> comments = snapshot.data!;
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(comments[index].name),
                              subtitle: Text(comments[index].body),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: size.height * 0.03,
                            );
                          },
                          itemCount: comments.length);
                    } else {
                      return const Text("Belum ada Komentar");
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text("Err");
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
