import 'package:expense_tracker/features/config/LottieCateogryPath/category_lottie_path.dart';
import 'package:expense_tracker/features/presentation/bloc/color_state_mangaement/color_bloc.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'package:expense_tracker/features/presentation/pages/dataInputArea/data_input_text_field.dart';
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

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool showPanel = false;
  final GlobalKey<DraggableButtonPanelState> _draggableButtonPanelKey =
      GlobalKey<DraggableButtonPanelState>();

  // Show the draggable button by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            if (dataState!.isEmpty) {
              return Center(
                child: Text(
                  "No Data",
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: dataState.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      iconColor: Colors.lightBlue,
                      // iconColor: ExpenseType.bill ? Colors.orange  : ExpenseType.food ? Colors.green : ExpenseType.transport ?  Colors.blue,
                      leading: Icon(Icons.airport_shuttle),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Food",
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleMedium!.fontSize,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "12/3/2025",
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.fontSize,
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        "\$4",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
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
            backgroundColor: Colors.white,
            child: ExpensePieChart(),
          ),
          //CardDataHere
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTextLabel(context, "Total Expenses"),
              buildExpenseResult(context, "  \$1000"),
              buildTextLabel(context, "Last Month"),
              buildExpenseResult(context, "  \$1000"),
            ],
          ),
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
                    onTap: (){
                    


                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      radius: 60,
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Lottie.asset(LottieCategoryPath.food),
                      )),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
               

                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      radius: 60,
                      child: Lottie.asset(LottieCategoryPath.apartment),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DataInputTextField(lottieCategoryPath: LottieCategoryPath.transport,)));
                },
                child: CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    radius: 60,
                    child:Lottie.asset(LottieCategoryPath.transport)
                ),
              ),
            ],
          )
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
          onPressed: () {},
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
}
