import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/color.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';

class StatusProposal extends StatelessWidget {
  final String status;

  const StatusProposal({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color? textColor;
    String statusText = status;

    switch (status.toLowerCase()) {
      case 'diterima':
        statusColor = MyColor.greenStatus();
        textColor = Colors.white;
        break;
      case 'menunggu':
        statusColor = MyColor.yellowStatus();
        textColor = MyColor.red();
        break;
      case 'ditolak':
        statusColor = MyColor.red();
        textColor = Colors.white;
        break;
      default:
        statusColor = Colors.transparent;
        statusText = 'Unknown';
    }

    return Container(
      height: 25,
      width: 115,
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: NunitoSans.custom(
          text: statusText,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}

// class StatusProposal extends StatelessWidget {
//   final String status;

//   const StatusProposal({Key? key, required this.status}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Color statusColor;
//     Color? textColor;
//     String statusText;
//     String? status;

//     switch (status!.toLowerCase()) {
//       case 'diterima':
//         statusColor = MyColor.greenStatus();
//         textColor = Colors.white;
//         break;
//       case 'menunggu':
//         statusColor = MyColor.yellowStatus();
//         textColor = MyColor.red();
//         break;
//       case 'ditolak':
//         statusColor = MyColor.red();
//         textColor = Colors.white;
//         break;
//       default:
//         statusColor = Colors.transparent;
//         statusText = 'Unknown';
//     }

//     return Container(
//       height: 25,
//       width: 115,
//       decoration: BoxDecoration(
//         color: statusColor,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Center(
//         child: NunitoSans.custom(
//           text: statusText,
//           fontSize: 10,
//           fontWeight: FontWeight.w700,
//           color: textColor ?? Colors.white,
//         ),
//       ),
//     );
//   }
// }

