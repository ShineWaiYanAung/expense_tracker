import 'dart:ui';
import 'package:expense_tracker/features/domain/entity/auth_article.dart';
import 'package:expense_tracker/features/domain/entity/expense_article.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'package:expense_tracker/features/presentation/pages/home/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/firebase_bloc_state_management/fire_base_cubit_state_management.dart';
import '../../bloc/firebase_bloc_state_management/firebase_cubit_state.dart';

class DataInputTextField extends StatelessWidget {
  final ExpenseType type;
  final String lottieCategoryPath;
  const DataInputTextField({
    super.key,
    required this.lottieCategoryPath,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController noteController = TextEditingController();
    final TextEditingController costController = TextEditingController();
     String ownerId = '';
     CurrencyType currencyName = CurrencyType.uk;
    final TextEditingController currencyNameController =
        TextEditingController();
    final state = context.read<FirebaseCubit>().state;

    if (state is FirebaseLoginSuccess) {
      ownerId = state.user.id;
      currencyName = state.user.currency;
      print('Owner ID: $ownerId');
    }

    void gatheringAndAdding() {
      final String expenseName = currencyNameController.text;
      final double cost = double.parse(costController.text);
      final String note = noteController.text;
      final DateTime dateTime = DateTime.now();
      final ExpenseType expenseType = type;

      final ExpenseArticle expenseArticlePerData = ExpenseArticle(
        name: expenseName,
        cost: cost,
        currencyName: currencyName,
        note: note,
        expenseType: expenseType,
        time: dateTime, ownerId: ownerId,
      );
      context.read<LocalExpenseBloc>().add(
        InsertExpense(expenseArticlePerData),
      );
      noteController.clear();
      costController.clear();
      currencyNameController.clear();
    }

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
            ], // Start and end colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => DashBoard()),
                        );
                        // Navigator.of(context).pop(); // Use po
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).cardColor),
                      ),
                      width: 50,
                      child: Image.asset(
                        "asset/images/flags/uk.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // shadow color
                        blurRadius: 10, // softness of the shadow
                        spreadRadius: 2, // how far the shadow spreads
                        offset: Offset(0, 4), // shadow position (x, y)
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    radius: 80,
                    child: Lottie.asset(lottieCategoryPath, width: 120),
                  ),
                ),
                SizedBox(height: 20),
                Text(filterLabel(type),style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildTextFormField(
                          Icons.description,
                          currencyNameController,
                          context,
                          label: "Name",
                        ),
                        buildTextFormField(
                          Icons.attach_money,
                          costController,
                          context,
                          label: "Cost",
                        ),
                        buildTextFormField(
                          Icons.note_alt,
                          noteController,
                          context,
                          label: "Note",
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Use _controller.text for logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Settings Your Data successfully!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              gatheringAndAdding();
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String filterLabel(ExpenseType type) {
    switch (type) {
      case ExpenseType.bill:
        return "Bill";
      case ExpenseType.transport:
        return "Transport";
      case ExpenseType.food:
        return "Food";
    }
  }

  ///gatheringAndAddingDataFunc

  ///TextField
  Widget buildTextFormField(
    IconData iconData,
    TextEditingController _controller,
    BuildContext context, {
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          focusedBorder: null,
          prefixIconColor: Theme.of(context).cardColor,
          prefixIcon: Icon(iconData),
          filled: true,
          focusColor: Theme.of(context).scaffoldBackgroundColor,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          hintText: label,
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
    );
  }
}

//ExpenseTypeTexField,
Widget buildTextFormFieldOnlyForExpenseType(
  TextEditingController _controller,
  BuildContext context,
  Icon icon, {
  required String label,
}) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black, // Adjust the color and opacity of the shadow
          offset: Offset(0, 4), // Set shadow direction
          blurRadius: 6, // Set shadow blur intensity
          spreadRadius: 1, // Set shadow spread
        ),
      ],
      borderRadius: BorderRadius.circular(
        20,
      ), // Match the TextField's border radius
    ),
    child: TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        focusedBorder: null,
        //  prefixIconColor: Theme.of(context).cardColor,
        // prefixIcon: Icon(Icons.airport_shuttle),
        filled: true,
        focusColor: Theme.of(context).scaffoldBackgroundColor,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).cardColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter some text";
        }
        return null;
      },
    ),
  );
}
