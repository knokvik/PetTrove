import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/bloc/auth/auth_bloc.dart';
import 'package:pettrove/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';

class PetSelectionScreen extends StatefulWidget {
  @override
  _PetSelectionScreenState createState() => _PetSelectionScreenState();
}

class _PetSelectionScreenState extends State<PetSelectionScreen> {
  final List<String> availablePets = ['Dog', 'Cat', 'Rabbit', 'Bird'];
  final Set<String> selectedPets = {};

  void _togglePetSelection(String pet) {
    setState(() {
      if (selectedPets.contains(pet)) {
        selectedPets.remove(pet);
      } else if (selectedPets.length < 4) {
        selectedPets.add(pet);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Pets'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: availablePets.map((pet) {
                final isSelected = selectedPets.contains(pet);
                return ElevatedButton(
                  onPressed: () => _togglePetSelection(pet),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.green : Colors.grey[300],
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(pet),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: selectedPets.isNotEmpty ? () {
                
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
