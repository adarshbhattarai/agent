
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../app.dart';
import '../bloc/authentication_bloc.dart';
import '../constants/colors.dart';
import '../constants/palette.dart';
import '../settings/settings_controller.dart';
import '../util/custom_button.dart';
import '../util/custom_text_fields.dart';
import 'forgot_password.dart';
import 'home_screen.dart';
import 'sign_up.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({
    super.key,
    required this.settingsController
  });

  final SettingsController settingsController;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // test@ethela.com
  // pass :  pass123
  // Text Controllers

  bool isSignupScreen = true;
  bool isMale = true;
  bool _isPasswordVisible = false;
  bool isRememberMe = false;

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

      if(email==null || password==null){
        //TODO Proper error handling
        print("Unable to sign in or sign up, one of those fields are emtpy");
        return;
      }
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
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/background.jpg"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color(0xFF3b5999).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.yellow[700],
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen ? "Dentist On Call" : "Dentist On Call",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[700],
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      isSignupScreen
                          ? "Signup to Continue"
                          : "Signin to Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the shadow for the submit button
          buildBottomHalfContainer(true),
          //Main Contianer for Login and Signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 250,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
          // Bottom buttons
          Positioned(
            top: MediaQuery.of(context).size.height - 100,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Text(isSignupScreen ? "Or Signup with" : "Or Signin with"),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTextButton(MaterialCommunityIcons.facebook,
                          "Facebook", Palette.facebookColor),
                      buildTextButton(MaterialCommunityIcons.google_plus,
                          "Google", Palette.googleColor),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


   // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
       //      CustomTextField(
      //         placeholder: "Enter your email",
      //           controller: emailController,
      //           prefixIcon: Icon(Icons.mail, color: themeColorDarkest)
      //       ),
      //       const SizedBox(
      //         height: 30,
      //       ),
      //       CustomTextField(
      //         controller: passwordController,
      //         hideText: !_isPasswordVisible,
      //         suffixIcon: IconButton(
      //           onPressed: _toggleVisibility,
      //           icon:Icon(_isPasswordVisible? Icons.visibility_outlined:Icons.visibility_off_outlined)
      //         ),
      //         prefixIcon: const Icon(
      //           Icons.key,
      //           color: themeColorDarkest,
      //         ),
      //       ),
      //
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const  ForgotPasswordScreen()),
      //           );
      //         },
      //         child: const Text(
      //           'Forgot password?',
      //           style: TextStyle(
      //             color: Colors.deepPurple,
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 10.0),
      //       const SizedBox(height: 10),
      //       BlocConsumer<AuthenticationBloc, AuthenticationState>(
      //         listener: (context, state) {
      //           if (state is AuthenticationSuccessState) {
      //             Navigator.pushNamedAndRemoveUntil(
      //               context,
      //               ThelaApp.id,
      //               (route) => false,
      //             );
      //           } else if (state is AuthenticationFailureState) {
      //             showDialog(
      //                 context: context,
      //                 builder: (context) {
      //                   return const AlertDialog(
      //                     content: Text('error'),
      //                   );
      //                 });
      //           }
      //         },
      //         builder: (context, state) {
      //           return SizedBox(
      //             height: 50,
      //             width: double.infinity,
      //             child: CustomButton(
      //                     onPressed: _tryLogin,
      //                     padding: const EdgeInsets.symmetric(vertical: 20),
      //                     label: "Login",
      //                     disabled: !_isFormValid,
      //                   ),
      //
      //
      //             // child: ElevatedButton(
      //             //   onPressed: () {
      //             //     print("email-->"+ email);
      //             //     print("password-->"+ password.length.toString());
      //             //
      //             //     BlocProvider.of<AuthenticationBloc>(context).add(
      //             //       LoginUser(
      //             //         email,
      //             //         password
      //             //       ),
      //             //     );
      //             //   },
      //             //   child:  Text(
      //             //     state is AuthenticationLoadingState
      //             //           ? '.......'
      //             //           : 'Login',
      //             //     style: const TextStyle(
      //             //       fontSize: 20,
      //             //     ),
      //             //   ),
      //             // ),
      //           );
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           const Text("Don't have an account? "),
      //           GestureDetector(
      //             onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(builder: (context) => const  SignupScreen()),
      //             );
      //         },
      //             child: const Text(
      //               'Register',
      //               style: TextStyle(
      //                 color: Colors.deepPurple,
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          CustomTextField(
            isEmail: true,
                  placeholder: "Enter your email",
                    controller: emailController,
                    prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Palette.iconColor
                    ),


                ),
          CustomTextField(
            controller: passwordController,
            hideText: !_isPasswordVisible,
            placeholder: "**********",
            suffixIcon: IconButton(
              onPressed: _toggleVisibility,
              icon:Icon(_isPasswordVisible? Icons.visibility_outlined:Icons.visibility_off_outlined)
            ),
            prefixIcon: const Icon(
              MaterialCommunityIcons.lock_outline,
             // Icons.key,
              color: Palette.iconColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Palette.textColor2,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: TextStyle(fontSize: 12, color: Palette.textColor1))
                ],
              ),
              TextButton(
                onPressed: () {
                  print("Clicked hello");
                },
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12, color: Palette.textColor1)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          CustomTextField(
            isEmail: false,
            placeholder: "User Name",
            controller: emailController,
            prefixIcon: Icon(
                MaterialCommunityIcons.account_outline,
                color: Palette.iconColor
            ),


          ),
          CustomTextField(
            isEmail: true,
            placeholder: "Email",
            controller: emailController,
            prefixIcon: Icon(
                MaterialCommunityIcons.email_outline,
                color: Palette.iconColor
            ),
          ),
          CustomTextField(
            isEmail: false,
            hideText: true,
            placeholder: "password",
            controller: passwordController,
            prefixIcon: Icon(
                MaterialCommunityIcons.lock_outline,
                color: Palette.iconColor
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: isMale
                                ? Palette.textColor2
                                : Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: isMale
                                    ? Colors.transparent
                                    : Palette.textColor1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text(
                        "Male",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: isMale
                                ? Colors.transparent
                                : Palette.textColor2,
                            border: Border.all(
                                width: 1,
                                color: isMale
                                    ? Palette.textColor1
                                    : Colors.transparent),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: isMale ? Palette.iconColor : Colors.white,
                        ),
                      ),
                      Text(
                        "Female",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By pressing 'Submit' you agree to our ",
                  style: TextStyle(color: Palette.textColor2),
                  children: [
                    TextSpan(
                      //recognizer: ,
                      text: "term & conditions",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {
        print("Todo Google Facebook Signin, Only support firebase login");
      },
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(145, 40),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 535 : 430,
      right: 0,
      left: 0,

        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ThelaApp.id,
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
            return  Center(
                child: Container(
                  height: 90,
                  width: 90,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        if (showShadow)
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1.5,
                            blurRadius: 10,
                          )
                      ]),
                  child: InkWell(
                    onTap: (){
                       _tryLogin();
                    },
                    child: !showShadow
                        ? Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.green, Colors.lightBlueAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.3),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ]),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )
                        : Center(),
                  ),
                ),

            );


              // child: CustomButton(
              //         onPressed: _tryLogin,
              //         padding: const EdgeInsets.symmetric(vertical: 20),
              //         label: "Login",
              //         disabled: !_isFormValid,
              //       ),

          },
        ),

    );
  }
}