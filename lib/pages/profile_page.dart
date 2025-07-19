import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_app/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details safely
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
  if (currentUser?.email == null) {
    throw Exception("No current user found");
  }

  return await FirebaseFirestore.instance
      .collection("users")
      .doc(currentUser!.email)
      .get();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.exists) {
            // Safely extract data
            final data = snapshot.data!.data();
            if (data == null) {
              return Center(child: Text("User data is empty."));
            }

            return Center(
              child: Column(
                
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 25

                    ),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),
                  const SizedBox(

                    height: 25,
                  ),
                  //profile pic
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Icon(Icons.person,
                    size: 64,
                    ),

                  ),
                  SizedBox(
                    height: 25,

                  ),
                  Text(data['username'] ?? 'No username',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Text(data['email'] ?? 'No email',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("User document does not exist."));
          }
        },
      ),
    );
  }
}
