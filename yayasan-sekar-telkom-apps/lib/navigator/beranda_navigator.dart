import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:yayasan_sekar_telkom_apps/model/berita_model.dart';
import 'package:yayasan_sekar_telkom_apps/model/donasi_model.dart';
import 'package:yayasan_sekar_telkom_apps/screen/beranda/banner_slider.dart';
import 'package:yayasan_sekar_telkom_apps/screen/beranda/card_donasi.dart';
import 'package:yayasan_sekar_telkom_apps/screen/beranda/card_relawan.dart';
import 'package:yayasan_sekar_telkom_apps/screen/beranda/profil_yst.dart';
import 'package:yayasan_sekar_telkom_apps/screen/proposal/list_proposal.dart';
import 'package:yayasan_sekar_telkom_apps/service/get_berita_service.dart';
import 'package:yayasan_sekar_telkom_apps/service/get_donasi_service.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/relawan_model.dart';
import '../screen/beranda/card_1.dart';
import '../service/get_relawan_service.dart';

class BerandaNavigator extends StatefulWidget {
  const BerandaNavigator({super.key});

  @override
  State<BerandaNavigator> createState() => _BerandaNavigatorState();
}

class _BerandaNavigatorState extends State<BerandaNavigator> {
  final BeritaService _beritaService = BeritaService();
  List<BeritaModel> beritaModel = [];
  bool isLoading = false;
  String? token, level_user, name;

  Future<void> fetchDataBerita() async {
    final List<BeritaModel> data = await _beritaService.fetchBeritaData();
    setState(() {
      beritaModel = data;
    });
  }

  @override
  final List<String> imgList = [
    'assets/dumy_banner.png',
    'assets/dumy_banner.png',
    'assets/dumy_banner.png',
  ];

  final ProgramDonasiService _donasiService = ProgramDonasiService();
  List<ProgramDonasiModel> programDonasiModel = [];

  Future<void> fetchDataDonasi() async {
    final List<ProgramDonasiModel> data =
        await _donasiService.fetchDonasiData();
    setStateIfMounted(() {
      programDonasiModel = data;
    });
  }

  final ProgramRelawanService _programRelawanService = ProgramRelawanService();
  List<ProgramRelawanModel> programRelawanModel = [];

  Future<void> fetchDataRelawan() async {
    final List<ProgramRelawanModel> data =
        await _programRelawanService.fetchRelawanData();
    setStateIfMounted(() {
      programRelawanModel = data;
    });
  }

  final Uri _url = Uri.parse('https://yayasansekartelkom.org/');
  Future<void> _launchInformasiYST() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  void fetchDataAccount() async {
    name = await FlutterSecureStorage().read(key: 'name');
    setState(() {});
    print(name);
  }

  void fetchLevel() async {
    setState(() {
      isLoading = true;
    });
    level_user = await const FlutterSecureStorage().read(key: "level_user");
    setState(() {
      isLoading = false;
    });
    print(level_user);
  }

  @override
  void initState() {
    fetchDataAccount();
    fetchDataDonasi();
    fetchDataRelawan();
    fetchDataBerita();
    fetchLevel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget cardCustome() {
      return const CustomCard(
        description:
            'Bersama kita lancarkan gerakan menuju 1000 Beasiswa Pendidikan',
        imageUrl: 'assets/dumy.png',
      );
    }

    Widget bannerCustome() {
      return BannerSlider(beritaList: beritaModel);
    }

    Widget cardCustomeDonasi() {
      return CustomCardDonasi(
        programDonasiModel: programDonasiModel,
      );
    }

    Widget cardCustomeRelawan() {
      return CustomCardRelawan(
        programRelawanModel: programRelawanModel,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name != null ? 'Halo, $name !' : 'Halo !',
                    style: primaryTextStyle.copyWith(
                        color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                  level_user == "1"
                      ?
                      // ? Ink(
                      //     height: 23,
                      //     width: 105,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(width: 1, color: MyColor.red()),
                      //       borderRadius: BorderRadius.circular(6),
                      //       color: MyColor.red(),
                      //     ),
                      //     child: InkWell(
                      //       onTap: () {
                      //         Navigator.of(context)
                      //             .push(MaterialPageRoute(builder: (context) {
                      //           return ListProposalScreen();
                      //         }));
                      //       },
                      //       child: Center(
                      //         child: NunitoSans.custom(
                      //           text: 'Kelola Proposal ->',
                      //           fontSize: 10,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ))
                      Container()
                      : Container()
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            cardCustome(),
            const SizedBox(
              height: 15,
            ),
            bannerCustome(),
            const SizedBox(
              height: 24,
            ),
            cardCustomeDonasi(),
            const SizedBox(
              height: 24,
            ),
            cardCustomeRelawan(),
            const SizedBox(
              height: 24,
            ),
            ProfilYst(
              button: _launchInformasiYST,
            ),
          ],
        ),
      ),
    );
  }
}
