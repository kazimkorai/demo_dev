import 'package:demo_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetStorage getStorage = new GetStorage();




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(toolbarHeight: 0,),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(getStorage.read("firstName")),
              Text(getStorage.read("lastName")),
              Text(getStorage.read("email")),
              SizedBox(
                width: double.infinity, // <-- match_parent
                child: Padding(
                  padding: const EdgeInsets.only(left: 34, right: 34, top: 8),
                  child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.clear();
                        GetStorage obj = new GetStorage();
                        obj.erase();
                        Get.back();
                        Get.to(MyApp());
                      },
                      child: Text("LogOut"),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                                  (states) => null),
                          backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Color(0xFF21899C)),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Colors.transparent))))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
