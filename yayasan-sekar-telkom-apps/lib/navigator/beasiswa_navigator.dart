import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:yayasan_sekar_telkom_apps/screen/beasiswa/detail_beasiswa_screen.dart';
import 'package:yayasan_sekar_telkom_apps/screen/login/intro_login_screen.dart';
import 'package:yayasan_sekar_telkom_apps/widget/button_fill.dart';
import 'package:yayasan_sekar_telkom_apps/widget/warning_dialog.dart';

import '../screen/beasiswa/list_card_beasiswa.dart';
import '../theme.dart';
import 'main_menu.dart';

class BeasiswaNavigator extends StatefulWidget {
  const BeasiswaNavigator({super.key});

  @override
  State<BeasiswaNavigator> createState() => _BeasiswaNavigatorState();
}

class _BeasiswaNavigatorState extends State<BeasiswaNavigator> {
  String? token;
  bool isLoading = false;
  void cekToken() async {
    setState(() {
      isLoading = true;
    });
    token = await const FlutterSecureStorage().read(key: "token");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    cekToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget listBeasiswa() {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const DetailBeasiswaScreen();
                      }));
                    },
                    child: const ListCardBeasiswa(
                      kategori: 'Beasiswa Pendidikan',
                      nominal: 'Rp. 4.800.000',
                      date: '10 Mei 2023',
                      namaKeluarga: 'Keluarga Asep Mujadi',
                      dpw: 'DPW-SEKAR JABAR-2',
                      status: 1,
                    ),
                  );
                }),
          ],
        ),
      );
    }

    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: token == null
            ? null
            : AppBar(
                backgroundColor: Colors.white,
                elevation: 0.2,
                title: Text(
                  'Beasiswa',
                  style: primaryTextStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: 100,
                      child: ButtonFillCustom(
                        () async {
                          WarningAlertDialog.showDetailNotif(
                              context,
                              Column(
                                children: [
                                  Text(
                                    'Informasi',
                                    style: primaryTextStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Apakah anda yankin akan Keluar ?',
                                    style: secondaryTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ), () async {
                            //butonYa
                            await const FlutterSecureStorage()
                                .write(key: "token", value: null);
                            await const FlutterSecureStorage()
                                .write(key: "level_user", value: null);
                            await const FlutterSecureStorage()
                                .delete(key: "name");
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const MainMenuNavigator(
                                          id: 0,
                                        )),
                                (Route<dynamic> route) => false);
                          }, () {
                            Navigator.pop(context);
                          });
                        },
                        'Keluar',
                      ),
                    ),
                  ),
                ],
                centerTitle: true,
              ),
        body: token == null ? const IntroLoginScreen() : listBeasiswa(),
      ),
    );
  }
}
