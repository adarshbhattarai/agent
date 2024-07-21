
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/screens/forgot_password.dart';
import 'package:myapp/screens/home_screen.dart';

import '../bloc/authentication_bloc.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'sign_up_screen';

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
  final agentController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    agentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create an account',
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
            const Text('Agent Name'),
            TextFormField(
              controller: agentController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.smart_toy_outlined, color: Colors.black),
                border: OutlineInputBorder(),
                hintText: 'Type your agent Name',
              ),
              obscureText: false,
            ),
            const SizedBox(height: 10),
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
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        SignUpUser(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          agentController.text.trim(),
                        ),
                      );
                    },
                    child:  Text(
                      state is AuthenticationLoadingState
                            ? '.......'
                            : 'Register',
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
                  onTap: () {
                   Navigator.pop(context);
                  },
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