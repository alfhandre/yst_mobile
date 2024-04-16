import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';

class StatusDiterima extends StatelessWidget {
  const StatusDiterima({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      decoration: BoxDecoration(
          color: MyColor.greenStatus(), borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 1),
        child: Center(
          child: NunitoSans.custom(
              text: 'Diterima',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
    );
  }
}

class StatusMenunggu extends StatelessWidget {
  const StatusMenunggu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      decoration: BoxDecoration(
          color: MyColor.yellowStatus(),
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 1),
        child: Center(
          child: NunitoSans.custom(
              text: 'Menunggu Konfirmasi',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: MyColor.red()),
        ),
      ),
    );
  }
}

class StatusDitolak extends StatelessWidget {
  const StatusDitolak({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      decoration: BoxDecoration(
          color: MyColor.red(), borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 1),
        child: Center(
          child: NunitoSans.custom(
              text: 'Ditolak',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
    );
  }
}
