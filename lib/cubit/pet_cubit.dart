import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

class PetState {
  final String selectedPet;
  final int vaccinationCount;
  final int checkupCount;
  final int otherStats;

  PetState({
    required this.selectedPet,
    required this.vaccinationCount,
    required this.checkupCount,
    required this.otherStats,
  });

  PetState copyWith({
    String? selectedPet,
    int? vaccinationCount,
    int? checkupCount,
    int? otherStats,
  }) {
    return PetState(
      selectedPet: selectedPet ?? this.selectedPet,
      vaccinationCount: vaccinationCount ?? this.vaccinationCount,
      checkupCount: checkupCount ?? this.checkupCount,
      otherStats: otherStats ?? this.otherStats,
    );
  }
}

class PetCubit extends Cubit<PetState> {
  PetCubit()
      : super(PetState(
          selectedPet: 'Dog',
          vaccinationCount: 0,
          checkupCount: 0,
          otherStats: 0,
        ));

  void selectPet(String pet) {
    // Load stats from backend if needed
    emit(state.copyWith(selectedPet: pet));
    loadStats(pet);
  }

  void updateVaccinationCount(int value) {
    final newCount = state.vaccinationCount + value;
    emit(state.copyWith(vaccinationCount: newCount));
    // updateStatsToBackend();
  }

  void updateCheckupCount(int value) {
    final newCount = state.checkupCount + value;
    emit(state.copyWith(checkupCount: newCount));
    // updateStatsToBackend();  
  }

  void updateOtherStats(int value) {
    final newCount = state.otherStats + value;
    emit(state.copyWith(otherStats: newCount));
    // updateStatsToBackend();
  }

  Future<void> loadStats(String pet) async {
    // Simulate backend call
    emit(state.copyWith(
      vaccinationCount: 3,
      checkupCount: 2,
      otherStats: 5,
    ));
  }

//   Future<void> updateStatsToBackend() async {
//     // Backend update logic
//     try {
//       final url = Uri.parse('https://clever-shape-81254.pktriot.net/update-stats');
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'pet': state.selectedPet,
//           'vaccinationCount': state.vaccinationCount,
//           'checkupCount': state.checkupCount,
//           'otherStats': state.otherStats,
//         }),
//       );
//       if (response.statusCode == 200) {
//         print('Stats updated successfully');
//       } else {
//         print('Failed to update stats');
//       }
//     } catch (e) {
//       print('Error updating stats: $e');
//     }
//   }
}
