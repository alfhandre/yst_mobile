import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/main_menu.dart';
import 'package:yayasan_sekar_telkom_apps/screen/login/intro_login_screen.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';
import 'package:yayasan_sekar_telkom_apps/widget/warning_dialog.dart';

class ProfileNavigator extends StatefulWidget {
  const ProfileNavigator({super.key});

  @override
  State<ProfileNavigator> createState() => _ProfileNavigatorState();
}

class _ProfileNavigatorState extends State<ProfileNavigator> {
  bool isLoading = false;
  String? token, email, name;

  void checkAccount() async {
    setState(() {
      isLoading = true;
    });
    token = await FlutterSecureStorage().read(key: 'token');
    email = await FlutterSecureStorage().read(key: 'email');
    name = await FlutterSecureStorage().read(key: 'name');
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: token != null
            ? SafeArea(
                child: Column(children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/dumy_banner.png',
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                    Container(
                        height: 170,
                        // width: MediaQuery.of(context).size.width,
                        color: Color(0xFF263238).withOpacity(0.85)),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 40),
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.5, color: Color(0xFFBBBBBB)),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 1),
                              blurRadius: 3.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 28, right: 28, top: 20, bottom: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 74,
                                    width: 74,
                                    decoration: BoxDecoration(
                                        color: Color(0xffD9D9D9),
                                        borderRadius:
                                            BorderRadius.circular(37)),
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Color(0xFFB1B1B1),
                                        size: 54,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      NunitoSans.custom(
                                          text: name,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: MyColor.red()),
                                      NunitoSans.custom(
                                          text: email,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: MyColor.cardTitle())
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Divider(color: MyColor.greyDivider()),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    height: 35,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: MyColor.red(),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        WarningAlertDialog.showDetailNotif(
                                          context,
                                          Column(
                                            children: [
                                              Text(
                                                'Informasi',
                                                style:
                                                    primaryTextStyle.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                child: Text(
                                                  'Apakah anda yakin akan logout ?',
                                                  style: secondaryTextStyle,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          () async {
                                            // Proses logout
                                            await const FlutterSecureStorage()
                                                .write(
                                                    key: "token", value: null);
                                            await const FlutterSecureStorage()
                                                .write(
                                                    key: "level_user",
                                                    value: null);
                                            await const FlutterSecureStorage()
                                                .write(
                                                    key: "name", value: null);
                                            await const FlutterSecureStorage()
                                                .write(
                                                    key: "email", value: null);
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const MainMenuNavigator(
                                                            id: 0),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
                                          },
                                          () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      child: Center(
                                        child: NunitoSans.custom(
                                          text: 'Logout >',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]))
            : IntroLoginScreen());
  }
}


// Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/yst_logo.png',
//                     width: 150,
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     'Anda Perlu Login',
//                     style: hintTextStyle.copyWith(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),