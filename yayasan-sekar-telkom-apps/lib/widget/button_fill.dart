import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';

class ButtonFillCustom extends StatelessWidget {
  final Function() button;
  final String namaButton;
  final double heightButton;
  final Color colorButton;

  ButtonFillCustom(this.button, this.namaButton,
      {this.heightButton = 40, this.colorButton = primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      height: heightButton,
      child: TextButton(
        onPressed: button,
        style: TextButton.styleFrom(
          backgroundColor: colorButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
          child: Text(
            namaButton,
            style: primaryTextStyle.copyWith(
              color: Colors.white,
              fontSize: 15,
              fontWeight: bold,
            ),
          ),
        ),
      ),
    );
  }
}
