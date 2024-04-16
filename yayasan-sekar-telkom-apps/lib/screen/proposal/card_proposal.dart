import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/Utility/text_nunitoSans.dart';
import 'package:yayasan_sekar_telkom_apps/model/donasi_model.dart';
import 'package:yayasan_sekar_telkom_apps/screen/proposal/detail_proposal.dart';
import 'package:yayasan_sekar_telkom_apps/screen/proposal/status_porposal.dart';

class CardProposal extends StatelessWidget {
  final ProgramDonasiModel? programDonasiModel;
  final String status;
  final VoidCallback onTap;
  const CardProposal(
      {Key? key,
      this.programDonasiModel,
      required this.status,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatCurrency(int amount) {
      String formattedAmount = amount.toString();
      final int len = formattedAmount.length;

      if (len <= 3) {
        return 'Rp. $formattedAmount';
      }

      String result = '';
      int counter = 0;

      for (int i = len - 1; i >= 0; i--) {
        result = formattedAmount[i] + result;
        counter++;

        if (counter == 3 && i != 0) {
          result = '.' + result;
          counter = 0;
        }
      }

      return 'Rp. ' + result;
    }

    return Column(
      children: [
        Ink(
          height: 280,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 1),
                blurRadius: 3.0,
                spreadRadius: 0.0,
              )
            ],
          ),
          child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(6)),
                  child: Image.network(
                    programDonasiModel?.fotoPDonasi ?? 'url_default_image',
                    fit: BoxFit.cover,
                    width: 350,
                    height: 153,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 12, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        child: NunitoSans.custom(
                            text: programDonasiModel?.namaProgramDonasi ??
                                'Dummy',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF212529),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: 8),
                      Divider(color: Color(0xFFDEE2E6), thickness: 0.5),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NunitoSans.custom(
                            text: formatCurrency(
                                programDonasiModel?.targetDana ?? 0),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff263238),
                          ),
                          StatusProposal(status: status),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
