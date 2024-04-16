import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationModal extends StatelessWidget {
  final BuildContext context;
  final bool success;

  NotificationModal({required this.context, required this.success});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 300,
        height: 150,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: success ? Color(0xFF22C55E) : Colors.red,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: success
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    success
                        ? 'Daftar Relawan Berhasil !'
                        : 'Daftar Relawan Gagal !',
                    style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    success
                        ? 'Sampai Jumpa Dilokasi'
                        : 'Terdapat kesalahan, Silakan coba lagi.',
                    style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
