import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/authentication_bloc.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/screens/forgot_password.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/sign_up.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
);
//await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyAgent());
}

class MyAgent extends StatelessWidget {
  const MyAgent({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AuthenticationBloc(),
    child:  MaterialApp(
      
      title: 'Thela App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.id,
      routes: {
      LoginScreen.id: (context) => const LoginScreen(),
      HomeScreen.id: (context) => const HomeScreen(),
      ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
      }
    ));    
  } 
}