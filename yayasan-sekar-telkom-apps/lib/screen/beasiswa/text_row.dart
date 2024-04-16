import 'package:flutter/material.dart';

import '../../theme.dart';

class TextRow {
  final String leftText;
  final String rightText;
  final bool isStatus;
  final int status;

  TextRow(this.leftText, this.rightText,
      {this.isStatus = true, this.status = 4});

  TableRow buildRow() {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            leftText,
            style: primaryTextStyle.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        isStatus
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(': $rightText', style: primaryTextStyle),
              )
            : Row(
                children: [
                  Text(': ', style: primaryTextStyle),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: status == 0
                          ? Colors.amber
                          : status == 1
                              ? Colors.green
                              : Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 5),
                      child: Text(
                          status == 0
                              ? 'Menunggu Konfirmasi'
                              : status == 1
                                  ? 'Diterima'
                                  : 'Ditolak',
                          style: primaryTextStyle.copyWith(
                            color: status == 0 ? Colors.black : Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
