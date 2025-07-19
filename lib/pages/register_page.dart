import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_app/components/my_button.dart';
import 'package:socialmedia_app/components/my_textfield.dart';
import 'package:socialmedia_app/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmpwController = TextEditingController();

  // Register method
  Future<void> register() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords match
    if (passwordController.text != confirmpwController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error message to user
      displayMessageToUser("passwords dont match", context);
      return;
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordController.text,
        );

        // create a user document and add to firebase 
        await createUserDocument(userCredential);

        // pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.message ?? "An error occurred", context);
      }
    }
  }

  // Create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance.collection("users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),
              Text(
                "M  I  N  I  M  A  L",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailcontroller,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "ConfirmPassword",
                obscureText: true,
                controller: confirmpwController,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forget password",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              MyButton(text: "Register", onTap: register),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Alreadyt have an account?"),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
