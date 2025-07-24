import 'package:chat_app/Auth/auth_service.dart';
import 'package:chat_app/Screens/signup.dart';
import 'package:chat_app/Themes/light_mode.dart';
import 'package:chat_app/Widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/custom_textfield.dart';

class Login extends StatefulWidget {

   const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   final TextEditingController emailController=TextEditingController();

   final TextEditingController passwordController=TextEditingController();

   signUserIn(context) async {
     final auth = AuthService();

     final email = emailController.text.trim();
     final password = passwordController.text.trim();

     // 1. Check for empty fields
     if (email.isEmpty || password.isEmpty) {
       await showDialog(
         context: context,
         builder: (ctx) => AlertDialog(
           title: Text('Error', textAlign: TextAlign.center),
           content: Text('Enter all the required fields'),
           actions: [
             IconButton(
               onPressed: () => Navigator.pop(ctx),
               icon: Icon(Icons.done),
             ),
           ],
         ),
       );
       return;
     }

     // 2. Try to log in
     try {
       await auth.signWithEmailAndPassword(email, password,context);

       // If successful, AuthGate will handle navigation automatically
       // So you don't need to navigate manually here

     } on FirebaseAuthException catch (e) {
       // 3. Show Firebase error message
       await showDialog(
         context: context,
         builder: (ctx) => AlertDialog(
           title: Text('Login Failed'),
           content: Text(e.message ?? 'Unknown error occurred'),
           actions: [
             IconButton(
               onPressed: () => Navigator.pop(ctx),
               icon: Icon(Icons.done),
             ),
           ],
         ),
       );
     }
   }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat,
              size: 60,
              color: Theme.of(context).colorScheme.primary,),

            SizedBox(
              height: 20,
            ),

            Text('Welcome back,you have been missed',
              style: TextStyle(
              fontSize: 16,
                color: Theme.of(context).colorScheme.primary
            ),
            ),

            SizedBox(
              height: 15,
            ),

            CustomTextField(
              controller: emailController,
              hintText: 'Email',
              obscuredText: false,
            ),

            SizedBox(
              height: 15,
            ),

            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              obscuredText: true,
            ),

            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: CustomButton(text: 'Log in', onTap: (){
                signUserIn(context);
              }),
            ),

            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));

                  },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.blue
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
