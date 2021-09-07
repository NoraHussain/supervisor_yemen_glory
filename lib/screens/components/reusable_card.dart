import 'package:flutter/material.dart';

import '../../constraints.dart';

class ReusableCard extends StatelessWidget {

  ReusableCard({
    required this.colour,
    required this.cardchild,
    required this.onPress,
    required this.image
  });

  Color colour;
  Widget cardchild;
  VoidCallback onPress;
  String image;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        color: colour,
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        shape: Border(right: BorderSide(color: kPrimaryColor, width: 5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.asset('images/icons/'+image+'.png',width: 35,),
            title:  cardchild ),
          ),
        ),
      );
  }
}
