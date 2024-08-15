import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/MedicalDetailDTO.dart';

class MedicalDetailRepository{
  final FirebaseFirestore _firestore;
  MedicalDetailRepository({ FirebaseFirestore? firestore}) :
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> storeUserDetails(MedicalDetailDTO medical) async {

    try {
      CollectionReference users = _firestore.collection('users');

      // Check if the document exists
      var userDoc = await users.doc(medical.uid).get();

      // Use set with merge to update or insert the data
      if (userDoc.exists) {
        await users.doc(medical.uid).set(
          {
            'medical': {
              'name': medical.name,
              'age': medical.age,
              'gender': medical.gender,
              'bloodType': medical.bloodType,
              'smoker': medical.smoker,
            }
          },
          SetOptions(merge: true), // Merge set options to update existing document
        );
        print('User details updated');
      } else {
        await users.doc(medical.uid).set(
          {
            'medical': {
              'name': medical.name,
              'age': medical.age,
              'gender': medical.gender,
              'bloodType': medical.bloodType,
              'smoker': medical.smoker,
            }
          },
        );
        print('Medical details added');
      }
    } catch (e) {
      print('Error storing user details: $e');
      throw e; // Rethrow the error to handle it at a higher level if needed
    }

  }


  Future<MedicalDetailDTO> getUserDetail(String userId) async {
    // Check if the document exists
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

    Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
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
        summary: medicalData?['summary']??'');
    return medicalDetailDTO;
  }
}