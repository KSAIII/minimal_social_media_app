import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_app/components/my_back_button.dart';
import 'package:socialmedia_app/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("users").snapshots(),
       builder: (context,snapshot){
        // any errors 
       if(snapshot.hasError){
        displayMessageToUser("Something went wrong", context);
       }


        //show loading circle
        if(snapshot.connectionState ==ConnectionState.waiting ){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.data == null){
          return Text("No data");
        }

        //get all users
// get all users
final users = snapshot.data!.docs;

return Column(
  children: [
     Padding(
                    padding:  EdgeInsets.all(
                     0

                    ),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),
    Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['username']),
            subtitle: Text(user['email']),
          );
        },
      ),
    ),
  ],
);



       },
       
       ),
    );
  }
}