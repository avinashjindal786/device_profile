import 'dart:developer';

import 'package:device_profile/model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangeTheme extends ChangeNotifier {
  Color _background = Colors.white;
  Color get background => _background;

  Color _appBarColor = Color(0xFF222539);
  Color get appBarColor => _appBarColor;

  Color _appTextColor = Colors.white;
  Color get appTextColor => _appTextColor;

  Color _primaryColor = Color(0xFF222539);
  Color get primaryColor => _primaryColor;

  Color _secondry = Colors.white;
  Color get secondry => _secondry;

  Color _buttonColor = Color(0xFF222539);
  Color get buttonColor => _buttonColor;

  Color _buttonTextColor = Colors.white;
  Color get buttonTextColor => _buttonTextColor;

  int _pTS = 12;
  int get pTs => _pTS;

  int _sTS = 10;
  int get sTs => _sTS;

  int _defaultProfile = 0;
  int get defaultProfile => _defaultProfile;

  String _name = "Default";
  String get name => _name;

  changeBackgroungColor(DeviceProfile profile) {
    _background = HexColor(profile.backgroundColor!);
    _appBarColor = HexColor(profile.appBarColor!);
    _appTextColor = HexColor(profile.appTextColor!);
    _primaryColor = HexColor(profile.primaryColor!);
    _secondry = HexColor(profile.secondryColor!);
    _buttonColor = HexColor(profile.buttonColor!);
    _buttonTextColor = HexColor(profile.buttonTextColor!);
    _pTS = int.parse(profile.primaryText!);
    _sTS = int.parse(profile.secondryText!);
    _name = profile.name!;
    _defaultProfile = profile.defultProfile!;
    notifyListeners();
  }


}
