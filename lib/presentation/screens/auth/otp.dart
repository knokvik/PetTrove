import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
                      fontSize: 28,
                      fontFamily: "Neue Plak",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "We sent your code to +1 898 860 *** \nThis code will expire in 00:30",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontFamily: "Inter",
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  const OtpForm(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Resend OTP Code",
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontFamily: "Inter",
                        fontSize: 14,
                      ),
                    ),
                  ),
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

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => _buildOtpField(context)),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromRGBO(158, 232, 112, 1),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),
            ),
            child: const Text(
              "Continue",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpField(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: TextFormField(
        onChanged: (pin) {
          if (pin.isNotEmpty) {
            FocusScope.of(context).nextFocus();
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
          focusedBorder: authOutlineInputBorder.copyWith(
            borderSide: const BorderSide(color: Color.fromRGBO(158, 232, 112, 1)),
          ),
        ),
      ),
    );
  }
}
