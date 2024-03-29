import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kai_mobile/core/repository/auth_repository.dart';
import 'package:kai_mobile/core/utils/constant.dart';
import 'package:kai_mobile/core/utils/custom_component.dart';
import 'package:kai_mobile/core/utils/navigator_helper.dart';
import 'package:kai_mobile/core/utils/session_manager.dart';
import 'package:kai_mobile/screens/bottom_bar.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    init();
  }
  final naviKey = GlobalKey<NavigatorState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Map userData = {};
  var pict = "";
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  init() async {
    var checkToken = await SessionManager.checkSession();
    if (checkToken) {
      await getProfile();
    }
  }

  Future register(Map<String, dynamic> requestBody) async {
    isLoading = true;
    var res = await AuthRepository.register(requestBody);
    isLoading = false;
    if (res["success"] != null && res["success"] == true) {
      SessionManager.setToken(res["token"], res["user"]["name"]);
      successSnackBar("Success register!");
      goRemove(BottomBar(0));
    } else {
      errorSnackBar("Daftar gagal!");
    }
  }

  Future login(Map<String, dynamic> requestBody) async {
    isLoading = true;
    var res = await AuthRepository.login(requestBody);
    isLoading = false;

    if (res["success"] != null && res["success"] == true) {
      SessionManager.setToken(res["token"], res["user"]["name"]);
      goRemove(BottomBar(0));
      CustomSnackBar("Sukses login!");
    } else {
      CustomSnackBar("Email atau Password salah!", false);
    }
  }

  Future? getProfile() async {
    isLoading = true;
    var res = await AuthRepository.getProfileData();
    isLoading = false;
    if (res["status"] == 400) {
      errorSnackBar("Ups something went wrong!");
    } else {
      userData = res;
    }
  }

  Future updateProfile(Map<String, dynamic> requestBody) async {
    isLoading = true;
    var res = await AuthRepository.updateProfile(requestBody);
    isLoading = false;
    if (res != null && res["success"] != null && res["success"] == true) {
      successSnackBar("Success edit profile!");
      goRemove(BottomBar(2));
    } else {
      errorSnackBar("Gagal edit profile!");
    }
  }

  Future getRandomAvatar() async {
    var res = await AuthRepository.getRandomAvtr();
    print(res);
    pict = res;
  }
}
