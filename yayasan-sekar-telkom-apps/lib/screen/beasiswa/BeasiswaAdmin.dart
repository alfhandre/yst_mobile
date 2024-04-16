import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/main_menu.dart';
import 'package:yayasan_sekar_telkom_apps/screen/login/login_screen.dart';
import 'package:yayasan_sekar_telkom_apps/screen/login/notification_dwp_only.dart';
import 'package:yayasan_sekar_telkom_apps/service/beasiswa_admin_service.dart';
import 'package:yayasan_sekar_telkom_apps/widget/CardBeasiswa.dart';
import 'package:yayasan_sekar_telkom_apps/widget/StatusBeasiswa.dart';
import 'package:yayasan_sekar_telkom_apps/screen/beasiswa/DetailBeasiswaAdmin.dart';
import 'package:yayasan_sekar_telkom_apps/model/beasiswa_admin_model.dart';
import 'package:yayasan_sekar_telkom_apps/screen/login/intro_login_screen.dart';
import 'package:yayasan_sekar_telkom_apps/widget/button_fill.dart';
import 'package:yayasan_sekar_telkom_apps/widget/warning_dialog.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';

class BeasiswaAdmin extends StatefulWidget {
  const BeasiswaAdmin({Key? key}) : super(key: key);

  @override
  State<BeasiswaAdmin> createState() => _BeasiswaAdminState();
}

class _BeasiswaAdminState extends State<BeasiswaAdmin> {
  late Future<List<BeasiswaAdminModel>> futureBeasiswa;
  final BeasiswaAdminService beasiswaAdminService = BeasiswaAdminService();
  late List<BeasiswaAdminModel> dataBeasiswa = [];
  String? token;
  String? level_user;
  bool isLoading = false;
  void cekToken() async {
    setState(() {
      isLoading = true;
    });
    level_user = await const FlutterSecureStorage().read(key: 'level_user');
    token = await const FlutterSecureStorage().read(key: "token");
    setState(() {
      isLoading = false;
    });
  }

  String formatCurrency(int amount) {
    String formattedAmount = amount.toString();
    final int len = formattedAmount.length;

    if (len <= 3) {
      return 'Rp. $formattedAmount';
    }

    String result = '';
    int counter = 0;

    for (int i = len - 1; i >= 0; i--) {
      result = formattedAmount[i] + result;
      counter++;

      if (counter == 3 && i != 0) {
        result = '.' + result;
        counter = 0;
      }
    }

    return 'Rp. ' + result;
  }

  @override
  void initState() {
    super.initState();
    cekToken();
    futureBeasiswa = BeasiswaAdminService().getBeasiswaAdmin();
    futureBeasiswa.then((list) => dataBeasiswa = list);
  }

  @override
  Widget build(BuildContext context) {
    Widget Konten(BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 13, right: 20, left: 20, bottom: 4),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Ink(
              //         height: 35,
              //         width: 152,
              //         decoration: BoxDecoration(
              //           border: Border.all(width: 1, color: MyColor.red()),
              //           borderRadius: BorderRadius.circular(6),
              //           color: Colors.white,
              //         ),
              //         child: InkWell(
              //           onTap: () {
              //             // Lakukan proses logout di sini
              //             WarningAlertDialog.showDetailNotif(
              //               context,
              //               Column(
              //                 children: [
              //                   Text(
              //                     'Informasi',
              //                     style: primaryTextStyle.copyWith(
              //                       fontWeight: FontWeight.w600,
              //                       fontSize: 18,
              //                     ),
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text(
              //                     'Apakah anda yakin akan Keluar ?',
              //                     style: secondaryTextStyle,
              //                     textAlign: TextAlign.center,
              //                   ),
              //                 ],
              //               ),
              //               () async {
              //                 // Proses logout
              //                 await const FlutterSecureStorage()
              //                     .write(key: "token", value: null);
              //                 await const FlutterSecureStorage()
              //                     .write(key: "level_user", value: null);
              //                 await const FlutterSecureStorage()
              //                     .write(key: "name", value: null);
              //                 // Navigasi ke halaman login
              //                 Navigator.pushAndRemoveUntil(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (BuildContext context) =>
              //                         const MainMenuNavigator(id: 0),
              //                   ),
              //                   (Route<dynamic> route) => false,
              //                 );
              //               },
              //               () {
              //                 Navigator.pop(context);
              //               },
              //             );
              //           },
              //           child: Center(
              //             child: NunitoSans.custom(
              //               text: 'Tambah Beasiswa +',
              //               fontSize: 14,
              //               fontWeight: FontWeight.w600,
              //               color: MyColor.red(),
              //             ),
              //           ),
              //         )),
              //   ],
              // ),
              FutureBuilder<List<BeasiswaAdminModel>>(
                future: futureBeasiswa,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: EdgeInsets.only(top: 64.0),
                      child: Column(
                        children: [
                          Center(
                              child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 100,
                          )),
                          Center(
                            child: NunitoSans.custom(
                                text: 'Gagal memuat data',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87),
                          ),
                          Center(
                            child: SizedBox(
                              width: 140,
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
                                            'Apakah anda yakin akan Keluar ?',
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
                                        .write(key: "name", value: null);
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
                          )
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: dataBeasiswa.map((data) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CardBeasiswa(
                            totalBeasiswa: formatCurrency(data.totalNominal!),
                            tanggalBeasiswa: data.tgl.toString(),
                            titleBeasiswa: 'Keluarga ${data.nama.toString()}',
                            levelAdmin: 'DPW-SEKAR JABAR-2',
                            statusBeasiswa: statusBeasiswa(context, data),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DetailBeasiswaAdmin(
                                      beasiswa: data,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget LogicScreen(BuildContext context, String level_user) {
      Widget? screen;
      if (level_user == '5') {
        screen = DpwOnly();
      } else {
        screen = Konten(context);
      }
      return screen!;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: level_user == '5' || token == null
            ? null
            : PreferredSize(
                preferredSize: Size.fromHeight(56),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000).withOpacity(0.25),
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: AppBar(
                    centerTitle: true,
                    title: NunitoSans.custom(
                      text: 'Beasiswa',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: MyColor.black(),
                    ),
                  ),
                ),
              ),
        body: token == null
            ? IntroLoginScreen()
            : LogicScreen(context, level_user!));
  }
}

Widget statusBeasiswa(BuildContext, BeasiswaAdminModel beasiswa) {
  if (beasiswa.jumlahPengApprove == 2) {
    return StatusDiterima();
  } else if (beasiswa.jumlahPengApprove == 1 ||
      beasiswa.jumlahPengApprove == 0) {
    return StatusMenunggu();
  } else {
    return StatusDitolak();
  }
}
