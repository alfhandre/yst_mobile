import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme.dart';

class DetailArtikelScreen extends StatelessWidget {
  final String? appBarTitle;
  final String? imageUrl;
  final String? title;
  final String? date;
  final String? description;
  const DetailArtikelScreen(
      {super.key,
      this.appBarTitle,
      this.description,
      this.imageUrl,
      this.date,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: Text(
          'Detail $appBarTitle',
          style: primaryTextStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateFormat('dd MMMM yyyy').format(DateTime.parse(date!)),
                    style: hintTextStyle.copyWith(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    description!,
                    style: secondaryTextStyle.copyWith(fontSize: 13),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
