import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/widget/button_fill.dart';
import 'package:yayasan_sekar_telkom_apps/widget/button_no_fill.dart';

import '../theme.dart';

class WarningAlertDialog {
  static Future<void> showDetailNotif(
    BuildContext context,
    Widget widget,
    Function() buttonYa,
    Function() buttonNo,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width - (2 * defaultMargin),
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget,
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(child: ButtonNoFillCustom(buttonNo, 'Tidak')),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(child: ButtonFillCustom(buttonYa, 'Ya')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
