import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yayasan_sekar_telkom_apps/screen/login/login_screen.dart';
import 'package:yayasan_sekar_telkom_apps/screen/registrasi/registrasi_screen_satu.dart';
import 'package:yayasan_sekar_telkom_apps/widget/button_no_fill.dart';

import '../../widget/button_fill.dart';

class IntroLoginScreen extends StatelessWidget {
  const IntroLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget konten() {
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/yst_logo.png',
              width: 120,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/login_logo.png',
              width: 250,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  ButtonFillCustom(
                    () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }));
                    },
                    'Sudah Punya Akun ?',
                    heightButton: 45,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ButtonNoFillCustom(
                    () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return RegistrasiScreenSatu();
                      }));
                    },
                    'Daftar Akun',
                    heightButton: 45,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/background.svg',
            fit: BoxFit.cover,
          ),
          konten(),
        ],
      ),
    );
  }
}
