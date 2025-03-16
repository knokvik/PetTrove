import 'package:flutter/material.dart';
import 'package:pettrove/presentation/screens/auth/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 14,
              child: PageView.builder(
                itemCount: demoData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                  illustration: demoData[index]["illustration"],
                  title: demoData[index]["title"],
                  text: demoData[index]["text"],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                demoData.length,
                (index) => DotIndicator(isActive: index == currentPage),
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false, // This removes all previous routes
          );

            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Color.fromRGBO(158, 232, 112, 1),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Text("Get Started",style: TextStyle(color: Colors.black),),
            ),
          )
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.illustration,
    required this.title,
    required this.text,
  });

  final String? illustration, title, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: title == "Personalized Recommendations" ? Image.network(
              illustration!,
              fit: BoxFit.contain,
            )
            :
            Image.asset(
              illustration!,
              fit: BoxFit.contain,
            ) 
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title!,
          textAlign: TextAlign.center,  // Centers the text horizontally
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: "Neue Plak",
                color: Color.fromRGBO(22, 51, 0, 1),
                fontSize: 30 // Custom font
              ),
        )
        ,

        const SizedBox(height: 8),
        Text(
          text!,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.activeColor = const Color.fromRGBO(140, 207, 99, 1),
    this.inActiveColor = const Color(0xFF868686),
  });

  final bool isActive;
  final Color activeColor, inActiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 16 / 2),
      height: 5,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

// Demo data for our Onboarding screen
List<Map<String, dynamic>> demoData = [
  {
    "illustration": "images/splash_1.jpg",
    "title": "All Pet Essentials",
    "text": "Shop premium food, toys, and accessories\nfor all your beloved pets.",
  },
  {
    "illustration": "images/splash_2.jpeg",
    "title": "Free & Fast Delivery",
    "text": "Enjoy free delivery on your first order\nand quick doorstep service.",
  },
  {
    "illustration": "https://img.freepik.com/premium-photo/pet-cartoon-mammal-animal_53876-199725.jpg",
    "title": "Personalized Recommendations",
    "text": "Find the best products tailored for your pets\nwith our smart suggestions.",
  },
];
