// To parse this JSON data, do
//
//     final deviceProfile = deviceProfileFromMap(jsonString);

import 'dart:convert';

DeviceProfile deviceProfileFromMap(String str) => DeviceProfile.fromMap(json.decode(str));

String deviceProfileToMap(DeviceProfile data) => json.encode(data.toMap());

class DeviceProfile {
  String? name;
  String? lat;
  String? long;
  String? appBarColor;
  String? appTextColor;
  String? backgroundColor;
  String? primaryColor;
  String? secondryColor;
  String? buttonColor;
  String? buttonTextColor;
  String? primaryText;
  String? secondryText;
  int? defultProfile;

  DeviceProfile({
    this.name,
    this.lat,
    this.long,
    this.appBarColor,
    this.appTextColor,
    this.backgroundColor,
    this.primaryColor,
    this.secondryColor,
    this.buttonColor,
    this.buttonTextColor,
    this.primaryText,
    this.secondryText,
    this.defultProfile

  });

  factory DeviceProfile.fromMap(Map<String, dynamic> json) => DeviceProfile(
        name: json["name"],
        lat: json["lat"],
        long: json["long"],
        appBarColor: json["appBarColor"],
        appTextColor: json["appTextColor"],
        backgroundColor: json["backgroundColor"],
        primaryColor: json["primaryColor"],
        secondryColor: json["secondryColor"],
        buttonColor: json["buttonColor"],
        buttonTextColor: json["buttonTextColor"],
        primaryText: json["primaryText"],
        secondryText: json["secondryText"],
        defultProfile: json["defultProfile"]
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "lat": lat,
        "long": long,
        "appBarColor": appBarColor,
        "appTextColor": appTextColor,
        "backgroundColor": backgroundColor,
        "primaryColor": primaryColor,
        "secondryColor": secondryColor,
        "buttonColor": buttonColor,
        "buttonTextColor": buttonTextColor,
        "primaryText": primaryText,
        "secondryText": secondryText,
        "defultProfile" : defultProfile,
      };
}
