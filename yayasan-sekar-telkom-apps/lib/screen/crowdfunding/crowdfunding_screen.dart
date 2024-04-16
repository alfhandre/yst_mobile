import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/list_card_crowdfunding.dart';
import 'package:yayasan_sekar_telkom_apps/screen/crowdfunding/detail_crowdfunding.dart';

import '../../model/donasi_model.dart';
import '../../model/relawan_model.dart';
import '../../service/get_donasi_service.dart';
import '../../service/get_relawan_service.dart';
import '../../theme.dart';

class CrowdfundingScreen extends StatefulWidget {
  final int index;
  const CrowdfundingScreen({
    super.key,
    this.index = 0,
  });

  @override
  State<CrowdfundingScreen> createState() => _CrowdfundingScreenState();
}

class _CrowdfundingScreenState extends State<CrowdfundingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

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

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.index);
    fetchDataDonasi();
    fetchDataRelawan();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget listCardCustomDonasi() {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 50),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: programDonasiModel.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailCrowdfundingScreen(
                    appBarTitle: 'Donasi',
                    title: programDonasiModel[i].namaProgramDonasi,
                    description: programDonasiModel[i].deskripsiLengkapDonasi,
                    imageUrl: programDonasiModel[i].fotoPDonasi,
                    date: programDonasiModel[i].createdAt,
                    idProgramDonasi: programDonasiModel[i].idProgramDonasi);
              }));
            },
            child: ListCardCrowdfunding(
              title: programDonasiModel[i].namaProgramDonasi,
              imageUrl: programDonasiModel[i].fotoPDonasi,
            ),
          );
        },
      );
    }

    Widget listCardCustomRelawan() {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 50),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: programRelawanModel.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailCrowdfundingScreen(
                    appBarTitle: 'Relawan',
                    imageUrl: programRelawanModel[i].fotoPRelawan,
                    title: programRelawanModel[i].namaProgramRelawan,
                    description: programRelawanModel[i].deskripsiLengkapRelawan,
                    date: programRelawanModel[i].createdAt,
                    idProgramRelawan: programRelawanModel[i].idProgramRelawan);
              }));
            },
            child: ListCardCrowdfunding(
              title: programRelawanModel[i].namaProgramRelawan,
              imageUrl: programRelawanModel[i].fotoPRelawan,
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: Text(
          'Crowdfunding',
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
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.red,
          indicatorColor: Colors.red,
          unselectedLabelColor: secondaryColor,
          labelStyle: primaryTextStyle.copyWith(fontSize: 16),
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Program Donasi',
            ),
            Tab(
              text: 'Program Relawan',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          listCardCustomDonasi(),
          listCardCustomRelawan(),
        ],
      ),
    );
  }
}
