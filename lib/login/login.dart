import 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
   const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            
),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              
              onPressed: () {
                // Sign in the user with Firebase Auth
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
