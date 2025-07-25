import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import 'reset_password_screen.dart';

class CheckEmailScreen extends StatefulWidget {
  final String email;
  const CheckEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false;

  Future<bool> verifyResetCode(String email, String code) async {
    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse(AppConstants.verifyResetCode),
      headers: AppConstants.headers,
      body: jsonEncode({'email': email, 'token': code}),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      return true;
    } else {
      final errorMsg = jsonDecode(response.body)['message'] ?? 'Invalid or expired code';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
      return false;
    }
  }

  Widget _buildCodeCircle(int index) {
    String digit = '';
    if (codeController.text.length > index) {
      digit = codeController.text[index];
    }

    final primaryColor = Colors.white;

    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: digit.isNotEmpty ? primaryColor : Colors.white70,
          width: 2,
        ),
        color: digit.isNotEmpty ? Colors.white24 : Colors.transparent,
      ),
      child: Text(
        digit,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    codeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: const Text('Verify Code'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter the 6-digit code sent to',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                widget.email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) => _buildCodeCircle(index)),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: 250,
                child: TextField(
                  controller: codeController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: const TextStyle(color: Colors.transparent),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  enableInteractiveSelection: false,
                ),
              ),
              const SizedBox(height: 40),

              isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final code = codeController.text.trim();
                    if (code.length != 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter a valid 6-digit code')),
                      );
                      return;
                    }
                    bool verified = await verifyResetCode(widget.email, code);
                    if (verified) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ResetPasswordScreen(email: widget.email, code: code),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Verify Code'),
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
