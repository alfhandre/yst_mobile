import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';

class ListCardBeasiswa extends StatelessWidget {
  final String kategori;
  final String nominal;
  final String date;
  final String namaKeluarga;
  final String dpw;
  final int status;

  const ListCardBeasiswa({
    Key? key,
    required this.kategori,
    required this.nominal,
    required this.date,
    required this.namaKeluarga,
    required this.dpw,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Card(
          elevation: 2, // Atur elevasi sesuai kebutuhan
          shape: RoundedRectangleBorder(
            side: BorderSide(color: secondaryColor),
            borderRadius: BorderRadius.circular(10), // Radius border card
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, bottom: 10, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: hintTextStyle.copyWith(),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      namaKeluarga,
                      style: secondaryTextStyle.copyWith(
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      dpw,
                      style:
                          hintTextStyle.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: status == 0
                                ? Colors.amber
                                : status == 1
                                    ? Colors.green
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status == 0
                                ? 'Menunggu Konfirmasi'
                                : status == 1
                                    ? 'Diterima'
                                    : 'Ditolak',
                            style: primaryTextStyle.copyWith(
                              color: status == 0 ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Lihat Detail',
                              style: secondaryTextStyle.copyWith(
                                  color: primaryColor),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: primaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          topLeft: Radius.circular(12))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    kategori,
                    style: secondaryTextStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    nominal,
                    style: secondaryTextStyle.copyWith(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
