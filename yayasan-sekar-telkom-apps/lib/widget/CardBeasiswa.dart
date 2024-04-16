import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:intl/intl.dart';

class CardBeasiswa extends StatelessWidget {
  // final int totalBeasiswa;
  final String totalBeasiswa;
  final String tanggalBeasiswa;
  // final DateTime tanggalBeasiswa;
  final String titleBeasiswa, levelAdmin;
  final Widget statusBeasiswa;
  final VoidCallback onTap;

  const CardBeasiswa(
      {required this.totalBeasiswa,
      required this.tanggalBeasiswa,
      required this.titleBeasiswa,
      required this.levelAdmin,
      required this.statusBeasiswa,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8, color: Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Warna dan Opacity shadow
            offset: Offset(0, 1), // Posisi shadow (x, y)
            blurRadius: 3.0, // Radius blur
            spreadRadius: 0.0, // Jarak penyebaran
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: MyColor.red(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      topRight: Radius.circular(0.0),
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(6.0),
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Center(
                      child: NunitoSans.custom(
                          text: 'Beasiswa Pendidikan',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 9, right: 8),
                child: NunitoSans.custom(
                    text: totalBeasiswa,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MyColor.black()),
              )
            ],
          ),
          SizedBox(height: 14),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              NunitoSans.custom(
                  text: DateFormat('dd MMMM yyyy')
                      .format(DateTime.parse(tanggalBeasiswa)),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: MyColor.grey()),
              SizedBox(height: 4),
              NunitoSans.custom(
                  maxLines: 45,
                  overflow: TextOverflow.ellipsis,
                  text: titleBeasiswa,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: MyColor.cardTitle()),
              NunitoSans.custom(
                  text: levelAdmin,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: MyColor.grey()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  statusBeasiswa,
                  TextButton(
                      onPressed: onTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NunitoSans.custom(
                              text: 'Lihat Detail',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColor.red()),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: MyColor.red(),
                            size: 12,
                          ),
                        ],
                      ))
                ],
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
