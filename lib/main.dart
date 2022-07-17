import 'dart:convert';

import 'package:demo_dev/HomeScreen.dart';
import 'package:demo_dev/controller/MyController.dart';
import 'package:demo_dev/model/Model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;

  runApp(GetMaterialApp(home: status == true ? HomeScreen() : MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isValidate(String email, String pass) {
  bool isValid = true;
  if (email.isEmpty) {
    Get.snackbar('', 'Email required', snackPosition: SnackPosition.BOTTOM);
    return false;
  }
  if (pass.isEmpty) {
    Get.snackbar('', 'Password required', snackPosition: SnackPosition.BOTTOM);
    return false;
  }
  return isValid;
}

class _MyAppState extends State<MyApp> {
  bool _value = false;
  bool ischeckBox = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF21899C),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF21899C)),
                        borderRadius: BorderRadius.circular(55),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.asset(
                              "assets/img/img.png",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: Color(0xFF21899C), fontSize: 20),
                                ),
                                Text(
                                  "PAGE",
                                  style: TextStyle(
                                      color: Color(0xFFFE9879), fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                                controller: emailController,
                                onChanged: (value) {
                                  setState(() {
                                    ischeckBox = isEmail(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    size: 18,
                                    color: Color(0xFF2CB9B0),
                                  ),
                                  suffixIcon: ischeckBox
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF0FF2CB9B0),
                                        )
                                      : Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                        ),
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(5.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFF2CB9B0),
                                      width: 1,
                                    ),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 2, bottom: 15),
                            child: TextField(
                                obscureText: true,
                                controller: passController,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    size: 18,
                                    color: Color(0xFFB8B8BE),
                                  ),
                                  fillColor: Color(0xFFF8F7FB),
                                  labelStyle:
                                      TextStyle(color: Color(0xFFB8B8BE)),
                                  contentPadding: EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                )),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _value = !_value;
                                          });
                                        },
                                        child: Container(
                                          height: 24,
                                          width: 24,
                                          margin: EdgeInsets.only(left: 20),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Color(0xFF21899C)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: _value
                                                ? Icon(
                                                    Icons.check,
                                                    size: 15.0,
                                                    color: Colors.white,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .check_box_outline_blank,
                                                    size: 15.0,
                                                    color: Colors.blue,
                                                  ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text("Remember me"),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: double.infinity, // <-- match_parent
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 34, right: 34, top: 8),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_value) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool("isLoggedIn", _value);
                                    }

                                    if (isValidate(emailController.text,
                                        passController.text)) {
                                      var controller = Get.put(MyController());
                                      controller.callHomeCat(
                                          context,
                                          emailController.text,
                                          passController.text);
                                    }
                                  },
                                  child: Text("Signin"),
                                  style: ButtonStyle(

                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Color(0xFF21899C)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color:
                                                      Colors.transparent))))),
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/img/fb.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/img/google.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/img/apple.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do you have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        " Sign Up here",
                        style: TextStyle(
                            color: Color(
                              0xFFF56B3F,
                            ),
                            fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
  }
}
