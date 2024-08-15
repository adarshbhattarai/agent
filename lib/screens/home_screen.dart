import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication_bloc.dart';
import '../component/person_info.dart';
import '../entity/MedicalDetailDTO.dart';
import '../services/MedicalDetailsService.dart';
import  'package:firebase_auth/firebase_auth.dart' as auth;

import 'login_screen.dart';
import 'user_question_screen.dart';

class HomeScreen extends StatefulWidget {

  static String id =  'home_screen';
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
  //  :  UserQuestionScreen(medicalDetailDTO:medicalDetailDTO! )
    medicalDetailService = MedicalDetailService();
    var firebaseUser = auth.FirebaseAuth.instance.currentUser;
    var token = auth.FirebaseAuth.instance.currentUser!.getIdToken();
    print(token);
    //medicalDetailDTO = medicalDetailService.getMedicalRecordOfUser(firebaseUser!.uid)!;
    if(medicalDetailDTO == null){
      print("Got user medical info");
      userInfoAvailable = false;
    }else{
      print("Not found User Medical Info");
      userInfoAvailable = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var firebaseUser = auth.FirebaseAuth.instance.currentUser;
    var userId = firebaseUser!.uid;
    //medicalDetailDTO = medicalDetailService.getMedicalRecordOfUser(firebaseUser!.uid)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                Map<String, dynamic>? medicalData = data['medical'];
                MedicalDetailDTO medicalDetailDTO = MedicalDetailDTO(
                    uid: medicalData?['uid'] ?? '',
                    name: medicalData?['name'] ?? '',
                    age: medicalData?['age'] ?? 0,
                    hasDiabetes: medicalData?['hasDiabetes'] ?? false,
                    smoker: medicalData?['smoker'] ?? false,
                    location: medicalData?['location'] ?? 'None',
                    gender:  medicalData?['gender'] ?? 'Unk',
                    bloodType: medicalData?['bloodType'],
                    summary: medicalData?['summary'] ?? ''
                );

                return  PersonInfoContainer(medicalDetailDTO: medicalDetailDTO);
              }, ) ,

            SizedBox(width: 16, height: 18),

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
                    'logout'
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

}
