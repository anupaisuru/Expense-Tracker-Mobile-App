import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  // expense list
  List<ExpenseModel> expenseList = [];

  // define the key for storing expenses in shared preferense
  static const String _expenseKey = "expenses";

  Future<void> saveExpense(ExpenseModel expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      // convert the existing expenses to a list of expenses objects
      List<ExpenseModel> existingExpenseObjects = [];

      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => ExpenseModel.fromJson(json.decode(e)))
            .toList();
      }

      // add the new expense to the list
      existingExpenseObjects.add(expense);

      // convert the list of expenses objects back to a list of string
      List<String> updatedExpenses = existingExpenseObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      // save the updated list of expenses to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show snackbar message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense added successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense added error"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // load the expenses from shared preferences
  Future<List<ExpenseModel>> loadExpense() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String>? existingExpenses = pref.getStringList(_expenseKey);

    // convert the existing expenses to a list of expense object
    List<ExpenseModel> loadedExpenses = [];

    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => ExpenseModel.fromJson(json.decode(e)))
          .toList();
    }

    return loadedExpenses;
  }
}
