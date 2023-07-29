import 'dart:developer';

import 'package:device_profile/add_profile.dart';
import 'package:device_profile/model.dart';
import 'package:device_profile/profile_setting.dart';
import 'package:device_profile/provider.dart';
import 'package:device_profile/show_profile.dart';
import 'package:device_profile/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController lat = TextEditingController();
  TextEditingController lng = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late Future profileList;

  Future _getDate() async {
    final provider = Provider.of<DatebaseProvider>(context, listen: false);
    return await provider.fetchData();
  }

  @override
  void initState() {
    super.initState();
    profileList = _getDate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        isLoading: isLoading,
        child: Scaffold(
          backgroundColor: Provider.of<ChangeTheme>(context, listen: true).background,
            appBar: PreferredSize(
              preferredSize: Size(MediaQuery.sizeOf(context).width, 60),
              child: _buildToolBar(),
            ),
            body: FutureBuilder(
              future: profileList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    return Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                          child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Latitude", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Provider.of<ChangeTheme>(context, listen: true).primaryColor)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          errorBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Provider.of<ChangeTheme>(context, listen: true).primaryColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Provider.of<ChangeTheme>(context, listen: true).primaryColor),
                                          ),
                                          hintText: ''),
                                      maxLines: 1,
                                      controller: lat,
                                      validator: (v) {
                                        if (!v!.isValidLat) {
                                          return "Please enter correct latitude";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text("Longitude", style: TextStyle(fontSize: 18, fontFamily: "Gilroy Medium", color: Provider.of<ChangeTheme>(context, listen: true).primaryColor)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: TextFormField(
                                      decoration:  InputDecoration(
                                          errorBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Provider.of<ChangeTheme>(context, listen: true).primaryColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Provider.of<ChangeTheme>(context, listen: true).primaryColor),
                                          ),
                                          hintText: ''),
                                      maxLines: 1,
                                      controller: lng,
                                      validator: (v) {
                                        if (!v!.isValidLong) {
                                          return "Please enter correct longitude";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  final value = await Provider.of<DatebaseProvider>(context, listen: false).getProfile(lat.text, lng.text);

                                  if (value) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Already Used this Latitude and Longitude"),
                                    ));
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    Dialogs.materialDialog(msgAlign: TextAlign.center, msg: 'There is no profile in this location. kindly create a new profile....', title: "Create New Device Profile", color: Colors.white, context: context, actions: [
                                      IconsOutlineButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'Cancel',
                                        iconData: Icons.cancel_outlined,
                                        textStyle: const TextStyle(color: Colors.grey),
                                        iconColor: Colors.grey,
                                      ),
                                      IconsButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AddProfileScreen(
                                                        lat: lat.text,
                                                        lng: lng.text,
                                                      )));
                                        },
                                        text: 'Create',
                                        iconData: Icons.create,
                                        color: const Color(0xFF222539),
                                        textStyle: const TextStyle(color: Colors.white),
                                        iconColor: Colors.white,
                                      ),
                                    ]);
                                  }
                                }
                              },
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Provider.of<ChangeTheme>(context, listen: true).buttonColor),
                                  child: Center(
                                    child: Text("Find Device Profile", style: TextStyle(color: Provider.of<ChangeTheme>(context, listen: true).buttonTextColor, fontSize: 19, fontFamily: "Gilroy Bold")),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(text: "Device Profile List ", style: TextStyle(color: Provider.of<ChangeTheme>(context, listen: true).primaryColor, fontSize: 14)),
                                  ])),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Consumer<DatebaseProvider>(builder: (_, db, __) {
                            var lst = db.profileList;
                            return lst.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 44),
                                    child: Text(
                                      "No Data",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                                    ),
                                  )
                                : ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: lst.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        color: Provider.of<ChangeTheme>(context, listen: true).secondry,
                                        child: ListTile(
                                            title: Text(lst[index].name ?? ""),
                                            subtitle: Text("${lst[index].lat},${lst[index].long}"),
                                            trailing: InkWell(
                                              onTap: () {
                                                // showCustomSnackbar(msg: "Coming Soon", title: "Features");
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowProfileScreen(profile: lst[index])));
                                              },
                                              child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Provider.of<ChangeTheme>(context, listen: true).primaryColor,
                                                child: const Icon(
                                                  Icons.arrow_right,
                                                  size: 28,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                      );
                                    });
                          }),
                        ],
                      ))
                    ]);
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )),
      ),
    );
  }

  Widget _buildToolBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Provider.of<ChangeTheme>(context, listen: true).appBarColor,
      height: 100,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              _buildAvatar(),
              _buildNames(),
              _buildActions(),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  _buildActions() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                DeviceProfile defaultData = DeviceProfile(name: "Default Profile", lat: "", long: "", appBarColor: "FF222539", appTextColor: "ffffff", backgroundColor: "ffffff", primaryColor: "FF222539", secondryColor: "ffffff", buttonColor: "FF222539", buttonTextColor: "ffffff", primaryText: "12", secondryText: "10",defultProfile: 0);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetting(profile: defaultData)));
              },
              child: Icon(
                Icons.settings,
                color: Provider.of<ChangeTheme>(context, listen: true).appTextColor,
                size: 35,
              )),
        ],
      ),
    );
  }

  _buildNames() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Avinash',
            style: TextStyle(color: Provider.of<ChangeTheme>(context, listen: true).appTextColor, fontSize: 20),
          ),
        ],
      ),
    );
  }

  _buildAvatar() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Icon(
          Icons.menu,
          color: Provider.of<ChangeTheme>(context, listen: true).appTextColor,
          size: 35,
        ));
  }
}

// ignore: camel_case_extensions
extension extString on String {
  bool get isValidLat {
    final emailRegExp = RegExp(r"^(\+|-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,6})?))$");

    return emailRegExp.hasMatch(this);
  }

  bool get isValidLong {
    final emailRegExp = RegExp(r"^(\+|-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,6})?))$");

    return emailRegExp.hasMatch(this);
  }
}
