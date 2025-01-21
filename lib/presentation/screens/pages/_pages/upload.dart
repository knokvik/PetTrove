import 'package:flutter/material.dart';

class ComposeBlogPage extends StatefulWidget {
  @override
  State<ComposeBlogPage> createState() => _ComposeBlogPageState();
}

class _ComposeBlogPageState extends State<ComposeBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // 5% of screen width for padding
          vertical: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Compose Blog',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Neue Plak",
                  color: Color.fromRGBO(22, 51, 0, 1),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 18),
              // Title Input Field
              TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.title_outlined,
                      color: const Color.fromARGB(205, 34, 33, 33),
                    ),
                  ),
                  hintText: "Enter title",
                  labelText: "Title",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(color: Color(0xFF757575)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(140, 207, 99, 1)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Image URL Input Field
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.image_outlined,
                      color: const Color.fromARGB(205, 34, 33, 33),
                    ),
                  ),
                  hintText: "Enter Image URL",
                  labelText: "Image URL",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(color: Color(0xFF757575)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(140, 207, 99, 1)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Description Input Field
              TextFormField(
                controller: descriptionController,
                textInputAction: TextInputAction.done,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "Enter description",
                  labelText: "Description",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(color: Color(0xFF757575)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: const BorderSide(color: Color(0xFF757575)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: const BorderSide(color: Color(0xFF757575)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(140, 207, 99, 1)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Upload Button
              ElevatedButton(
                onPressed: () {
                  // Handle upload logic
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(158, 232, 112, 1),
                  foregroundColor: Colors.white,
                  minimumSize: Size(screenWidth * 0.8, 48),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text("Upload", style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define the authOutlineInputBorder for reuse
final OutlineInputBorder authOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(40)),
  borderSide: BorderSide(color: Color(0xFF757575)),
);
