import 'package:expense_tracker/features/config/LottieCateogryPath/category_lottie_path.dart';
import 'package:expense_tracker/features/domain/entity/expense_article.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/local_bloc_statement/local_expense_state.dart';
import '../../bloc/local_bloc_statement/local_expnese_bloc.dart';

class ExpensePieChart extends StatefulWidget {
  @override
  _ExpensePieChartState createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final double radius = 40;

    return BlocBuilder<LocalExpenseBloc, LocalExpenseState>(
      builder: (BuildContext context, state) {
        List<ExpenseArticle>? allCostData = state.expense;
        double transportCost = 0.0;
        double bill = 0.0;
        double food = 0.0;

        if (allCostData != null && allCostData.isNotEmpty) {
          for (var eachCostData in allCostData) {
            if (eachCostData.expenseType == ExpenseType.transport) {
              transportCost += eachCostData.cost;
            } else if (eachCostData.expenseType == ExpenseType.bill) {
              bill += eachCostData.cost;
            } else if (eachCostData.expenseType == ExpenseType.food) {
              food += eachCostData.cost;
            }
          }
          double total = transportCost + bill + food;

          if (total > 0) {
            transportCost = (transportCost / total) * 100;
            bill = ((bill / total) * 100);
            food = (food / total) * 100;
          } else {
            transportCost = 0;
            bill = 0;
            food = 0;
          }

          if (kDebugMode) {
            print(
              "This is transportCost is $transportCost and Bill is $bill and Food is $food",
            );
          }
        }
        if (state.expense == null || state.expense!.isEmpty) {
          return SizedBox(
            width: 250,
            height: 250,
            child: Lottie.asset(
              "lottie/NoData/robotSayingNo.json",
              fit: BoxFit.fill,
            ),
          );
        }

        return SizedBox(
          width: 250,
          height: 250,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        response == null ||
                        response.touchedSection == null) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex =
                          response.touchedSection!.touchedSectionIndex;
                      print(touchedIndex);
                    }
                  });
                },
              ),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: List.generate(3, (i) {
                final isTouched = i == touchedIndex;
                final double showRadius = isTouched ? 50 : radius;
                final labelColor = Theme.of(context).scaffoldBackgroundColor;

                switch (i) {
                  case 0:
                    return PieChartSectionData(
                      color: Colors.blue,
                      value: transportCost,
                      title:
                          isTouched
                              ? 'Transport\n${transportCost.toStringAsFixed(0)}%'
                              : '${transportCost.toStringAsFixed(0)}%',
                      radius: showRadius,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: labelColor,
                      ),
                    );
                  case 1:
                    return PieChartSectionData(
                      color: Colors.green,
                      value: food,
                      title:
                          isTouched
                              ? 'Food\n${food.toStringAsFixed(0)}%'
                              : '${food.toStringAsFixed(0)}%',
                      radius: showRadius,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: labelColor,
                      ),
                    );
                  case 2:
                    return PieChartSectionData(
                      color: Colors.orange,
                      value: bill,
                      title:
                          isTouched
                              ? 'Bills\n${bill.toStringAsFixed(0)}%'
                              : '${bill.toStringAsFixed(0)}%',
                      radius: showRadius,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: labelColor,
                      ),
                    );
                  default:
                    return throw Error();
                }
              }),
            ),
          ),
        );
      },
    );
  }
}
