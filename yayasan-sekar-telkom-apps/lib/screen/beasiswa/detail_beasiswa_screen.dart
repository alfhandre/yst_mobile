import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/screen/beasiswa/text_row.dart';

import '../../theme.dart';

class DetailBeasiswaScreen extends StatefulWidget {
  const DetailBeasiswaScreen({super.key});

  @override
  State<DetailBeasiswaScreen> createState() => _DetailBeasiswaScreenState();
}

class _DetailBeasiswaScreenState extends State<DetailBeasiswaScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget backgroundFoto() {
      return Container(
        foregroundDecoration: BoxDecoration(
          color: const Color(0xff263238).withOpacity(0.7),
        ),
        child: Image.asset(
          'assets/dumy.png',
          width: MediaQuery.of(context).size.width,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    }

    Widget backButton() {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            'Detail Beasiswa',
            style: primaryTextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      );
    }

    Widget tableRow() {
      return Table(
        columnWidths: const {
          0: FixedColumnWidth(150.0),
          1: FlexColumnWidth(),
        },
        children: [
          TextRow('Penerima', 'Asep Muljadi').buildRow(),
          TextRow('Wilayah', 'DPW-SEKAR JABAR-2').buildRow(),
          TextRow('Jumlah Anak Terdaftar', '2 Orang').buildRow(),
          TextRow('Total Beasiswa', 'Rp. 4.800.000').buildRow(),
          TextRow('Status Beasiswa', 'Diterima', isStatus: false, status: 1)
              .buildRow(),
          // Add more rows as needed
        ],
      );
    }

    Widget dataAnak() {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (ctx, i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Warji Siregar',
                      style: primaryTextStyle.copyWith(
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(150.0),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TextRow('Jenjang Pendidikan', 'Kuliah').buildRow(),
                    TextRow('Nominal/6 Bln', 'Rp. 2.400.000').buildRow(),
                    TextRow('Nama Bank', '2 Orang').buildRow(),
                    TextRow('Total Beasiswa', 'Mandiri').buildRow(),
                    TextRow('No. Rekening', '1234').buildRow(),
                    // Add more rows as needed
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          });
    }

    Widget tabBar(String title, Function() button, int index) {
      return Expanded(
        child: GestureDetector(
          onTap: button,
          child: Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: secondaryTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: currentIndex == index
                          ? primaryColor
                          : secondaryColor),
                ),
                Divider(
                    thickness: currentIndex == index ? 2 : 1,
                    color:
                        currentIndex == index ? primaryColor : secondaryColor),
              ],
            ),
          ),
        ),
      );
    }

    Widget cardKonten() {
      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Radius border card
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    '27 Mei 2023',
                    style: secondaryTextStyle,
                  ),
                  tableRow(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      tabBar('Data Anak', () {
                        setState(() {
                          currentIndex = 0;
                        });
                      }, 0),
                      tabBar('Keterangan', () {
                        setState(() {
                          currentIndex = 1;
                        });
                      }, 1),
                    ],
                  ),
                  currentIndex == 0
                      ? dataAnak()
                      : Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                          style: secondaryTextStyle.copyWith(),
                          textAlign: TextAlign.justify,
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
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  'Beasiswa Pendidikan',
                  style: secondaryTextStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          backgroundFoto(),
          Container(
            margin: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05, bottom: 40),
              child: Column(
                children: [
                  backButton(),
                  const SizedBox(
                    height: 15,
                  ),
                  cardKonten(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
