import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:yayasan_sekar_telkom_apps/service/beasiswa_admin_service.dart';
import 'package:yayasan_sekar_telkom_apps/widget/StatusBeasiswa.dart';
import 'package:yayasan_sekar_telkom_apps/model/beasiswa_admin_model.dart';

class DetailBeasiswaAdmin extends StatefulWidget {
  const DetailBeasiswaAdmin({Key? key, required this.beasiswa})
      : super(key: key);
  final BeasiswaAdminModel beasiswa;

  @override
  State<DetailBeasiswaAdmin> createState() => _DetailBeasiswaAdminState();
}

class _DetailBeasiswaAdminState extends State<DetailBeasiswaAdmin>
    with SingleTickerProviderStateMixin {
  late Future<List<BeasiswaAdminModel>> futureBeasiswa;
  bool isLoading = true;
  int _selectedTabbar = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    futureBeasiswa = BeasiswaAdminService().getBeasiswaAdmin();
    _tabController = TabController(length: 2, vsync: this);
  }

  int countJumlahAnak(BeasiswaAdminModel beasiswa) {
    int jumlahAnak = 0;

    if (beasiswa.namaAnak1 != null && beasiswa.namaAnak1 != '') jumlahAnak++;
    if (beasiswa.namaAnak2 != null && beasiswa.namaAnak2 != '') jumlahAnak++;
    if (beasiswa.namaAnak3 != null && beasiswa.namaAnak3 != '') jumlahAnak++;

    return jumlahAnak;
  }

  int countTotalBeasiswa(BeasiswaAdminModel beasiswa) {
    int totalBeasiswa = 0;
    if (beasiswa.nominal1 != null && beasiswa.nominal1 != 0)
      totalBeasiswa += beasiswa.nominal1!;
    if (beasiswa.nominal2 != null && beasiswa.nominal2 != 0)
      totalBeasiswa += beasiswa.nominal2!;
    if (beasiswa.nominal3 != null && beasiswa.nominal3 != 0)
      totalBeasiswa += beasiswa.nominal3!;
    return totalBeasiswa;
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
              Stack(children: [
                Image.asset(
                  'assets/images/Rectangle_19.png',
                  // width: MediaQuery.of(context).size.width * 1.1,
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
                      padding: const EdgeInsets.only(top: 8),
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
                                  text: 'Detail Beasiswa',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white))
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.5, color: Color(0xFFBBBBBB)),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.1), // Warna dan Opacity shadow
                              offset: Offset(0, 1), // Posisi shadow (x, y)
                              blurRadius: 3.0, // Radius blur
                              spreadRadius: 0.0, // Jarak penyebaran
                            ),
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 145,
                                    decoration: BoxDecoration(
                                        color: MyColor.red(),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6.0),
                                          topRight: Radius.circular(0.0),
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(6.0),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      child: Center(
                                          child: NunitoSans.custom(
                                              text: 'Beasiswa Pendidikan',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        NunitoSans.custom(
                                            text: widget.beasiswa.tgl,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: MyColor.grey()),
                                        SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: NunitoSans.custom(
                                                    text: 'Penerima',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        MyColor.cardTitle())),
                                            Expanded(
                                                flex: 1,
                                                child: NunitoSans.custom(
                                                    text:
                                                        ': ${widget.beasiswa.nama}',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        MyColor.cardTitle())),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: NunitoSans.custom(
                                                    text: 'Wilayah',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        MyColor.cardTitle())),
                                            Expanded(
                                                flex: 1,
                                                child: NunitoSans.custom(
                                                    text: ': DPW-SEKAR JABAR-2',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        MyColor.cardTitle())),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: NunitoSans.custom(
                                                    text:
                                                        'Jumlah anak terdaftar',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        MyColor.cardTitle())),
                                            Expanded(
                                                flex: 1,
                                                child: NunitoSans.custom(
                                                    text:
                                                        ': ${countJumlahAnak(widget.beasiswa)} orang', //DSINI
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        MyColor.cardTitle())),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: NunitoSans.custom(
                                                    text: 'Total Beasiswa',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        MyColor.cardTitle())),
                                            Expanded(
                                                flex: 1,
                                                child: NunitoSans.custom(
                                                    text:
                                                        ': ${formatCurrency(countTotalBeasiswa(widget.beasiswa))}',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        MyColor.cardTitle())),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: NunitoSans.custom(
                                                    text: 'Status Beasiswa',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        MyColor.cardTitle())),
                                            Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    NunitoSans.custom(
                                                        text: ': ',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: MyColor
                                                            .cardTitle()),
                                                    statusBeasiswaDetail(widget
                                                        .beasiswa
                                                        .jumlahPengApprove!
                                                        .toInt()),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                              Container(
                                child: TabBar(
                                    controller: _tabController,
                                    onTap: (index) {
                                      setState(() {
                                        _selectedTabbar = index;
                                      });
                                    },
                                    indicatorColor: MyColor.red(),
                                    indicatorSize: TabBarIndicatorSize.tab,
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
                                      Tab(text: 'Data Anak'),
                                      Tab(text: 'Keterangan'),
                                    ]),
                              ),
                              Builder(builder: (_) {
                                if (_selectedTabbar == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 24,
                                        right: 24,
                                        bottom: 20),
                                    child: Column(
                                      children: [
                                        // anak pertama
                                        widget.beasiswa.namaAnak1 != null &&
                                                widget.beasiswa.namaAnak1 != ''
                                            ? Container(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            size: 20,
                                                            color: MyColor
                                                                .greyIcon(),
                                                          ),
                                                          NunitoSans.custom(
                                                              text: widget
                                                                  .beasiswa
                                                                  .namaAnak1,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: MyColor
                                                                  .black())
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                        color: MyColor
                                                            .greyDivider()),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'Jenjang Pendidikan',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${widget.beasiswa.jenjangPendidikan1}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'Nominal/6 bln',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${formatCurrency(widget.beasiswa.nominal1!)}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'Nama Bank',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${widget.beasiswa.namaBank1}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'No. Rekening',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${widget.beasiswa.nomorRekening1}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        // Anak kedua
                                        widget.beasiswa.namaAnak2 != null &&
                                                widget.beasiswa.namaAnak2 != ''
                                            ? Container(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            size: 20,
                                                            color: MyColor
                                                                .greyIcon(),
                                                          ),
                                                          NunitoSans.custom(
                                                              text: widget
                                                                  .beasiswa
                                                                  .namaAnak2,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: MyColor
                                                                  .black())
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                        color: MyColor
                                                            .greyDivider()),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'Jenjang Pendidikan',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${widget.beasiswa.jenjangPendidikan2}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'Nominal/6 bln',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${formatCurrency(widget.beasiswa.nominal2!)}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'Nama Bank',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${widget.beasiswa.namaBank2}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'No. Rekening',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${widget.beasiswa.nomorRekening2}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        // Anak 3
                                        widget.beasiswa.namaAnak3 != null &&
                                                widget.beasiswa.namaAnak3 != ""
                                            ? Container(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            size: 20,
                                                            color: MyColor
                                                                .greyIcon(),
                                                          ),
                                                          NunitoSans.custom(
                                                              text: widget
                                                                  .beasiswa
                                                                  .namaAnak3,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: MyColor
                                                                  .black())
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                        color: MyColor
                                                            .greyDivider()),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'Jenjang Pendidikan',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${widget.beasiswa.jenjangPendidikan3}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'Nominal/6 bln',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${formatCurrency(widget.beasiswa.nominal3!)}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'Nama Bank',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${widget.beasiswa.namaBank3}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 7),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    'No. Rekening',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                        Expanded(
                                                            flex: 1,
                                                            child: NunitoSans.custom(
                                                                text:
                                                                    ': ${widget.beasiswa.nomorRekening3}',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: MyColor
                                                                    .cardTitle())),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                  ],
                                                ),
                                              )
                                            : Divider()
                                      ],
                                    ),
                                  );
                                } else {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 24,
                                        right: 24,
                                        bottom: 20,
                                      ),
                                      child: NunitoSans.custom(
                                          text: widget.beasiswa.keterangan,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: MyColor.black(),
                                          textAlign: TextAlign.justify));
                                }
                              })
                            ]),
                      ),
                    ),
                  ],
                )
              ]),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

Widget statusBeasiswaDetail(int jumlahPengApprove) {
  if (jumlahPengApprove == 2) {
    return StatusDiterima();
  } else if (jumlahPengApprove == 1 || jumlahPengApprove == 0) {
    return StatusMenunggu();
  } else {
    return StatusDitolak();
  }
}
