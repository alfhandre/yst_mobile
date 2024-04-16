import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/main_menu.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/form_relawan.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/form_sunat.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';

import '../../service/post_login_service.dart';
import '../../widget/button_fill.dart';
import '../../widget/info_dialog.dart';
import '../../widget/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginService? loginService;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    handleLogin() async {
      LoginService.toJson(
        emailController.text,
        passwordController.text,
      ).then((value) {
        setState(() {
          isLoading = true;
          loginService = value;
          if (loginService?.message == 'Login berhasil') {
            isLoading = false;
            MotionToast.success(
                position: MotionToastPosition.bottom,
                title: Text(
                  "Login Berhasil!",
                  style: primaryTextStyle.copyWith(),
                ),
                description: Text(
                  "Selamat datang di YST",
                  style: primaryTextStyle.copyWith(),
                )).show(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const MainMenuNavigator(
                          id: 0,
                        )),
                // MaterialPageRoute(
                //     builder: (BuildContext context) => const FormRelawan()),
                (Route<dynamic> route) => false);
          }
          // else if (loginService?.message == 'Login berhasil' &&
          //     loginService?.levelUser == '5') {
          //   isLoading = false;
          //   InfoDialogAlert.showDetailNotif(
          //       context,
          //       Column(
          //         children: [
          //           Text(
          //             'Informasi',
          //             style: primaryTextStyle.copyWith(
          //                 fontWeight: FontWeight.w600, fontSize: 18),
          //           ),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //           Text(
          //             'Menu Beasiswa hanya bisa di akses oleh DPP, DPW dan YST',
          //             style: secondaryTextStyle,
          //             textAlign: TextAlign.center,
          //           ),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //         ],
          //       ), () {
          //     Navigator.pop(context);
          //   });
          // }
          else {
            isLoading = false;

            MotionToast.error(
                title: Text(
                  "Login Gagal!",
                  style: primaryTextStyle.copyWith(),
                ),
                description: Text(
                  "Silahkan cek kembail Email dan Password anda!",
                  style: primaryTextStyle.copyWith(),
                )).show(context);
          }
        });
      });
    }

    Widget konten() {
      return SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang !',
              style: primaryTextStyle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Silahkan masuk untuk melanjutkan',
              style: primaryTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/login_logo.png',
              width: 270,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    hintStyle: hintTextStyle,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    hintStyle: hintTextStyle,
                    prefixIcon: const Icon(
                      Icons.lock_rounded,
                      color: Colors.black54,
                    ),
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonFillCustom(
                    () {
                      setState(() {
                        isLoading = true;
                      });
                      handleLogin();
                    },
                    'Masuk',
                    heightButton: 45,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/background.svg',
              fit: BoxFit.cover,
            ),
            konten(),
          ],
        ),
      ),
    );
  }
}
