import 'package:flutter/material.dart';

import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/services/user_services.dart';
import 'package:expense_tracker/widgets/income_expense_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // for store the user name
  String username = "";

  @override
  void initState() {
    // get the user name from the shared preferences
    UserServices.getUserData().then((value) {
      if (value["userName"] != null) {
        setState(() {
          username = value["userName"]!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //main col
          child: Column(
            children: [
              // bg color col
              Container(
                height: MediaQuery.of(context).size.height * 0.34,
                decoration: BoxDecoration(
                  color: kMainColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kMainColor,
                              border: Border.all(color: kMainColor, width: 3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Welcome $username",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenseCard(
                            title: "Income",
                            amount: 25.43,
                            imgUrl: "assets/images/income.png",
                            bgColor: kGreen,
                          ),
                          IncomeExpenseCard(
                            title: "Expense",
                            amount: 2543.43,
                            imgUrl: "assets/images/expense.png",
                            bgColor: kRed,
                          ),
                        ],
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
}
