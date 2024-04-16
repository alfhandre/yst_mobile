import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:yayasan_sekar_telkom_apps/model/donasi_model.dart';
import 'package:yayasan_sekar_telkom_apps/screen/proposal/status_porposal.dart';

class DetailProposal extends StatefulWidget {
  final ProgramDonasiModel programDonasiModel;
  const DetailProposal({Key? key, required this.programDonasiModel})
      : super(key: key);

  @override
  State<DetailProposal> createState() => _DetailProposalState();
}

class _DetailProposalState extends State<DetailProposal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabbar = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  String formatCurrency(int amount) {
    String formattedAmount = amount.toString();
    final int len = formattedAmount.length;

    if (len <= 3) {
      return 'Rp. $formattedAmount';
    }

    String result = '';
    int counter = 0;

    for (int i = len - 1; i >= 0; i--) {
      result = formattedAmount[i] + result;
      counter++;

      if (counter == 3 && i != 0) {
        result = '.' + result;
        counter = 0;
      }
    }

    return 'Rp. ' + result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/kelolaIMG.jpg',
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Container(
                          height: 300,
                          // width: MediaQuery.of(context).size.width,
                          color: Color(0xFF263238).withOpacity(0.85)),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back),
                                      color: Colors.white,
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: NunitoSans.custom(
                                        text: 'Detail Proposal',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white))
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFFBBBBBB)),
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 1),
                                        blurRadius: 3.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 12),
                                              NunitoSans.custom(
                                                  text: widget
                                                      .programDonasiModel
                                                      .namaProgramDonasi,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff212529)),
                                              SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: NunitoSans.custom(
                                                          text: 'Kategori',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: MyColor
                                                              .cardTitle())),
                                                  Expanded(
                                                      flex: 1,
                                                      child: NunitoSans.custom(
                                                          text:
                                                              ': ${widget.programDonasiModel.kategoriDonasi}',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: MyColor
                                                              .cardTitle())),
                                                ],
                                              ),
                                              SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: NunitoSans.custom(
                                                          text:
                                                              'Kebutuhan Dana',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: MyColor
                                                              .cardTitle())),
                                                  Expanded(
                                                      flex: 1,
                                                      child: NunitoSans.custom(
                                                          text:
                                                              ': ${formatCurrency(widget.programDonasiModel.targetDana)}',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: MyColor
                                                              .cardTitle())),
                                                ],
                                              ),
                                              SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: NunitoSans.custom(
                                                          text: 'Penerima',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: MyColor
                                                              .cardTitle())),
                                                  Expanded(
                                                      flex: 1,
                                                      child: NunitoSans.custom(
                                                          text:
                                                              ': ${widget.programDonasiModel.penerimaDonasi}',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: MyColor
                                                              .cardTitle())),
                                                ],
                                              ),
                                              SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: NunitoSans.custom(
                                                          text:
                                                              'Penanggung Jawab',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: MyColor
                                                              .cardTitle())),
                                                  Expanded(
                                                      flex: 1,
                                                      child: NunitoSans.custom(
                                                          text:
                                                              ': ${widget.programDonasiModel.penanggungJawab}',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: MyColor
                                                              .cardTitle())),
                                                ],
                                              ),
                                              SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: NunitoSans.custom(
                                                          text:
                                                              'Status Program',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: MyColor
                                                              .cardTitle())),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          NunitoSans.custom(
                                                              text: ': ',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: MyColor
                                                                  .cardTitle()),
                                                          StatusProposal(
                                                              status:
                                                                  'diterima')
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: TabBar(
                                            controller: _tabController,
                                            onTap: (index) {
                                              print(index);
                                              setState(() {
                                                _selectedTabbar = index;
                                              });
                                            },
                                            indicatorColor: MyColor.red(),
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            labelStyle: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyColor.red()),
                                            unselectedLabelStyle:
                                                GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: MyColor.grey()),
                                            tabs: [
                                              Tab(text: 'Deskripsi'),
                                              Tab(text: 'File'),
                                            ]),
                                      ),
                                      Builder(builder: (_) {
                                        if (_selectedTabbar == 0) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                top: 20,
                                                left: 24,
                                                right: 24,
                                                bottom: 20,
                                              ),
                                              child: NunitoSans.custom(
                                                  text: widget
                                                      .programDonasiModel
                                                      .deskripsiLengkapDonasi,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: MyColor.black(),
                                                  textAlign:
                                                      TextAlign.justify));
                                        } else {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                top: 20,
                                                left: 24,
                                                right: 24,
                                                bottom: 20,
                                              ),
                                              child: NunitoSans.custom(
                                                  text:
                                                      'widget.beasiswa.keterangan',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: MyColor.black(),
                                                  textAlign:
                                                      TextAlign.justify));
                                        }
                                      })
                                    ],
                                  ))),
                        ],
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}
