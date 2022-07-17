import 'dart:convert';

import 'package:demo_dev/model/Model.dart';
import 'package:demo_dev/request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../HomeScreen.dart';

class MyController extends GetxController {
  var modelController = Model().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void callHomeCat(BuildContext context, String email, String password) async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    Request request = await Request(
        url: Uri.parse("https://lurgoo.talhasultan.dev/api/login"),
        body: {
          "email": email,
          "password": password
        },
        headers: {
          'Accept': 'application/json',
        });
    request.post().then((value) {
      print(json.decode(value.body));
      modelController.value = Model.fromJson(json.decode(value.body));

      GetStorage obj = new GetStorage();
      obj.write("firstName", modelController.value.user?.firstName.toString());
      obj.write("lastName", modelController.value.user?.lastName.toString());
      obj.write("email", modelController.value.user?.email);
      Get.back();
      Get.snackbar(
        'Login',
        'Successfully',
        snackPosition: SnackPosition.BOTTOM
      );
      Get.offAll(HomeScreen());
    }).catchError((onError) {
      Get.back();
      Get.snackbar(
          'Login',
          'Unsuccessfully',
          snackPosition: SnackPosition.BOTTOM
      );
      print(onError);
    });
  }
}
