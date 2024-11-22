import "package:app2/buttons/buttons.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class LeftStuff extends StatelessWidget {
  const LeftStuff({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
    child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const Text("Welcome to Toribu",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 50,
            fontWeight: FontWeight.bold,
          )),

          const SizedBox(
            height: 20,
          ),

          const Text("Where all your therapy needs are met.\nNeed some help?",
          style: TextStyle( 
            fontFamily: 'Lexend',
            fontSize: 25,
            fontWeight: FontWeight.w300,
          )),
          
          const SizedBox(
            height: 30,
          ),

           Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: Buttons(btnName: "Register", colour: Colors.black, containWidth: 150, containHeight: 50, radius: 10, onPressed: () {GoRouter.of(context).go("/register/CLIENT");},),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  child: Buttons(btnName: "Contact Us", colour: Colors.grey, containWidth: 150, containHeight: 50, radius: 10, onPressed: () {},),
                ),
                
                ]
          ), 
                         
      ],
    ),  
      );
    
  }
}