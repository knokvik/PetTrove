import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 80 , bottom: 40 , right: 30 , left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              'images/pet.jpeg', // Add your logo to assets
              height: 100,
            ),
            const SizedBox(height: 24),

            // App Name
            const Text(
              'PetTrove',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Neue Plak',
                color: Color.fromRGBO(22, 51, 0, 1),
              ),
            ),
            const SizedBox(height: 16),

            // App Description
            const Text(
              'PetTrove is your all-in-one solution for pet care. '
              'Track your pet’s health, vaccinations, and checkups with ease. '
              'Manage feeding and exercise schedules to keep your pets healthy and happy. '
              'Discover a curated pet shop for quality products tailored for your pets. '
              'Connect with other pet owners through the community blog and get expert advice. '
              'Stay updated with timely notifications and reminders for your pet’s health. '
              'Keep a detailed health record for each pet, ensuring you never miss a checkup. '
              'Enjoy personalized recommendations based on your pet’s breed and age. '
              'Share your pet’s progress and milestones with the community. '
              'PetTrove ensures that your pet gets the care and attention it deserves!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const Spacer(),

            // Copyright Notice
            const Text(
              '© 2025 PetTrove. All Rights Reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontFamily: 'Neue Plak',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
