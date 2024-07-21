import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/component/medical_history_screen.dart';
import 'package:myapp/screens/login_screen.dart';

import '../bloc/authentication_bloc.dart';
import '../entity/MedicalDetailDTO.dart';
import '../services/MedicalDetailsService.dart';
import  'package:firebase_auth/firebase_auth.dart' as auth;

class HomeScreen extends StatefulWidget {

  static String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  _MyMedicalHomeScreenState createState() => _MyMedicalHomeScreenState();
}

class _MyMedicalHomeScreenState extends State<HomeScreen>{
  late MedicalDetailService medicalDetailService;
  bool userInfoAvailable = false;
  MedicalDetailDTO? medicalDetailDTO;
  @override
  void initState(){
    medicalDetailService = MedicalDetailService();
    var firebaseUser = auth.FirebaseAuth.instance.currentUser;
    medicalDetailDTO = medicalDetailService.getMedicalRecordOfUser(firebaseUser!.uid);
    if(medicalDetailDTO == null){
       userInfoAvailable = false;
    }else{
      userInfoAvailable = true;
    }
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MedicalHistoryScreen(),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationLoadingState) {
                  const CircularProgressIndicator();
                  if(!state.isLoading){
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                  }
                } else if (state is AuthenticationFailureState){
                  showDialog(context: context, builder: (context){
                    return const AlertDialog(
                      content: Text('error'),
                    );
                  });
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {

                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(SignOut());

                    }, child: const Text(
                    'logOut'
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

}
