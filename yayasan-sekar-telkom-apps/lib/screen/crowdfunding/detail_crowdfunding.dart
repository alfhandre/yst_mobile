import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/form_relawan.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/form_sunat.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';
import 'package:yayasan_sekar_telkom_apps/model/relawan_model.dart';
import 'package:yayasan_sekar_telkom_apps/widget/button_crowdfunding.dart';

class DetailCrowdfundingScreen extends StatelessWidget {
  final String? appBarTitle;
  final String? imageUrl;
  final String? title;
  final String? date;
  final String? description;
  final int? idProgramRelawan;
  final int? idProgramDonasi;

  const DetailCrowdfundingScreen({
    Key? key,
    this.appBarTitle,
    this.description,
    this.imageUrl,
    this.date,
    this.title,
    this.idProgramRelawan,
    this.idProgramDonasi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ID Program: ${idProgramRelawan}');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: Text(
          'Detail Program $appBarTitle',
          style: primaryTextStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                    color: Colors.grey[400],
                    child: Center(
                      child: Icon(
                        Icons.error,
                        size: 36,
                        color: Colors.grey[700],
                      ),
                    ),
                  );
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    DateFormat('dd MMMM yyyy').format(DateTime.parse(date!)),
                    style: hintTextStyle.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description!,
                    style: secondaryTextStyle.copyWith(fontSize: 13),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 15),
                  CustomButtonForm(idProgramRelawan: idProgramRelawan),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
