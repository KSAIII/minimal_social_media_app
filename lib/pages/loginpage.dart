import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_app/components/my_button.dart';
import 'package:socialmedia_app/components/my_textfield.dart';
import 'package:socialmedia_app/helper/helper_functions.dart';

class Loginpage extends StatefulWidget {
  final void Function()?onTap;
   const Loginpage({super.key,
   
   required this.onTap,
   
   });

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

// login method
void login() async{
  // show loading circle
showDialog(context: context, builder: (context)=>const Center(
  child: CircularProgressIndicator(),
)

 );
 // try sign in
 try {

await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordController.text);

if(context.mounted) Navigator.pop(context);
 }

// display any errors
on FirebaseAuthException catch (e){
  // pop loading circle
  Navigator.pop(context);
  displayMessageToUser(e.code, context);
}
  

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // logo
            children: [
              Icon(Icons.person,
              size: 80,
              color:Theme.of(context).colorScheme.inversePrimary,
              
              ),
              const SizedBox(
               height: 25,
              ),
              Text("M  I  N  I  M  A  L",
              style: TextStyle(
                fontSize: 20,
              ),
          
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(hintText: "Email", obscureText: false, controller: emailcontroller),

              const SizedBox(
                height:10,
              ),
              //password textfield

              MyTextField(hintText: "Password", obscureText: true, controller: passwordController),
              const SizedBox(
                height:10,
              ),

              // forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forget password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  
                  ),
                ],
              ),
             const SizedBox(
              height: 25,
             ),

             //sign in button
            MyButton(text: "Login", onTap: login),

            const SizedBox(
              height: 20,
            ),

            //dont have an account ? Register here

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Register Here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),

              ],
            )




            ],
          
            //app name
          
          
            //email textfield
          
          
          
          ),
        ),
      ),

    );
  }
}