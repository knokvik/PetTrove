import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ManagePetsScreen extends StatefulWidget {
  @override
  _ManagePetsScreenState createState() => _ManagePetsScreenState();
}

class _ManagePetsScreenState extends State<ManagePetsScreen> {
  List<String> pets = [];
  List<String> allPetOptions = ['Dog', 'Cat', 'Bird', 'Rabbit',];

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
  final prefs = await SharedPreferences.getInstance();
  final currentUser = jsonDecode(prefs.getString('currentUser') ?? '{}');
  print(currentUser);

  setState(() {
    pets = (currentUser['pets'] as List<dynamic>?)?.map((pet) {
          return pet['name'] as String; // Extract the pet name
        }).toList() ?? [];
  });
}


  Future<void> _updatePets() async {
  final prefs = await SharedPreferences.getInstance();
  final currentUser = jsonDecode(prefs.getString('currentUser') ?? '{}');
  final userId = currentUser['id'];

  final formattedPets = pets.map((pet) => {
        'name': pet,
        'vaccinationCount': 0,
        'checkupCount': 0,
        'exerciseCount': 0,
        'feedingCount': 0,
      }).toList();

  try {
    final url = Uri.parse('https://clever-shape-81254.pktriot.net/auth/update-pets');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'pets': formattedPets, // Send structured pets
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pets updated successfully!')),
      );

      // Save structured data to SharedPreferences
      await prefs.setString('currentUser', jsonEncode({
        'id': userId,
        'pets': formattedPets,
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update pets')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


 void _selectPets() async {
  List<String> selectedPets = List.from(pets);

  await showModalBottomSheet(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: allPetOptions.map((pet) {
                  bool isSelected = selectedPets.contains(pet);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedPets.remove(pet);
                        } else if (selectedPets.length < 4) {
                          selectedPets.add(pet);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromRGBO(159, 232, 112, 1)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(35), // Matching border radius
                      ),
                      child: Text(
                        pet,
                        style: TextStyle(
                          color: isSelected
                              ? const Color.fromRGBO(22, 51, 0, 1)
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Neue Plak",
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16), // Add space above button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => pets = selectedPets);
                    Navigator.pop(context);
                    _updatePets(); // Update pets after selection
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(159, 232, 112, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(
                      color: Color.fromRGBO(22, 51, 0, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Manage Pets',
          style: TextStyle(
            color: Color.fromRGBO(22, 51, 0, 1),
            fontSize: 20,
            fontFamily: "Neue Plak",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pets.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: ListTile(
                    title: Text(
                      "   ${pets[index]}",
                      style: const TextStyle(
                        color: Color.fromRGBO(22, 51, 0, 1),
                        fontSize: 20,
                        fontFamily: "Neue Plak",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Color.fromRGBO(142, 144, 141, 1)),
                      onPressed: () {
                        setState(() => pets.removeAt(index));
                        _updatePets();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Styled "Add Pets" button
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20 ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectPets,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(159, 232, 112, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Add Pets",
                  style: TextStyle(
                    color: Color.fromRGBO(22, 51, 0, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
