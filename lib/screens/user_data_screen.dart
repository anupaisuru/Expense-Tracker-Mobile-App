import 'package:flutter/material.dart';

import 'package:expense_tracker/services/user_services.dart';
import 'package:expense_tracker/screens/main_screen.dart';
import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/constants.dart';
import 'package:expense_tracker/widgets/custom_button.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  bool _rememberMe = false;
  //form key for form validation
  final _formKey = GlobalKey<FormState>();

  // controllers for the text feilds
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Your \nPersonal Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                //form
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          // check weather user enter valid user name
                          if (value!.isEmpty) {
                            return "please enter your name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 15),

                      // email
                      TextFormField(
                        controller: _userEmailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 15),

                      // password
                      TextFormField(
                        controller: _userPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter valid password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 15),

                      // confirm password
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter the same password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 30),

                      // remeber me for the next tim
                      Row(
                        children: [
                          Text(
                            "Rememeber for the next time",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kGrey,
                            ),
                          ),

                          //check box
                          Expanded(
                            child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      // next button
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // form is valid, process data
                            String userName = _userNameController.text;
                            String email = _userEmailController.text;
                            String password = _userPasswordController.text;
                            String confirmPassword =
                                _confirmPasswordController.text;

                            // save the username and email in the device database
                            await UserServices.storeUserDetails(
                              userName: userName,
                              email: email,
                              password: password,
                              confirmPassword: confirmPassword,
                              context: context,
                            );

                            //navigate to the main scrren
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MainScreen();
                                  },
                                ),
                              );
                            }
                          }
                        },
                        child: CustomButton(
                          buttonName: "Next",
                          buttonColor: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
