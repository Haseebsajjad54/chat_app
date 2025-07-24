import 'package:chat_app/Auth/auth_service.dart';
import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Widgets/my_drawer.dart';
import 'package:chat_app/Widgets/user_tile.dart';
import 'package:chat_app/services/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final chatServices = ChatServices();
  final  authServices = AuthService();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text('Home Page'),
              backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
        stream: chatServices.getUserStream(),
        builder: (context,snapShot){

          //Error
          if(snapShot.hasError){
           return Center(
              child:Text('Error...!!!!',style: TextStyle(fontSize: 20),) ,
            );
          }
          //Loading .....
          else if(snapShot.connectionState ==ConnectionState.waiting ){
            return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Loading.....',style: TextStyle(fontSize: 20),),
                SizedBox(width: 5,),
                CircularProgressIndicator(),
              ],
            ));
          }
          // User Data.....
          else{
            return ListView(
              children: snapShot.data!.map<Widget>(
                  (userData)=> _buildUserListItem(userData,context)
              ).toList(),
            );
          }
        }
    );
  }
  Widget _buildUserListItem(Map<String,dynamic>userData,BuildContext context) {
    if(userData['email'] != authServices.getCurrentUser!.email) {
      return UserTile(
      userName: userData['email'],
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=>ChatScreen(
                userUid: userData['uid'],
            userName: userData['email']
        ),
        ),
        );
      },
        //unreadCount: await chatServices.getUnreadCount(authServices.getCurrentUser!.email!+, userData['uid']),
    );
    }
    else{
      return Container();

    }
  }

}
