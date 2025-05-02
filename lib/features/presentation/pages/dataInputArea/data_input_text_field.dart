import 'package:expense_tracker/features/data/model/expense_article_model.dart';
import 'package:expense_tracker/features/domain/entity/expense_article.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'package:expense_tracker/features/presentation/pages/home/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:country_flags/country_flags.dart';
import '../../../config/LottieCateogryPath/category_lottie_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final TextEditingController _noteController         = TextEditingController();
    final TextEditingController _costController         = TextEditingController();
    final TextEditingController _currencyNameController = TextEditingController();

    void gatheringAndAdding() {
      final String expenseName = _currencyNameController.text;
      final double cost = double.parse(_costController.text);
      final String note = _noteController.text;
      final DateTime dateTime = DateTime.now();
      final ExpenseType expenseType = type;

      final ExpenseArticle expenseArticlePerData = ExpenseArticle(
        name: expenseName,
        cost: cost,
        currencyName: "uk",
        note: note,
        expenseType: expenseType,
        time: dateTime,
      );
      context.read<LocalExpenseBloc>().add(
        InsertExpense(expenseArticlePerData),
      );
      _noteController.clear();
      _costController.clear();
     _currencyNameController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            width: 50,
            child: Image.asset("asset/images/flags/uk.png", fit: BoxFit.cover),
          ),
        ],
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => DashBoard()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 80,
                  child: Lottie.asset(lottieCategoryPath, width: 120),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Card(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListTile(
                    title: Center(child: Text(filterLabel(type))),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextFormField(
                        Icons.description,
                        _currencyNameController,
                        context,
                        label: "Name",
                      ),
                      buildTextFormField(
                        Icons.attach_money,
                        _costController,
                        context,
                        label: "Cost",
                      ),
                      buildTextFormField(
                        Icons.note_alt,
                        _noteController,
                        context,
                        label: "Note",
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).scaffoldBackgroundColor),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Use _controller.text for logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Processing}")),
                            );
                            gatheringAndAdding();
                          }
                        },
                        child: Text("Submit",style: TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
TextFormField buildTextFormFieldOnlyForExpenseType(
  TextEditingController _controller,
  BuildContext context,
  Icon icon, {
  required String label,
}) {
  return TextFormField(
    controller: _controller,
    decoration: InputDecoration(
      focusedBorder: null,
      prefixIconColor: Theme.of(context).cardColor,
      prefixIcon: Icon(Icons.airport_shuttle),
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
  );
}
