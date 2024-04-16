import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/model/kegiatan_model.dart';
import 'package:yayasan_sekar_telkom_apps/screen/artikel/detail_artikel.dart';
import 'package:yayasan_sekar_telkom_apps/screen/artikel/list_card_artikel.dart';
import 'package:yayasan_sekar_telkom_apps/service/get_kegiatan_service.dart';

import '../model/berita_model.dart';
import '../service/get_berita_service.dart';
import '../theme.dart';

class ArtikelNavigator extends StatefulWidget {
  const ArtikelNavigator({super.key});

  @override
  State<ArtikelNavigator> createState() => _ArtikelNavigatorState();
}

class _ArtikelNavigatorState extends State<ArtikelNavigator>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final BeritaService _beritaService = BeritaService();
  final KegiatanService _kegiatanService = KegiatanService();
  List<BeritaModel> beritaModel = [];
  List<KegiatanModel> kegiatanModel = [];

  Future<void> fetchDataBerita() async {
    final List<BeritaModel> data = await _beritaService.fetchBeritaData();
    setStateIfMounted(() {
      beritaModel = data;
    });
  }

  Future<void> fetchDataKegiatan() async {
    final List<KegiatanModel> data = await _kegiatanService.fetchKegiatanData();
    setStateIfMounted(() {
      kegiatanModel = data;
    });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    fetchDataBerita();
    fetchDataKegiatan();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget listCardCustomBerita() {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 50),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: beritaModel.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailArtikelScreen(
                  appBarTitle: 'Berita',
                  imageUrl: beritaModel[i].imageUrl,
                  title: beritaModel[i].title,
                  date: beritaModel[i].createdAt,
                  description: beritaModel[i].content,
                );
              }));
            },
            child: ListCardArtikel(
              imageUrl: beritaModel[i].imageUrl,
              title: beritaModel[i].title,
            ),
          );
        },
      );
    }

    Widget listCardCustomKegiatan() {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 50),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: kegiatanModel.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailArtikelScreen(
                  appBarTitle: 'Kegiatan',
                  imageUrl: kegiatanModel[i].gambarBerita,
                  title: kegiatanModel[i].judulBerita,
                  date: kegiatanModel[i].createdAt,
                  description: kegiatanModel[i].isiBerita,
                );
              }));
            },
            child: ListCardArtikel(
              imageUrl: kegiatanModel[i].gambarBerita,
              title: kegiatanModel[i].judulBerita,
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
          'Artikel',
          style: primaryTextStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        bottom: TabBar(
          labelColor: Colors.red,
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: secondaryColor,
          labelStyle: primaryTextStyle.copyWith(fontSize: 16),
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Berita',
            ),
            Tab(
              text: 'Kegiatan',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          listCardCustomBerita(),
          listCardCustomKegiatan(),
        ],
      ),
    );
  }
}
