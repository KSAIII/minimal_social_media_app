import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialmedia_app/components/my_list_tile.dart';
import 'package:socialmedia_app/components/my_post_button.dart';
import 'package:socialmedia_app/components/my_textfield.dart';
import 'package:socialmedia_app/database/firestore.dart';
import 'package:socialmedia_app/pages/my_drawer.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  // Firebase access
  final FirestoreDatabase database = FirestoreDatabase();

  // Text controller
  final TextEditingController newPostController = TextEditingController();

  // Post message
  void postMessage() {
    // Only post message if there is something in textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    // Clear the controller
    newPostController.clear();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "W A L L",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          // TextField box for user to type
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: 'Say something....',
                    controller: newPostController,
                    obscureText: false,
                  ),
                ),
                PostButton(onTap: postMessage),
              ],
            ),
          ),
          // Posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // Show loading indicator
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Get all posts
              final posts = snapshot.data?.docs;

              // No data
              if (posts == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No posts..post something!"),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    String message = post['postMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];

                    // Format timestamp to readable string
                    DateTime dateTime = timestamp.toDate();
                    String formattedTime =
                        DateFormat('yyyy-MM-dd – HH:mm').format(dateTime);

                    return MyList(
                      title: message,
                      subtitle: "$userEmail • $formattedTime",
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
