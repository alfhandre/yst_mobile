import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/main_menu.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';

class DpwOnly extends StatelessWidget {
  const DpwOnly({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/yst_logo.png',
              width: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Column(
              children: [
                Text(
                  'Menu Beasiswa hanya bisa di akses oleh DPP, DPW dan YST',
                  style: hintTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                    onPressed: () async {
                      await const FlutterSecureStorage()
                          .write(key: "token", value: null);
                      await const FlutterSecureStorage()
                          .write(key: "level_user", value: null);
                      await const FlutterSecureStorage()
                          .write(key: "name", value: null);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MainMenuNavigator(
                                    id: 0,
                                  )),
                          (Route<dynamic> route) => false);
                    },
                    child: Text(
                      'Keluar',
                      style: hintTextStyle.copyWith(
                        fontSize: 16,
                        color: MyColor.red(),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ))
              ],
            )),
          ],
        ),
      ),
    );
  }
}

// await const FlutterSecureStorage()
//                                         .write(key: "token", value: null);
//                                     await const FlutterSecureStorage()
//                                         .write(key: "level_user", value: null);
//                                     await const FlutterSecureStorage()
//                                         .write(key: "name", value: null);
//                                     Navigator.pushAndRemoveUntil(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 const MainMenuNavigator(
//                                                   id: 0,
//                                                 )),
//                                         (Route<dynamic> route) => false);