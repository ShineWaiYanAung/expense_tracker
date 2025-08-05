import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();

  String? _selectedCountry;

  final List<String> countries = ['UK', 'Japan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).cardColor,
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).cardColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(
                      child: Lottie.asset("lottie/cute_bear.json"),
                    ),
                    buildTextFormField(
                      Icons.person,
                      _usernameController,
                      context,
                      label: "Username",
                    ),
                    buildTextFormField(
                      Icons.lock,
                      _passwordController,
                      context,
                      label: "Password",
                    ),
                    buildCountryDropdown(context),
                    buildTextFormField(
                      Icons.vpn_key,
                      _tokenController,
                      context,
                      label: "Token",
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final username = _usernameController.text;
                          final password = _passwordController.text;
                          final token = _tokenController.text;
                          final country = _selectedCountry;
          
                          debugPrint('Username: $username');
                          debugPrint('Password: $password');
                          debugPrint('Country: $country');
                          debugPrint('Token: $token');
          
                          // You can now send this data to your WeatherAPI or elsewhere
                        }
                      },
                      child: const Text("Sign Up"),
                    ),

                    const SizedBox(height: 16),

                    // Sign-up navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account ?",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to sign-up screen
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle( color : Colors.white,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
      IconData iconData,
      TextEditingController controller,
      BuildContext context, {
        required String label,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          hintText: label,
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        obscureText: label == "Password", // hide password
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }

  Widget buildCountryDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DropdownButtonFormField<String>(
        value: _selectedCountry,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.flag),
          hintText: "Select Country",
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        items: countries.map((country) {
          return DropdownMenuItem<String>(
            value: country,
            child: Text(country,style: TextStyle(color: Colors.black),),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedCountry = value;
          });
        },
        validator: (value) => value == null ? "Please select a country" : null,
      ),
    );
  }
}

