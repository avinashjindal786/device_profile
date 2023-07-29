import 'dart:developer';

import 'package:device_profile/home_screen.dart';
import 'package:device_profile/model.dart';
import 'package:device_profile/provider.dart';
import 'package:device_profile/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

class AddProfileScreen extends StatefulWidget {
  String lat;
  String lng;
  AddProfileScreen({required this.lat, required this.lng});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController appBarColor = TextEditingController();
  TextEditingController appTextColor = TextEditingController();
  TextEditingController bColor = TextEditingController();
  TextEditingController pColor = TextEditingController();
  TextEditingController sColor = TextEditingController();
  TextEditingController buttonColor = TextEditingController();
  TextEditingController buttonTextColor = TextEditingController();
  TextEditingController pTS = TextEditingController();
  TextEditingController sTS = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatebaseProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: Provider.of<ChangeTheme>(context, listen: true).appBarColor,
          leading: BackButton(color: Provider.of<ChangeTheme>(context, listen: true).appTextColor),
          centerTitle: true,
          title: Text(
            "Add Device Profile",
            style: TextStyle(color: Provider.of<ChangeTheme>(context, listen: true).appTextColor, fontSize: 18),
          )),
      backgroundColor: Provider.of<ChangeTheme>(context, listen: true).background,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: InkWell(
          onTap: () async {
            if (name.text != "" && appBarColor.text != "" && appTextColor.text != "" && pColor.text != "" && sColor.text != "" && buttonColor.text != "" && buttonTextColor.text != "" && pTS.text != "" && pTS.text != "") {
              Dialogs.materialDialog(msgAlign: TextAlign.center, msg: 'As a default device profile, do you want?', title: "Create New Device Profile", color: Colors.white, context: context, actions: [
                IconsOutlineButton(
                  onPressed: () {
                    DeviceProfile data = DeviceProfile(name: name.text, lat: widget.lat, long: widget.lng, appBarColor: appBarColor.text, appTextColor: appTextColor.text, backgroundColor: bColor.text, primaryColor: pColor.text, secondryColor: sColor.text, buttonColor: buttonColor.text, buttonTextColor: buttonTextColor.text, primaryText: pTS.text, secondryText: sTS.text, defultProfile: 0);
                    provider.addData(data);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  text: 'No',
                  iconData: Icons.cancel_outlined,
                  textStyle: const TextStyle(color: Colors.grey),
                  iconColor: Colors.grey,
                ),
                IconsButton(
                  onPressed: () {
                    DeviceProfile data = DeviceProfile(name: name.text, lat: widget.lat, long: widget.lng, appBarColor: appBarColor.text, appTextColor: appTextColor.text, backgroundColor: bColor.text, primaryColor: pColor.text, secondryColor: sColor.text, buttonColor: buttonColor.text, buttonTextColor: buttonTextColor.text, primaryText: pTS.text, secondryText: sTS.text, defultProfile: 1);
                    provider.addData(data);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  text: 'Yes',
                  iconData: Icons.create,
                  color: const Color(0xFF222539),
                  textStyle: const TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ]);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please Enter All Value"),
              ));
            }
          },
          child: Container(
              height: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Provider.of<ChangeTheme>(context, listen: true).buttonColor),
              child: Center(
                child: Text("Add Profile", style: TextStyle(color: Provider.of<ChangeTheme>(context, listen: true).buttonTextColor, fontSize: 19, fontFamily: "Gilroy Bold")),
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("Enter Device Name :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      maxLines: 1,
                      controller: name,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("App Bar Color :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                colorPicker(const Color(0xFF222539), (p0) {
                                  setState(() {
                                    appBarColor.text = p0.value.toRadixString(16);
                                  });
                                });
                              },
                              child: Icon(
                                Icons.color_lens,
                                color: appBarColor.text == "" ? Colors.black : HexColor(appBarColor.text),
                              )),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      maxLines: 1,
                      controller: appBarColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("App Text Color :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                colorPicker(const Color(0xFF222539), (p0) {
                                  setState(() {
                                    appTextColor.text = p0.value.toRadixString(16);
                                  });
                                });
                              },
                              child: Icon(
                                Icons.color_lens,
                                color: appTextColor.text == "" ? Colors.black : HexColor(appTextColor.text),
                              )),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      controller: appTextColor,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("Background Color :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                colorPicker(const Color(0xFF222539), (p0) {
                                  setState(() {
                                    bColor.text = p0.value.toRadixString(16);
                                  });
                                });
                              },
                              child: Icon(
                                Icons.color_lens,
                                color: bColor.text == "" ? Colors.black : HexColor(bColor.text),
                              )),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      controller: bColor,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("Primary Color :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                colorPicker(const Color(0xFF222539), (p0) {
                                  setState(() {
                                    pColor.text = p0.value.toRadixString(16);
                                  });
                                });
                              },
                              child: Icon(
                                Icons.color_lens,
                                color: pColor.text == "" ? Colors.black : HexColor(pColor.text),
                              )),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      controller: pColor,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("Secondry Color :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                colorPicker(const Color(0xFF222539), (p0) {
                                  setState(() {
                                    sColor.text = p0.value.toRadixString(16);
                                  });
                                });
                              },
                              child: Icon(
                                Icons.color_lens,
                                color: sColor.text == "" ? Colors.black : HexColor(sColor.text),
                              )),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      controller: sColor,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("Button Color :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                colorPicker(const Color(0xFF222539), (p0) {
                                  setState(() {
                                    buttonColor.text = p0.value.toRadixString(16);
                                  });
                                });
                              },
                              child: Icon(
                                Icons.color_lens,
                                color: buttonColor.text == "" ? Colors.black : HexColor(buttonColor.text),
                              )),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      controller: buttonColor,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("Button Text Color :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                colorPicker(const Color(0xFF222539), (p0) {
                                  setState(() {
                                    buttonTextColor.text = p0.value.toRadixString(16);
                                  });
                                });
                              },
                              child: Icon(
                                Icons.color_lens,
                                color: buttonTextColor.text == "" ? Colors.black : HexColor(buttonTextColor.text),
                              )),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      controller: buttonTextColor,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("Primary Text Size :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      controller: pTS,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.4, child: const Text("Secondry Text Size :", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Color(0xFF222539)))),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF222539)),
                          ),
                          hintText: ''),
                      controller: sTS,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    ));
  }

  colorPicker(Color colors, Function(Color) changeColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: colors,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
