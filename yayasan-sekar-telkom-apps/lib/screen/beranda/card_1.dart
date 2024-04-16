import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';

class CustomCard extends StatelessWidget {
  final String description;
  final String imageUrl;

  const CustomCard({
    Key? key,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 4, // Atur elevasi sesuai kebutuhan
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Radius border card
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                height: 150,
                width: MediaQuery.of(context).size.width, // Atur tinggi gambar
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: secondaryTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
