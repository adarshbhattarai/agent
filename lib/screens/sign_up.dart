
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/screens/home_screen.dart';

import '../bloc/authentication_bloc.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'login_screen';

  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  // test@ethela.com
  // pass :  pass123
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String signedIn = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //login function?
  Future<User?> loginUsingEmailPassword({required String email, required String password,
  
  required BuildContext context}) async {
    FirebaseAuth auth= FirebaseAuth.instance;
    User? user;
    try {
      print("Entering login");
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user!;
       setState(() {
        signedIn = "true";
      });
    } on FirebaseAuthException catch (e) {
        if(e.code == "user-not-found"){
          print("No user found for that email");
        }else if(e.code == "wrong-password"){
          print("Wrong password provided for that user");
        } 
      }
    return user;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login to Your Account',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Email address'),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail, color: Colors.black),
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 10),
            const Text('Password'),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
              ),
              obscureText: false,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(signedIn != "" ? 'Signed In' : 'Email address'),
            const SizedBox(height: 10),
            // Container(
            //   width: double.infinity,
            //   child: RawMaterialButton(
            //     fillColor: const Color.fromARGB(255, 47, 15, 97),
            //     elevation: 0.0,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12.0)
            //     ),
            //     padding: const EdgeInsets.symmetric(vertical: 20.0),
            //     onPressed: () async{
            //       // let's test the app
            //       User? user = await loginUsingEmailPassword(
            //         email: emailController.text.trim(),
            //         password: passwordController.text.trim(),
            //         context: context,
            //       );
            //       print(user);

            //     },
            //     child: const Text("Login",
            //     style: TextStyle(color: Colors.white, fontSize: 18.0)),
            //   ),
            // ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationSuccessState) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.id,
                    (route) => false,
                  );
                } else if (state is AuthenticationFailureState) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Text('error'),
                        );
                      });
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        SignUpUser(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        ),
                      );
                    },
                    child:  Text(
                      state is AuthenticationLoadingState
                            ? '.......'
                            : 'Signup',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}