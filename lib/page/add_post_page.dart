import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:team1_consume_api/controllers/post_controller.dart';
import 'package:team1_consume_api/models/post.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final PostController postController = PostController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController bodyController;
  @override
  void initState() {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("TAMBAH berita"),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      controller: titleController,
                      maxLines: null,
                      decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          hintText: "title"),
                      validator: (value) {
                        if (value == "") {
                          return "judul harus diisi";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      controller: bodyController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: "body",
                      ),
                      validator: (value) {
                        if (value == "") {
                          return "body harus diisi";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: TextButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  Post post = Post(
                    userId: 1,
                    id: 1,
                    title: titleController.text,
                    body: bodyController.text,
                  );
                  postController.create(post).then((res) {
                    if (res) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Post Added"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failde to add Post"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text("Tambah"),
            ),
          ),
        ],
      ),
    );
  }
}
