import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/form_relawan.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/form_sunat.dart';
import 'package:yayasan_sekar_telkom_apps/screen/login/intro_login_screen.dart';
import 'package:yayasan_sekar_telkom_apps/service/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonForm extends StatelessWidget {
  final int? idProgramRelawan;

  const CustomButtonForm({Key? key, this.idProgramRelawan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: idProgramRelawan == 2 || idProgramRelawan == 3
          ? SizedBox(
              width: 348,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  // Check login status
                  bool isLoggedIn = await AuthService.isUserLoggedIn();

                  if (isLoggedIn) {
                    if (idProgramRelawan == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormRelawan()),
                      );
                    } else if (idProgramRelawan == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormSunat()),
                      );
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IntroLoginScreen()),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.red;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Daftar Sekarang',
                    style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
