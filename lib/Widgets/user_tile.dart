import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String userName;
  final Function() onTap;
  final int unreadCount;
  const UserTile({super.key, required this.userName, required this.onTap, this.unreadCount=0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0,right: 25,top: 25),
        child: Badge(
          isLabelVisible: unreadCount!=0?  true:false,
          label: Text(unreadCount.toString(),style: TextStyle(fontSize: 18),),
          largeSize: 30,
          child: Container(
            padding: EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle
            ),
            child: Row(
              children: [
                Icon(CupertinoIcons.person),
                SizedBox(width: 7,),
                Text(
                  userName,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
