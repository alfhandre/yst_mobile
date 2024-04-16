import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:yayasan_sekar_telkom_apps/model/donasi_model.dart';
import 'package:yayasan_sekar_telkom_apps/screen/proposal/card_proposal.dart';
import 'package:yayasan_sekar_telkom_apps/screen/proposal/detail_proposal.dart';
import 'package:yayasan_sekar_telkom_apps/screen/proposal/status_porposal.dart';
import 'package:yayasan_sekar_telkom_apps/service/get_donasi_service.dart';

class ListProposalScreen extends StatefulWidget {
  const ListProposalScreen({Key? key});

  @override
  State<ListProposalScreen> createState() => _ListProposalScreenState();
}

class _ListProposalScreenState extends State<ListProposalScreen> {
  late Future<List<ProgramDonasiModel>> futureDonasi;
  final ProgramDonasiService programDonasiService = ProgramDonasiService();
  late List<ProgramDonasiModel> dataDonasi = [];

  @override
  void initState() {
    super.initState();
    futureDonasi = programDonasiService.fetchDonasiData();
    futureDonasi.then((list) => dataDonasi = list);
  }

  @override
  Widget build(BuildContext context) {
    Widget proposalBaruButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Ink(
              height: 35,
              width: 152,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: MyColor.red()),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: NunitoSans.custom(
                    text: 'Proposal Baru +',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MyColor.red(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget konten() {
      return FutureBuilder(
        future: futureDonasi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.only(top: 64.0),
              child: Column(
                children: [
                  Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 100,
                    ),
                  ),
                  Center(
                    child: NunitoSans.custom(
                      text: 'Gagal memuat data',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Column(
                  children: snapshot.data?.map((data) {
                        return CardProposal(
                          status: 'diterima',
                          programDonasiModel: data,
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DetailProposal(
                                programDonasiModel: data,
                              );
                            }));
                          },
                        );
                      }).toList() ??
                      [],
                ),
              ],
            );
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000).withOpacity(0.25),
                offset: Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 0,
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: NunitoSans.custom(
              text: 'Kelola Proposal',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: MyColor.black(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              proposalBaruButton(),
              SizedBox(height: 20),
              konten(),
            ],
          ),
        ),
      ),
    );
  }
}
