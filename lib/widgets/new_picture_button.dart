import 'package:flutter/material.dart';

class NewPictureButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add_a_photo, color: Colors.white,),
      onPressed: (){
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context)=>CartScreen())
        // );
        
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
