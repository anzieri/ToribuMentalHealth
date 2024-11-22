import 'package:app2/left_stuff.dart';
import 'package:app2/rightstuff.dart';
import 'package:flutter/material.dart';

class Homie extends StatelessWidget {
 const Homie({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,

      body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
              children: [

           LeftStuff(), 
              ]
                  ),
            ),
           

            Expanded(
              flex: 1,
              child: RightStuff(),
            ),
          ],
        ),
    
    
    );
  }
}