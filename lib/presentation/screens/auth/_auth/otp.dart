import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/bloc/auth/auth_bloc.dart';
import 'package:pettrove/bloc/auth/auth_event.dart';
import 'package:pettrove/data/repository/auth_repository.dart';
import 'dart:async';

import 'package:pettrove/presentation/screens/auth/_auth/reset.dart'; // Import for Timer

class OtpScreen extends StatelessWidget {
  final String email;
  final String type;
  const OtpScreen({super.key, required this.email , required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "OTP Verification",
                    style: TextStyle(
                      color: Color.fromRGBO(22, 51, 0, 1),
                      fontSize: 32,
                      fontFamily: "Neue Plak",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "We sent your code to $email\nThis code will expire in 30 sec's",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontFamily: "Inter",
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  OtpForm(email: email , type: type,), // Pass email to OtpForm
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class OtpForm extends StatefulWidget {
  final String email; // Add email parameter
  final String type;
  const OtpForm({super.key, required this.email ,required this.type}); // Accept email in constructor

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late Timer _timer;
  int _start = 60; // Starting countdown timer value
  bool _canResend = false;
  bool isLoading = false; // Track loading state
  final AuthRepository authRepository = AuthRepository();
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the widget is initialized
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose()); // Dispose controllers
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true; // Allow resend after timer ends
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  // Function to get the OTP from the text controllers
  String _getOtp() {
    return _controllers.map((controller) => controller.text).join('');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => _buildOtpField(index)),
          ),
          const SizedBox(height: 32),
          isLoading
              ? const Center(child: CircularProgressIndicator()) // Show loading indicator
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true; // Start loading
                    });

                    if (widget.type == "Reset") {
                      if (_canResend) {
                        Navigator.pop(context); // Navigate back if allowed to resend
                      } else {
                        String otp = _getOtp(); // Get OTP entered by user
                        if (otp.length == 4) {
                          bool result = await authRepository.verifyOtp(
                              email: widget.email, otp: otp);
                          setState(() {
                            isLoading = false; // Stop loading after request completes
                          });
                          if (result) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ResetPasswordScreen(email: widget.email),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Invalid OTP, please try again.')),
                            );
                          }
                        } else {
                          setState(() {
                            isLoading = false; // Stop loading if validation fails
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter a valid OTP.')),
                          );
                        }
                      }
                    }

                    if (widget.type == "Verify") {
                      bool response = await authRepository.verifyOtp(
                          email: widget.email, otp: _getOtp());
                      setState(() {
                        isLoading = false; // Stop loading after request completes
                      });
                      if (response) {
                        context.read<RegisterBloc>().add(VerificationCompleted());
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid OTP")),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color.fromRGBO(158, 232, 112, 1),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  ),
                  child: Text(
                    _canResend ? "Resend Code" : "Continue",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
          const SizedBox(height: 16),
          Text(
            "Resend OTP in $_start sec",
            style: const TextStyle(
              color: Color(0xFF757575),
              fontFamily: "Inter",
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      height: 64,
      width: 64,
      child: TextFormField(
        controller: _controllers[index], // Assign controller to each field
        onChanged: (pin) {
          if (pin.isNotEmpty) {
            FocusScope.of(context).nextFocus(); // Move to next field
          }
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(
          fontSize: 24,
          fontFamily: "Neue Plak",
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(22, 51, 0, 1),
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: "0",
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          border: authOutlineInputBorder,
          enabledBorder: authOutlineInputBorder,
          focusedBorder:
              authOutlineInputBorder.copyWith(borderSide: const BorderSide(color: Color.fromRGBO(158, 232, 112, 1))),
        ),
      ),
    );
  }
}
  