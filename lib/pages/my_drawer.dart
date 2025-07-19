import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //logout user

  void logout(){
FirebaseAuth.instance.signOut();

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text(
                "H O M E",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text(
                "P R O F I L E",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, '/profile_page');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.group,
                color: Colors.black,
              ),
              title: Text(
                "U S E R S",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/users_page');
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 25.0,bottom: 20),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: Text(
                "L O G O U T",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);

                //logout
              logout();

              },
            ),
          ),
        ],
      ),
    );
  }
}
