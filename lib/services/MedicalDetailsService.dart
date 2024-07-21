import 'package:myapp/entity/MedicalDetailDTO.dart';

import '../datastore/medical_detail_repository.dart'; // Import your repository

class MedicalDetailService {
  final MedicalDetailRepository _repository;

  MedicalDetailService({MedicalDetailRepository? repository})
      : _repository = repository ?? MedicalDetailRepository();

  void submit(MedicalDetailDTO medicalDto) async {
    try {
      // Call repository method to store user details in Firestore
      await _repository.storeUserDetails(medicalDto);

      print("User details submitted successfully from service");
    } catch (e) {
      print('Error submitting user details: $e');
      // Handle error as needed
    }
  }

  MedicalDetailDTO? getMedicalRecordOfUser(String userId) {
    try {
      // Call repository method to store user details in Firestore
      MedicalDetailDTO medicalDetailDTO =  _repository.getUserDetail(userId) as MedicalDetailDTO;
      return medicalDetailDTO;
    } catch (e) {
      print('Error submitting user details: $e');
      // Handle error as needed
    }
    return null;
  }
}
