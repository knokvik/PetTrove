import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PetPage extends StatefulWidget {
  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  List<Map<String, dynamic>> pets = [];
  Map<String, dynamic>? selectedPet;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('currentUser');
    if (userData != null) {
      final user = jsonDecode(userData);
      setState(() {
        pets = List<Map<String, dynamic>>.from(user['pets']);
        if (pets.isNotEmpty) {
          selectedPet = pets.first;
        }
      });
    }
  }

  void _updateStat(String stat, int value) {
    setState(() {
      if (selectedPet != null) {
        selectedPet![stat] = (selectedPet![stat] ?? 0) + value;
        if (selectedPet![stat] < 0) selectedPet![stat] = 0;
      }
    });
  }

  Future<void> _updateStatsToServer() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('currentUser');
    if (userData != null) {
      final user = jsonDecode(userData);
      final userId = user['id'];

      final response = await http.post(
        Uri.parse('https://your-server-url.com/update-pet-stats'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'pets': pets,
        }),
      );

      if (response.statusCode == 200) {
        await prefs.setString('currentUser', jsonEncode({...user, 'pets': pets}));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stats updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update stats')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Pet Stats',
          style: TextStyle(
            color: Color.fromRGBO(22, 51, 0, 1),
            fontSize: 20,
            fontFamily: "Neue Plak",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pets.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35), // Matching border radius
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: DropdownButtonHideUnderline(
                
                  child: DropdownButton<Map<String, dynamic>>(
                    value: selectedPet,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Color.fromRGBO(22, 51, 0, 1)),
                     focusColor: Colors.transparent, // Removes yellow highlight
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                    items: pets.map((pet) {
                      return DropdownMenuItem(
                        value: pet,
                        child: Text(
                          "                                        " + pet['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(22, 51, 0, 1),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Neue Plak",
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newPet) {
                      setState(() => selectedPet = newPet);
                    },
                  ),
                ),
              ),
            ),

          const SizedBox(height: 16),

          if (selectedPet != null) ...[
            _buildStatContainer('      Vaccination Count', 'vaccinationCount'),
            _buildStatContainer('      Checkup Count', 'checkupCount'),
            _buildStatContainer('      Exercise Count', 'exerciseCount'),
            _buildStatContainer('      Feeding Count', 'feedingCount'),
          ],
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _updateStatsToServer,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(159, 232, 112, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              "Save Stats",
              style: TextStyle(
                color: Color.fromRGBO(22, 51, 0, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatContainer(String label, String statKey) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35), // Matching border radius
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label: ${selectedPet?[statKey] ?? 0}',
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(22, 51, 0, 1),
              fontFamily: "Neue Plak",
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Color.fromRGBO(142, 144, 141, 1)),
                onPressed: () => _updateStat(statKey, -1),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Color.fromRGBO(159, 232, 112, 1)),
                onPressed: () => _updateStat(statKey, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
