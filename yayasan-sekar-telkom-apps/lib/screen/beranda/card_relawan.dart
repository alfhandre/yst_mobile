import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/model/relawan_model.dart';

import '../../theme.dart';
import '../crowdfunding/crowdfunding_screen.dart';
import '../crowdfunding/detail_crowdfunding.dart';

class CustomCardRelawan extends StatelessWidget {
  final List<ProgramRelawanModel>? programRelawanModel;

  const CustomCardRelawan({Key? key, this.programRelawanModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              left: defaultMargin, right: defaultMargin, bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Program Relawan',
                style: primaryTextStyle.copyWith(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const CrowdfundingScreen(
                      index: 1,
                    );
                  }));
                },
                child: Row(
                  children: [
                    Text(
                      'Lihat Semua',
                      style: primaryTextStyle.copyWith(
                          color: primaryColor, fontSize: 16),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: defaultMargin),
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: programRelawanModel!.length < 5
                ? programRelawanModel!.length
                : 5,
            itemBuilder: (BuildContext context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DetailCrowdfundingScreen(
                      appBarTitle: 'Relawan',
                      imageUrl: programRelawanModel![i].fotoPRelawan,
                      title: programRelawanModel![i].namaProgramRelawan,
                      description:
                          programRelawanModel![i].deskripsiLengkapRelawan,
                      date: programRelawanModel![i].createdAt,
                      idProgramRelawan:
                          programRelawanModel![i].idProgramRelawan,
                    );
                  }));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 280, // Menentukan lebar dari masing-masing item
                  child: Card(
                    surfaceTintColor: Color.fromARGB(255, 255, 255, 255),
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          child: Image.network(
                            programRelawanModel![i].fotoPRelawan,
                            fit: BoxFit.cover,
                            height: 120,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else if (loadingProgress.expectedTotalBytes !=
                                      null &&
                                  loadingProgress.cumulativeBytesLoaded ==
                                      loadingProgress.expectedTotalBytes) {
                                // Image is fully loaded
                                return child;
                              } else if (loadingProgress.expectedTotalBytes !=
                                      null &&
                                  loadingProgress.cumulativeBytesLoaded >
                                      loadingProgress.expectedTotalBytes!) {
                                // Error case: loaded more bytes than expected
                                return Container(
                                  color: Colors.grey[400],
                                  height: 120,
                                  width: 200,
                                  child: Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                );
                              } else {
                                // Image is still loading
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  ),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Container(
                                color: Colors.grey[400],
                                height: 120,
                                width: 200,
                                child: Center(
                                  child: Icon(
                                    Icons.error,
                                    size: 30,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            programRelawanModel![i].namaProgramRelawan,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: secondaryTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
