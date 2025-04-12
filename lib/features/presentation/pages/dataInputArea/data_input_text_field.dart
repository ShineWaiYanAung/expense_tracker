import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../config/LottieCateogryPath/category_lottie_path.dart';

class DataInputTextField extends StatelessWidget {
  final String lottieCategoryPath;
  const DataInputTextField({super.key, required this.lottieCategoryPath});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                radius: 80,
                child: Lottie.asset(lottieCategoryPath),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        focusedBorder: null,
                        prefixIconColor: Colors.orange,
                        prefixIcon: Icon(Icons.airport_shuttle),
                        filled: true,
                        focusColor: Theme.of(context).scaffoldBackgroundColor,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        hintText: "Your Data Type",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter some text";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Use _controller.text for logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Processing: ${_controller.text}"),
                            ),
                          );
                        }
                      },
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
