import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pettrove/presentation/screens/auth/login.dart';

const authOutlineInputBorder = OutlineInputBorder(
borderSide: BorderSide(color: Color(0xFF757575)),
borderRadius: BorderRadius.all(Radius.circular(100)),
);

class ForgotPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LogoWithTitle(
        title: 'Forgot Password',
        subText:
            "Sign in with your email and password  \nor continue with social media",
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Form(
              key: _formKey,
              child:  TextFormField(
            onSaved: (email) {},
            onChanged: (email) {},
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "Enter your email",
                labelText: "Email",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(color: Color(0xFF757575)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                border: authOutlineInputBorder,
                enabledBorder: authOutlineInputBorder,
                focusedBorder: authOutlineInputBorder.copyWith(
                    borderSide: const BorderSide(color: Color.fromRGBO(140, 207, 99, 1),))),
          ),
            ),
          ),
          SizedBox(height: 7),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Handle next step after validation
              }
            },
             style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color.fromRGBO(158, 232, 112, 1),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Text("Next",style: TextStyle(color: Colors.black),),
            ),
          ),
          SizedBox(height: 16),
          ExistingAccountText(),
        ],
      ),
    );
  }
}

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle(
      {super.key,
      required this.title,
      this.subText = '',
      required this.children});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                        color: Color.fromRGBO(22, 51, 0, 1),
                        fontSize: 36,
                        fontFamily: "Neue Plak",
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    subText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.64),
                    ),
                  ),
                ),
                ...children,
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ExistingAccountText extends StatelessWidget {
  const ExistingAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account? ",
          style: TextStyle(color: Color(0xFF757575)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color.fromRGBO(140, 207, 99, 1),
            ),
          ),
        ),
      ],
    );
  }
}