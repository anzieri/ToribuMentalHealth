import "package:app2/buttons/buttons.dart";
import "package:app2/login/authprovider.dart";
import "package:app2/requests/loginlogic.dart";
import "package:app2/requests/requests.dart";
import "package:app2/textfields/textfields.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import 'package:provider/provider.dart';

class LoginUI extends StatefulWidget {

  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? userRole;
  bool isLoggedIn = false; 
  
  late Map<String, dynamic> loginData = {
    "email": "",
    "password": ""
  };

  void clearTextFields(){
      loginFormKey.currentState!.reset();
  }

  void _login() async {
    if (loginFormKey.currentState!.validate()) {
      loginData["email"] = emailController.text;
      loginData["password"] = passwordController.text;
      postLoginRequest("http://192.168.0.13:8080/api/v1/auth/authenticate", loginData).then((value){
      
      String token = value["token"];
      String role = getUserRole(token);
      String firstName = getClientName(token);
      print(role);
      
      storeToken(token);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Login Successful"),
            content: const Text("Welcome Back!", style: TextStyle(fontFamily: 'Lexend', fontSize: 15, fontWeight: FontWeight.w300),),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        },
      );
     
      Provider.of<AuthProvider>(context, listen: false).login(token, role, firstName);
     
      clearTextFields();
      if (role == 'THERAPIST') {
        context.go('/therapist');
      } else if (role == 'CLIENT') {
        context.go('/client');
      }

    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Error"),
            content: Text("$error"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        },
      );
      print("Error: $error");
    });

      // Clear the text fields
      clearTextFields();
    }
  }

  void login(String token) {
    setState(() {
      isLoggedIn = true;
      userRole = getUserRole(token); // Decode role from token
    });
  }

  void logout() {
    setState(() {
      isLoggedIn = false;
      userRole = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      backgroundColor: Colors.white,
      body: Form(
        key: loginFormKey,
        child:Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const Text("Login in to Toribu",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          )),

          const SizedBox(
            height: 20,
          ),

          const Text("Your Google account can be connected to your new Toribu account.\nNeed some help?",
          style: TextStyle( 
            fontFamily: 'Lexend',
            fontSize: 15,
            fontWeight: FontWeight.w300,
          )),
          
          const SizedBox(
            height: 30,
          ),

          Container(
            child: Textfields(
              placeholder: "example@gmail.com", 
              containWidth: 500, 
              fieldDescription: "Email",
              controller: emailController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter your email";
                }
                return null;
              })
          ),

          const SizedBox(
            height: 30,
          ),

          Container(
            child: Textfields(
              placeholder: "", 
              containWidth: 500, 
              fieldDescription: "Password",
              controller: passwordController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter your password";
                }
                return null;
              }),
          ),
          const SizedBox(
            height: 30,
          ),

          Buttons(
            btnName: "Submit", 
            colour: Colors.black, 
            containWidth: 500, 
            containHeight: 50,
            radius: 30, 
            onPressed: _login,
          )
        ]
      ),)
    ),
    );
  }
}


//Make sure there are two homepages, one the anyone can view without logging in and the other that is shown after login