import 'dart:convert';

import 'package:bala_task/data/response_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../data/chopper_client.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  ApiResponseModel? model;
  final searchController = TextEditingController();
  var selectedIndex = -1.obs;
  RxInt selectedTagIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchStackData() async {
    if (searchController.text.isEmpty) {
      Get.snackbar('Error alert', 'please enter some keys',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      try {
        showLoading(true);
        selectedTagIndex.value=-1;
        selectedIndex=-1;
        // searchController.text = 'flutter';
        final myClient = Get.find<AppChopperClient>();
        final response = await myClient
            .getChopperService()
            .getStackList(searchController.text, "stackoverflow");
        if (response.isSuccessful) {
          var encodedString = jsonEncode(response.body);
          print(encodedString);
          Map<String, dynamic> valueMap = json.decode(encodedString);
          model = ApiResponseModel.fromJson(valueMap);
        } else {
          final loginError = response.error;
        }
        
        showLoading(false);
      } catch (e) {
        print(e);
        showLoading(false);
      }
      update();
    }
  }

  showLoading(value) {
    isLoading = value;
    update();
  }

  updateTagDetails(tagindex, tagname) {
    selectedTagIndex.value = tagindex;
    searchController.text = tagname;
    fetchStackData();
    update();
  }
}
