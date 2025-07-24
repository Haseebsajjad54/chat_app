import 'package:chat_app/Screens/home_page.dart';
import 'package:chat_app/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapShot){
                if(snapShot.hasData){
                  return HomePage();
                }
                else{
                  return Login();
                }
            }
        ),
    );
  }
}
