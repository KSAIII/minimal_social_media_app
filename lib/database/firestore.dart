import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // Current logged-in user
  User? user = FirebaseAuth.instance.currentUser;

  // Get collection of posts from Firebase
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  // Post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user?.email,
      'postMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // Stream of posts ordered by timestamp
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();

    return postsStream;
  }
}
