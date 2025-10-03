import 'package:flutter/material.dart';

class UserDataColumn extends StatelessWidget {
  const UserDataColumn({super.key});

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: h * .08,
          width: w * .17,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/profileTwo.png')),
          ),
        ),
        SizedBox(height: 10,),
        Text('Name : User has not signup',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),),
        Text('Gmail : User has not signup',
          style: TextStyle(color: Colors.grey,
              fontWeight: FontWeight.w500,fontSize: 12),),
      ],
    );
  }
}
