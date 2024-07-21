import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget{
  static String id = 'forgot_password_screen';

  const ForgotPasswordScreen({super.key});
  
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();

}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  @override
  Widget build(BuildContext context) {

    print("Inside the forgor password screen state");
    return Scaffold(
      body: Center(
        child: Column (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("You'll be able to reset it later, "+
          "Please contact Adarsh for other emergencies"),
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: const Text("Go Back"))
            ],
      ),
      )
     
    );

  }

}
