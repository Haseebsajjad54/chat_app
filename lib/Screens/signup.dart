import 'package:chat_app/Auth/auth_service.dart';
import 'package:chat_app/Screens/login.dart';
import 'package:chat_app/Themes/light_mode.dart';
import 'package:chat_app/Widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/custom_textfield.dart';

class Signup extends StatelessWidget {

  Signup ({super.key});
  final TextEditingController emailController=TextEditingController();
  final TextEditingController usernameController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();

  signUserUp(context){
  var auth=AuthService();
  if(passwordController.text.trim()==confirmPasswordController.text.trim()){
   try {
      auth.signUserUp(
          context,
          emailController.text.trim(),
          passwordController.text.trim(),

      );
      showDialog(
          context: context,
          builder: (ctx)=>AlertDialog(
            title: Text(
              'Congratulations',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
            content:Text('User Signup Successful'),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.done)
              ),
            ],
          )
      );

    }
    on FirebaseAuthException catch(e){
      showDialog(
          context: context,
          builder: (ctx)=>AlertDialog(
            title: Text(
              'Congratulations',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
            content:Text(e.code),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.done)
              ),
            ],
          )
      );
    }
  }
  else{
        showDialog(
            context: context,
            builder: (ctx)=>AlertDialog(
          title: Text(
            'Error',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
          ),
          content:Text('Password and Confirm Password does not match'),
          actions: [
            IconButton(
             onPressed: (){
                 Navigator.pop(context);
            },
                icon: Icon(Icons.done)
            ),
          ],
        )
        );
  }

}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat,size: 60,color: lightMode.primaryColor,),
            SizedBox(height: 20,),
            Text('Let\'s create an account for you',
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary
              ),
            ),
            SizedBox(height: 15,),
            //Email Text Field
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
              obscuredText: false,
            ),
            SizedBox(height: 15,),
            //Username textField
            CustomTextField(
              controller: usernameController,
              hintText: 'Username',
              obscuredText: false,
            ),
            SizedBox(height: 15,),
            // Password TextField
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              obscuredText: true,
            ),
            SizedBox(height: 20,),
            //Confirm Password TextField
            CustomTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm password',
              obscuredText: true,
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: CustomButton(text: 'Sign up', onTap: (){
                signUserUp(context);
              }),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Text(
                      'Log in',
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
