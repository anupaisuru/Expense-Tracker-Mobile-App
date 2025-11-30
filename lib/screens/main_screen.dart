import 'package:flutter/material.dart';

import 'package:expense_tracker/models/income_model.dart';
import 'package:expense_tracker/services/income_service.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/screens/add_new_screen.dart';
import 'package:expense_tracker/screens/budget_screen.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/profile_screen.dart';
import 'package:expense_tracker/screens/transaction_screen.dart';
import 'package:expense_tracker/services/expense_service.dart';
import 'package:expense_tracker/constants/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  List<ExpenseModel> expenseList = [];
  List<IncomeModel> incomeList = [];

  // method for fetch expenses
  void fetchExpenses() async {
    List<ExpenseModel> loadedExpenses = await ExpenseService().loadExpense();
    setState(() {
      expenseList = loadedExpenses;
      print(expenseList.length);
    });
  }

  // method to fetch incomes
  void fetchIncomes() async {
    List<IncomeModel> loadedIncomes = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
      print(incomeList.length);
    });
  }

  // add new expense
  void addNewExpense(ExpenseModel newExpense) {
    ExpenseService().saveExpense(newExpense, context);
    // update the list of expense
    setState(() {
      expenseList.add(newExpense);
      print(incomeList.length);
    });
  }

  //add new income
  void addNewIncome(IncomeModel newIncome) {
    IncomeService().saveIncome(newIncome, context);

    // update the incomelist
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchExpenses();
      fetchIncomes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(),
      TransactionScreen(),
      AddNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      BudgetScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: kWhite, size: 30),
            ),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.rocket), label: "Budget"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
