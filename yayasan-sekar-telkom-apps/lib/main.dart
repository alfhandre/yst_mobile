import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yayasan_sekar_telkom_apps/navigator/main_menu.dart';
import 'package:yayasan_sekar_telkom_apps/screen/proposal/form_proposal.dart';
import 'package:yayasan_sekar_telkom_apps/screen/proposal/list_proposal.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    String? token = await const FlutterSecureStorage().read(key: "token");

    Future.delayed(const Duration(seconds: 2), () {
      if (token == "" || token == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const MainMenuNavigator()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const MainMenuNavigator()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return Stack(
        children: [
          SvgPicture.asset(
            'assets/background.svg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(
              'assets/yst_logo.png',
              width: 200,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: logo(),
    );
  }
}
