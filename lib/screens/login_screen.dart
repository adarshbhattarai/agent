
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/screens/forgot_password.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/sign_up.dart';

import '../bloc/authentication_bloc.dart';
import '../constants/colors.dart';
import '../util/custom_button.dart';
import '../util/custom_text_fields.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // test@ethela.com
  // pass :  pass123
  // Text Controllers
  bool _isPasswordVisible = false;
  late final emailController;
  late final passwordController;
  String email="";
  String password="";

  @override
  void initState(){
    super.initState();
    emailController =  TextEditingController()
    ..addListener((){
      setState(() {
        email = emailController.text.trim();
      });
    });
    passwordController =  TextEditingController()
      ..addListener((){
        setState(() {
          password = passwordController.text.trim();
        });
      });
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() => _isPasswordVisible = !_isPasswordVisible);
  }

  void _tryLogin() {

      print("email-->"+ email);
      print("password-->"+ password.length.toString());

      BlocProvider.of<AuthenticationBloc>(context).add(
        LoginUser(
          email,
          password
        ),
      );
  }

  bool get _isFormValid
  => email.isNotEmpty && password.isNotEmpty;

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
            CustomTextField(
              placeholder: "Enter your email",
                controller: emailController,
                prefixIcon: Icon(Icons.mail, color: themeColorDarkest)
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: passwordController,
              hideText: !_isPasswordVisible,
              suffixIcon: IconButton(
                onPressed: _toggleVisibility,
                icon:Icon(_isPasswordVisible? Icons.visibility_outlined:Icons.visibility_off_outlined)
              ),
              prefixIcon: const Icon(
                Icons.key,
                color: themeColorDarkest,
              ),
            ),
            const SizedBox(
              height: 30,
            ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Text("Have Account? "),
        //     InkWell(
        //       onTap: widget.switchToLoginPage,
        //       child: const Text(
        //         "Login",
        //         style: TextStyle(
        //             color: themeColorDarkest,
        //             decoration: TextDecoration.underline),
        //       ),
        //     )

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const  ForgotPasswordScreen()),
                );
              },
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const SizedBox(height: 10),
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
                  child: CustomButton(
                          onPressed: _tryLogin,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          label: "Login",
                          disabled: !_isFormValid,
                        ),


                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     print("email-->"+ email);
                  //     print("password-->"+ password.length.toString());
                  //
                  //     BlocProvider.of<AuthenticationBloc>(context).add(
                  //       LoginUser(
                  //         email,
                  //         password
                  //       ),
                  //     );
                  //   },
                  //   child:  Text(
                  //     state is AuthenticationLoadingState
                  //           ? '.......'
                  //           : 'Login',
                  //     style: const TextStyle(
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const  SignupScreen()),
                  );
              },
                  child: const Text(
                    'Register',
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