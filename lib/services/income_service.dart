import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:expense_tracker/models/income_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //define the key for storing incomes in shared preference
  static const String _incomeKey = "income";

  // save income in sp
  Future<void> saveIncome(IncomeModel income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      List<IncomeModel> existingIncomeObjects = [];

      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => IncomeModel.fromJson(json.decode(e)))
            .toList();
      }

      // add new income to the list
      existingIncomeObjects.add(income);

      // convert the list of income objects back to a list of string
      List<String> updatedIncome = existingIncomeObjects
          .map((e) => json.encode(e.toJson()))
          .toList();

      // save the updated list of incomes in to the sp
      await prefs.setStringList(_incomeKey, updatedIncome);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Income Added Success!"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income Added Success!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // load the income from sp
  Future<List<IncomeModel>> loadIncomes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? existingIncomes = prefs.getStringList(_incomeKey);

    // convert string list in to the dart objects
    List<IncomeModel> loadedIncomes = [];

    if (existingIncomes != null) {
      loadedIncomes = existingIncomes
          .map((e) => IncomeModel.fromJson(json.decode(e)))
          .toList();
    }

    return loadedIncomes;
  }
}
