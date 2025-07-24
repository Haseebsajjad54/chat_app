import 'package:chat_app/Screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{

  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final FirebaseFirestore _fireStore =FirebaseFirestore.instance;

  User? get getCurrentUser =>_firebaseAuth.currentUser;
  // sign user in

Future<UserCredential>signWithEmailAndPassword(userEmail,userPassword,BuildContext context) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );
      _fireStore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'email': userEmail,
            'uid':userCredential.user!.uid
          }
      );
      return userCredential;

    } on FirebaseAuthException catch (e) {

      showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Text('Error',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text(
                'Invalid Credentials'
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          )
      );

      throw Exception(e.code);
    }
  }

  // sign user up
Future<UserCredential>signUserUp(context,String userEmail,String userPassword)async{
  try{
    UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword
    );

    _fireStore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'email': userEmail,
          'uid':userCredential.user!.uid
        }
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    return userCredential;

  } on FirebaseAuthException catch (e) {
    throw Exception(e.code);
  }
}
  // sign user out
void signUserOut() async {
   return await _firebaseAuth.signOut();
 }


}