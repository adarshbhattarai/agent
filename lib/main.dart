import 'package:e_thela_dental_bot/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'bloc/authentication_bloc.dart';
import 'constants/palette.dart';
import 'firebase_options.dart';
import 'screens/forgot_password.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_service.dart';


void setupLocator(){
  GetIt.I.registerLazySingleton(()=>ApiService());
}
void main() async{
  setupLocator();
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
);
// FirebaseFunctions.instanceFor(region: 'us-central1')
//     .useFunctionsEmulator('localhost', 5001);

final settingsController = SettingsController(SettingsService());
await settingsController.loadSettings();

// await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);


runApp( MyAgent(settingsController: settingsController));

}

class MyAgent extends StatelessWidget {
  const MyAgent({super.key, required this.settingsController});

  final SettingsController settingsController;
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AuthenticationBloc(),
    child:  MaterialApp(
      title: 'E-Thela App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:  Palette.backgroundColor,),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.id,
      routes: {
      LoginScreen.id: (context) => LoginScreen(settingsController: settingsController),
      ThelaApp.id: (context) => ThelaApp(settingsController: settingsController),
      ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
      }
    ));    
  } 
}