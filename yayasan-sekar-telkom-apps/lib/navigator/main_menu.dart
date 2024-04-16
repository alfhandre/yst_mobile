import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/artikel_navigator.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/beasiswa_navigator.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/beranda_navigator.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/profile_navigator.dart';
import 'package:yayasan_sekar_telkom_apps/screen/beasiswa/BeasiswaAdmin.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';
import 'package:yayasan_sekar_telkom_apps/widget/qr.dart';

class MainMenuNavigator extends StatefulWidget {
  final int id;
  const MainMenuNavigator({Key? key, this.id = 0}) : super(key: key);

  @override
  State<MainMenuNavigator> createState() => _MainMenuNavigatorState();
}

class _MainMenuNavigatorState extends State<MainMenuNavigator> {
  int _bottomNavIndex = 0;

  final List<Widget> pages = const [
    BerandaNavigator(),
    ArtikelNavigator(),
    BeasiswaAdmin(),
    ProfileNavigator(),
  ];

  @override
  void initState() {
    _bottomNavIndex = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget cartButton() {
      return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            elevation: 2,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            backgroundColor: Colors.white,
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => QrWidget(
                mediaQueryHeight: MediaQuery.of(context).size.height,
                mediaQueryWidth:
                    MediaQuery.of(context).size.width - (2 * defaultMargin),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/yst_navigator.png',
                    width: 30,
                  ),
                  Text(
                    'YST-Sekar Berbagi',
                    textAlign: TextAlign.center,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pages[_bottomNavIndex],
      backgroundColor: _bottomNavIndex == 0 ? Colors.black : Colors.amber,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        splashSpeedInMilliseconds: 0,
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? primaryColor : secondaryColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                index == 0
                    ? 'assets/svg/ic_beranda.svg'
                    : index == 1
                        ? 'assets/svg/ic_artikel.svg'
                        : index == 2
                            ? 'assets/svg/ic_beasiswa.svg'
                            : 'assets/svg/ic_profil.svg',
                width: 18,
                height: 18,
                // ignore: deprecated_member_use
                color: color,
              ),
              const SizedBox(height: 2),
              Text(
                index == 0
                    ? 'Beranda'
                    : index == 1
                        ? 'Artikel'
                        : index == 2
                            ? 'Beasiswa'
                            : 'Profil',
                style: primaryTextStyle.copyWith(color: color, fontSize: 8),
              )
            ],
          );
        },
        activeIndex: _bottomNavIndex,
        notchMargin: -50,
        // notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        backgroundColor: Colors.white,
        height: 55,
      ),
    );
  }
}
