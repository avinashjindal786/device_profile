import 'dart:developer';

import 'package:device_profile/model.dart';
import 'package:device_profile/provider.dart';
import 'package:device_profile/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ShowProfileScreen extends StatefulWidget {
  DeviceProfile? profile;
  ShowProfileScreen({required this.profile});

  @override
  State<ShowProfileScreen> createState() => _ShowProfileScreenState();
}

class _ShowProfileScreenState extends State<ShowProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatebaseProvider>(context, listen: false);
    final changeProvider = Provider.of<ChangeTheme>(context, listen: false);

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: Provider.of<ChangeTheme>(context, listen: true).appBarColor,
          leading: BackButton(color: Provider.of<ChangeTheme>(context, listen: true).appTextColor),
          centerTitle: true,
          title: Text(
            widget.profile?.name ?? "",
            style: TextStyle(color: Provider.of<ChangeTheme>(context, listen: true).appTextColor, fontSize: 18),
          )),
      backgroundColor: Provider.of<ChangeTheme>(context, listen: true).background,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: InkWell(
          onTap: () async {
            log("message");
            changeProvider.changeBackgroungColor(widget.profile!);
          },
          child: Container(
              height: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Provider.of<ChangeTheme>(context, listen: true).buttonColor),
              child: Center(
                child: Text( "Set Default Device Profile", style: TextStyle(color: Provider.of<ChangeTheme>(context, listen: true).buttonTextColor, fontSize: 19, fontFamily: "Gilroy Bold")),
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
                  child: Padding(padding: const EdgeInsets.only(right: 12), child: Text(widget.profile?.name ?? "")),
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
                      child: Container(
                        width: 30,
                        height: 30,
                        color: HexColor(widget.profile!.appBarColor!),
                      )),
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
                      child: Container(
                        width: 30,
                        height: 30,
                        color: HexColor(widget.profile!.appTextColor!),
                      )),
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
                      child: Container(
                        width: 30,
                        height: 30,
                        color: HexColor(widget.profile!.backgroundColor!),
                      )),
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
                      child: Container(
                        width: 30,
                        height: 30,
                        color: HexColor(widget.profile!.primaryColor!),
                      )),
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
                      child: Container(
                        width: 30,
                        height: 30,
                        color: HexColor(widget.profile!.secondryColor!),
                      )),
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
                      child: Container(
                        width: 30,
                        height: 30,
                        color: HexColor(widget.profile!.buttonColor!),
                      )),
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
                      child: Container(
                        width: 30,
                        height: 30,
                        color: HexColor(widget.profile!.buttonTextColor!),
                      )),
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
                  child: Padding(padding: const EdgeInsets.only(right: 12), child: Text(widget.profile?.primaryText ?? "")),
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
                  child: Padding(padding: const EdgeInsets.only(right: 12), child: Text(widget.profile?.secondryText ?? "")),
                ),
              ],
            )
          ]),
        ),
      ),
    ));
  }
}
