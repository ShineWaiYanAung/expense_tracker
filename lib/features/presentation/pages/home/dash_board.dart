import 'package:expense_tracker/features/config/LottieCateogryPath/category_lottie_path.dart';
import 'package:expense_tracker/features/presentation/bloc/color_state_mangaement/color_bloc.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'package:expense_tracker/features/presentation/pages/dataInputArea/data_input_text_field.dart';
import 'package:expense_tracker/features/presentation/widget/Drawer/drawer_open.dart';
import 'package:flutter/material.dart';
import 'package:draggable_button_panel/draggable_button_panel.dart';
import '../../../domain/entity/expense_article.dart';
import '../../bloc/color_state_mangaement/color_event.dart';
import '../../bloc/color_state_mangaement/color_state.dart';
import '../../bloc/local_bloc_statement/local_expense_state.dart';
import '../../widget/cardButton/widget_card_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/theme/theme.dart';
import '../../widget/dashboard_widget/pie_chart.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool showPanel = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<DraggableButtonPanelState> _draggableButtonPanelKey =
      GlobalKey<DraggableButtonPanelState>();

  // Show the draggable button by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer:DrawerOpen(drawerKey: _scaffoldKey,),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).scaffoldBackgroundColor,
        onPressed: () {
          showDialogOption();
        },
        child: Icon(Icons.add, size: 30),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  buildTopBar(context),
                  SizedBox(height: 40),
                  buildDataShowCard(context),
                  SizedBox(height: 30),
                  buildSecondBar(),
                  SizedBox(height: 20),
                  buildDataListTile(),
                ],
              ),
            ),
            if (showPanel)
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (BuildContext context, state) {
                  return DraggableButtonPanel(
                    buttonColor: Theme.of(context).cardColor,
                    panelColor: Theme.of(context).scaffoldBackgroundColor,
                    key: _draggableButtonPanelKey,
                    top: 100,
                    options: [
                      IconButton(
                        icon: Icon(Icons.circle, color: Colors.brown),
                        onPressed: () {
                          context.read<ThemeBloc>().add(
                            ChangeThemeEvent(
                              selectedTheme: AppThemeColor.brown,
                            ),
                          );
                          print("Brown theme applied");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.circle, color: Colors.black),
                        onPressed: () {
                          context.read<ThemeBloc>().add(
                            ChangeThemeEvent(
                              selectedTheme: AppThemeColor.black,
                            ),
                          );
                          print("Brown theme applied");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.circle, color: Colors.blue),
                        onPressed: () {
                          context.read<ThemeBloc>().add(
                            ChangeThemeEvent(selectedTheme: AppThemeColor.blue),
                          );
                          print("Brown theme applied");
                        },
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  //DataListTile
  Expanded buildDataListTile() {
    return Expanded(
      child: BlocBuilder<LocalExpenseBloc, LocalExpenseState>(
        builder: (context, state) {
          List<ExpenseArticle>? dataState = state.expense;

          if (state is LocalExpenseLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).cardColor,
              ),
            );
          }

          if (state is LocalExpenseDone) {
            print("YouData");

            if (dataState?.isEmpty ?? true) {
              return Center(
                child: Text(
                  "No Data",
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: dataState?.length ?? 0,
                itemBuilder: (context, index) {
                  final eachData = dataState![index];
                  final key = context.read<LocalExpenseBloc>();
                  DateTime dateTime = DateTime.parse(
                    eachData.dateTime.toString(),
                  );
                  String formattedDate = DateFormat(
                    'yyyy-MM-dd HH:mm a',
                  ).format(dateTime);
                  try {
                    print(formattedDate);
                  } catch (e) {
                    print(e);
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      background: Container(
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(Icons.edit, color: Colors.green),
                      ),
                      secondaryBackground: Container(
                        color: Colors.transparent,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete, color: Colors.red),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          key.add(RemoveExpense(eachData));
                        } else if (direction == DismissDirection.startToEnd) {
                          showDialogEditBox(eachData);
                        }
                      },
                      child: Card(
                        color: Theme.of(context).cardColor,
                        child: ExpansionTile(
                          collapsedIconColor: _getIconColor2(
                            eachData.expenseType,
                          ),
                          iconColor: _getIconColor(eachData.expenseType),
                          leading: _getIconForExpenseType(eachData.expenseType),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                eachData.name,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.fontSize,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize:
                                      Theme.of(
                                        context,
                                      ).textTheme.titleSmall?.fontSize,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            "\$ ${eachData.cost}",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.fontSize,
                            ),
                          ),
                          children: [
                            Text(
                              eachData.note,
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.fontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }

          return SizedBox();
        },
      ),
    );
  }

  Color _getIconColor2(ExpenseType expenseType) {
    switch (expenseType) {
      case ExpenseType.bill:
        return Colors.orange;
      case ExpenseType.food:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Color _getIconColor(ExpenseType expenseType) {
    switch (expenseType) {
      case ExpenseType.bill:
        return Colors.orange;
      case ExpenseType.food:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Icon _getIconForExpenseType(ExpenseType expenseType) {
    switch (expenseType) {
      case ExpenseType.bill:
        return Icon(Icons.home);
      case ExpenseType.food:
        return Icon(Icons.restaurant);
      default:
        return Icon(Icons.airport_shuttle);
    }
  }

  Row buildSecondBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Recent",
          style: TextStyle(
            color: Theme.of(context).cardColor,
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Category",
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
            ),
          ),
        ),
      ],
    );
  }

  Container buildDataShowCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //PercentageChartHere
          CircleAvatar(
            radius: 80,
            backgroundColor: Color(0xFFF4F4F4),
            child: ExpensePieChart(),
          ),
          //CardDataHere
      BlocBuilder<LocalExpenseBloc, LocalExpenseState>(builder: (BuildContext context, LocalExpenseState state) {
        List<ExpenseArticle>? allCostData = state.expense;
        double totalCostForAllTime = 0.0;
        if (allCostData != null && allCostData.isNotEmpty) {

          for (var eachCostData in allCostData) {
            totalCostForAllTime += eachCostData.cost;
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTextLabel(context, "Total Expenses"),
            buildExpenseResult(
                context, "  \$${totalCostForAllTime.toStringAsFixed(1)}"),
            buildTextLabel(context, "Last Month"),
            buildExpenseResult(context, "  \$1000"),
          ],
        );
      },
      )
        ],
      ),
    );
  }

  void showDialogOption() {
    showDialog(
      context: context,
      builder:
          (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("touched food");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => DataInputTextField(
                                lottieCategoryPath: LottieCategoryPath.food,
                                type: ExpenseType.food,
                              ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 60,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: Lottie.asset(LottieCategoryPath.food),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => DataInputTextField(
                                lottieCategoryPath:
                                    LottieCategoryPath.apartment,
                                type: ExpenseType.bill,
                              ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 60,
                      child: Lottie.asset(LottieCategoryPath.apartment),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => DataInputTextField(
                            lottieCategoryPath: LottieCategoryPath.transport,
                            type: ExpenseType.transport,
                          ),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 60,
                  child: Lottie.asset(LottieCategoryPath.transport, width: 100),
                ),
              ),
            ],
          ),
    );
  }

  //ExpenseResultHere
  Text buildExpenseResult(BuildContext context, String expense) {
    return Text(
      expense,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).scaffoldBackgroundColor,
        fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
      ),
    );
  }

  //Label
  Widget buildTextLabel(BuildContext context, String title) {
    return Container(
      width: 140,
      padding: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).cardColor,
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  //TopBar
  Row buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        cardWidget(
          iconData: Icon(
            Icons.menu,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: () {
              _scaffoldKey.currentState?.openDrawer();

          },
        ),
        cardWidget(
          iconData: Icon(
            Icons.palette,
            color:
                !showPanel
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.red,
          ),
          onPressed: () {
            setState(() {
              print(showPanel);
              showPanel = !showPanel;
            });
          },
        ),
      ],
    );
  }

  void showDialogEditBox(ExpenseArticle articleData) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _noteController = TextEditingController(
      text: articleData.note,
    );
    final TextEditingController _costController = TextEditingController(
      text: articleData.cost.toString(),
    );
    final TextEditingController _expanseNameController = TextEditingController(
      text: articleData.name,
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                filterLabel(articleData.expenseType),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextFormField(
                      Icons.description,
                      _expanseNameController,
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
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Processing")),
                  );
                  final String expenseName = _expanseNameController.text;
                  final double cost = double.parse(_costController.text);
                  final String note = _noteController.text;
                  final DateTime dateTime = DateTime.parse(
                    articleData.dateTime.toString(),
                  );
                  final ExpenseType expenseType = articleData.expenseType;

                  final ExpenseArticle expenseArticlePerData = ExpenseArticle(
                    name: expenseName,
                    cost: cost,
                    currencyName: "uk",
                    note: note,
                    expenseType: expenseType,
                    time: dateTime,
                  );
                  context.read<LocalExpenseBloc>().add(
                    EditExpense(expenseArticlePerData),
                  );
                  _noteController.clear();
                  _costController.clear();
                  _expanseNameController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text("Submit", style: TextStyle(color: Colors.black)),
            ),
          ],
        );

      },
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
