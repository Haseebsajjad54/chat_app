import 'package:chat_app/Auth/auth_service.dart';
import 'package:chat_app/Screens/home_page.dart';
import 'package:chat_app/Screens/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
void logout(){
  var auth=AuthService();
  auth.signUserOut();
}
  @override
  Widget build(BuildContext context) {
    return Drawer(

      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                    child:Icon(
                      Icons.message,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40,
                    ) ,
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  leading: Icon(CupertinoIcons.home),
                  title: Text('H O M E'),
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListTile(
                  onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
                  },
                  leading: Icon(CupertinoIcons.settings),
                  title: Text('S E T T I N G'),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('L O G O U T'),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
