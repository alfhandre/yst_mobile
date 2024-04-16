import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:yayasan_sekar_telkom_apps/model/berita_model.dart';
import 'package:yayasan_sekar_telkom_apps/screen/artikel/detail_artikel.dart';
import '../../theme.dart';

class BannerSlider extends StatefulWidget {
  final List<BeritaModel> beritaList;

  const BannerSlider({Key? key, required this.beritaList}) : super(key: key);

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget buildSlide(BeritaModel berita) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetailArtikelScreen(
              appBarTitle: 'Berita',
              imageUrl: berita.imageUrl,
              title: berita.title,
              date: berita.createdAt,
              description: berita.content,
            );
          }));
        },
        child: Container(
          margin: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  berita.imageUrl,
                  fit: BoxFit.cover,
                  width: 1000,
                  height: 500,
                ),
              ),
              Positioned(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Paling Terbaru',
                    style: primaryTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 35,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Text(
                    berita.title,
                    style: primaryTextStyle.copyWith(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          CarouselSlider(
            items:
                widget.beritaList.map((berita) => buildSlide(berita)).toList(),
            options: CarouselOptions(
              initialPage: 0,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.beritaList.length,
                (index) => buildIndicator(index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? primaryColor : secondaryColor,
      ),
    );
  }
}
