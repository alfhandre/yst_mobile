import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/model/donasi_model.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/crowdfunding_screen.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/detail_crowdfunding.dart';

import '../../theme.dart';

class CustomCardDonasi extends StatelessWidget {
  final List<ProgramDonasiModel>? programDonasiModel;

  const CustomCardDonasi({
    Key? key,
    this.programDonasiModel,
  }) : super(key: key);

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
                'Program Donasi',
                style: primaryTextStyle.copyWith(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const CrowdfundingScreen();
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
            itemCount:
                programDonasiModel!.length < 5 ? programDonasiModel!.length : 5,
            itemBuilder: (BuildContext context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DetailCrowdfundingScreen(
                      appBarTitle: 'Donasi',
                      imageUrl: programDonasiModel![i].fotoPDonasi,
                      title: programDonasiModel![i].namaProgramDonasi,
                      description:
                          programDonasiModel![i].deskripsiLengkapDonasi,
                      date: programDonasiModel![i].createdAt,
                    );
                  }));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 280,
                  child: Card(
                    surfaceTintColor: Colors.white,
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
                            programDonasiModel![i].fotoPDonasi,
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
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            programDonasiModel![i].namaProgramDonasi,
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
