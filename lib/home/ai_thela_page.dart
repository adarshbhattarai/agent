import 'package:e_thela_dental_bot/entity/MedicalDetailDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/person_info.dart';
import '../constants/palette.dart';
import '../state/thela_state.dart';

class AIPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ThelaState>();
    var pair = appState.current;
    MedicalDetailDTO? medicalUser = appState.user;
    // Check if medicalUser is null
    if (medicalUser == null) {
      return Center(
        child: CircularProgressIndicator(), // Show a progress indicator while loading
      );
    }


    // Initialize medicalDetailDTO properly
    MedicalDetailDTO medicalDetailDTO = medicalUser
        ?? MedicalDetailDTO(
            uid: medicalUser!.uid,
            name: medicalUser.name,
            age:medicalUser.age,
            smoker: medicalUser.smoker,
            hasDiabetes: medicalUser.hasDiabetes,
            location: medicalUser.location,
            gender:  medicalUser.gender,
            bloodType: medicalUser.bloodType,
            summary:medicalUser.summary);
    return Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: Padding(padding: EdgeInsets.all(10),
        child:
        PersonInfoContainer(medicalDetailDTO: medicalDetailDTO,)),
    );

  }
  
  
}