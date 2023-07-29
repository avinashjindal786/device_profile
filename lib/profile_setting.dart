import 'package:device_profile/model.dart';
import 'package:device_profile/provider.dart';
import 'package:device_profile/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ProfileSetting extends StatefulWidget {
  DeviceProfile? profile;
  ProfileSetting({required this.profile});

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
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
            "Profile Setting",
            style:  TextStyle(color: Provider.of<ChangeTheme>(context, listen: true).appTextColor, fontSize: 18),
          )),
      backgroundColor: Provider.of<ChangeTheme>(context, listen: true).background,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: InkWell(
          onTap: () async {
            
            Provider.of<ChangeTheme>(context,listen: false).changeBackgroungColor(widget.profile!);
          },
          child: Container(
              height: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Provider.of<ChangeTheme>(context, listen: true).buttonColor),
              child: Center(
                child: Text("Add Default Theme", style: TextStyle(color: Provider.of<ChangeTheme>(context, listen: true).buttonTextColor, fontSize: 19, fontFamily: "Gilroy Bold")),
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
                  child: Padding(padding: const EdgeInsets.only(right: 12), child: Text(Provider.of<ChangeTheme>(context,listen: true).name
                   ?? "")),
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
                        color: Provider.of<ChangeTheme>(context, listen: true).appBarColor,
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
                        color: Provider.of<ChangeTheme>(context, listen: true).appTextColor,
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
                        color: Provider.of<ChangeTheme>(context, listen: true).background,
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
                        color: Provider.of<ChangeTheme>(context, listen: true).primaryColor,
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
                        color: Provider.of<ChangeTheme>(context, listen: true).secondry,
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
                        color: Provider.of<ChangeTheme>(context, listen: true).buttonColor,
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
                        color: Provider.of<ChangeTheme>(context, listen: true).buttonTextColor,
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
