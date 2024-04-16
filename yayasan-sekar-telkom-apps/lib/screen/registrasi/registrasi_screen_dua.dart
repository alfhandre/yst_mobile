import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:yayasan_sekar_telkom_apps/screen/login/login_screen.dart';
import 'package:yayasan_sekar_telkom_apps/service/post_register_service.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:yayasan_sekar_telkom_apps/widget/form.dart';

class RegistrasiScreenDua extends StatefulWidget {
  final String namaLengkap;
  final String noIndukKaryawan;
  final String wilayahRegional;
  final String jenisKelamin;

  const RegistrasiScreenDua(
      {required this.namaLengkap,
      required this.noIndukKaryawan,
      required this.jenisKelamin,
      required this.wilayahRegional});

  @override
  State<RegistrasiScreenDua> createState() => _RegistrasiScreenDuaState();
}

class _RegistrasiScreenDuaState extends State<RegistrasiScreenDua> {
  final emailController = TextEditingController();
  final noTelpController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isFieldsFilled = false;
  bool isLoading = false;

  void checkFields() {
    setState(() {
      if (emailController.text.isNotEmpty &&
          noTelpController.text.isNotEmpty &&
          usernameController.text.isNotEmpty &&
          passwordConfirmController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        isFieldsFilled = true;
      } else {
        isFieldsFilled = false;
      }
    });
  }

  void register() async {
    setState(() {
      isLoading = true;
    });

    var data = {
      "nik": widget.noIndukKaryawan,
      "name": widget.namaLengkap,
      "email": emailController.text,
      "password": passwordController.text,
      "wilayah_id": widget.wilayahRegional,
      "jenis_kelamin": widget.jenisKelamin,
      "no_hp": noTelpController.text,
      "username": usernameController.text
    };
    print(data);
    bool register = await RegisterService().register(data);
    if (register) {
      MotionToast.success(
          position: MotionToastPosition.center,
          title: Text(
            "Login Berhasil!",
            style: primaryTextStyle.copyWith(),
          ),
          description: Text(
            "Silakan login menggunakan akun yang telah dibuat",
            style: primaryTextStyle.copyWith(),
          )).show(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      MotionToast.error(
          position: MotionToastPosition.center,
          title: Text(
            "Registrasi Gagal!",
            style: primaryTextStyle.copyWith(),
          ),
          description: Text(
            "Terdapat kesalahan pada sistem",
            style: primaryTextStyle.copyWith(),
          )).show(context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget submitButton = isFieldsFilled
        ? Container(
            height: 48,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFFEE2E24),
            ),
            child: InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  register();
                }
              },
              child: Center(
                child: NunitoSans.custom(
                  text: 'Daftar',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            height: 48,
            width: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0xFFD7D7D7)),
            child: Center(
                child: NunitoSans.custom(
              text: 'Daftar',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF8A8A8A),
            )));
    Widget konten() {
      return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Ink(
                        height: 20,
                        width: 20,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFFEE2E24),
                            size: 12,
                          ),
                        ),
                      ),
                      NunitoSans.custom(
                          text: 'Kembali',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFEE2E24))
                    ],
                  ),
                ),
                NunitoSans.custom(
                    text: 'Registrasi Akun',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF50504F)),
                SizedBox(height: 8),
                NunitoSans.custom(
                    text: 'Langkah 2 dari 2',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFB5BCC2)),
                SizedBox(height: 28),
                AnotherCustomFormTextField(
                    labelText: 'Email',
                    hintText: 'Masukkan Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => checkFields(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tolong isi alamat email Anda';
                      } else if (!value.contains('@')) {
                        return 'Alamat email harus mengandung simbol "@"';
                      }
                      return null;
                    }),
                AnotherCustomFormTextField(
                  labelText: 'Nomor Telepon / WA ',
                  hintText: 'Masukkan Nomor Telepon/WhatsApp',
                  controller: noTelpController,
                  keyboardType: TextInputType.phone,
                  onChanged: (_) => checkFields(),
                ),
                AnotherCustomFormTextField(
                  labelText: 'Username',
                  hintText: 'Masukkan Username',
                  controller: usernameController,
                  onChanged: (_) => checkFields(),
                ),
                PasswordCustomTextField(
                  labelText: 'Kata Sandi',
                  controller: passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  onChanged: (_) => checkFields(),
                ),
                PasswordCustomTextField(
                  labelText: 'Konfirmasi Kata Sandi',
                  controller: passwordConfirmController,
                  hintText: 'Ketik Ulang Kata Sandi',
                  isPassword: true,
                  onChanged: (_) => checkFields(),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Konfirmasi kata sandi tidak sesuai';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Ink(
                      child: Container(
                        height: 48,
                        width: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: MyColor.red()),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: NunitoSans.custom(
                              text: 'Sebelumnya',
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: MyColor.red(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    submitButton,
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/background.svg',
                  fit: BoxFit.cover,
                ),
                konten(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
