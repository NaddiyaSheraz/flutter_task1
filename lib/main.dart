import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 205, 135, 227)),
        useMaterial3: true,
      ),
      home: const InputFormScreen(),
    );
  }
}

class InputFormScreen extends StatefulWidget {
  const InputFormScreen({super.key});

  @override
  State<InputFormScreen> createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildInputField(
                  nameController,
                  'Name',
                  'Name cannot be empty',
                  'Name must contain only alphabetic characters',
                  r'^[a-zA-Z\s]+$'),
              _buildInputField(
                  emailController,
                  'Email',
                  'Email cannot be empty',
                  'Enter a valid email',
                  r'^[\w\.-]+@[a-zA-Z]+\.[a-zA-Z]+$',
                  TextInputType.emailAddress),
              _buildInputField(
                  cnicController,
                  'CNIC',
                  'CNIC cannot be empty',
                  'CNIC must be exactly 13 digits',
                  r'^\d{13}$',
                  TextInputType.number),
              _buildInputField(
                  phoneController,
                  'Phone Number',
                  'Phone number cannot be empty',
                  'Phone number must be between 10 and 12 digits',
                  r'^\d{10,12}$',
                  TextInputType.phone),
              _buildInputField(
                  addressController, 'Address', 'Address cannot be empty'),
              _buildPasswordInputField(passwordController),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 178, 157, 215),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _handleSubmit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      TextEditingController controller, String label, String emptyError,
      [String? patternError,
      String? pattern,
      TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return emptyError;
          } else if (pattern != null && !RegExp(pattern).hasMatch(value)) {
            return patternError;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordInputField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password cannot be empty';
          } else if (value.length < 8) {
            return 'Password must be at least 8 characters';
          } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#\$&*~])')
              .hasMatch(value)) {
            return 'Password must contain letters, numbers, and symbols';
          }
          return null;
        },
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Form Data'),
            content: Text(
              'Name: ${nameController.text}\n'
              'Email: ${emailController.text}\n'
              'CNIC: ${cnicController.text}\n'
              'Phone: ${phoneController.text}\n'
              'Address: ${addressController.text}\n'
              'Password: ${passwordController.text}',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
