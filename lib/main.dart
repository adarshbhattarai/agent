import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/authentication_bloc.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/screens/authentication_page.dart';
import 'package:myapp/screens/home_screen.dart';
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
      
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: SignupScreen.id,
      routes: {
      SignupScreen.id: (context) => const SignupScreen(),
      HomeScreen.id: (context) => const HomeScreen(),
      },
      //home:  AuthenticationFlowScreen()
    ));    
  } 
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
          _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
