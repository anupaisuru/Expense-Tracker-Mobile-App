import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  // method for store the user name and email in shared preference
  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      // check weather the password and confirm password are the same
      if (password != confirmPassword) {
        // show a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("password and confirm password do not match")),
        );

        return;
      }

      // if the user password and confirm password are same. then store user details
      //create shared preference instance
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // store the user name and email as key value pairs
      await prefs.setString("userName", userName);
      await prefs.setString("email", email);

      // show a message to the user
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("User Details Stored Success")));
    } catch (error) {
      error.toString();
    }
  }

  //method to check weather the username is saved in the shared pref
  static Future<bool> checkUserName() async {
    //create an instance for shared prefrence
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userName = prefs.getString("userName");

    return userName != null;
  }
}
