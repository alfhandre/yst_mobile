import 'package:flutter/material.dart';
import 'package:yayasan_sekar_telkom_apps/theme.dart';

class ListCardCrowdfunding extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ListCardCrowdfunding({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Card(
          surfaceTintColor: Colors.white,
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
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else if (loadingProgress.expectedTotalBytes != null &&
                        loadingProgress.cumulativeBytesLoaded ==
                            loadingProgress.expectedTotalBytes) {
                      // Image is fully loaded
                      return child;
                    } else if (loadingProgress.expectedTotalBytes != null &&
                        loadingProgress.cumulativeBytesLoaded >
                            loadingProgress.expectedTotalBytes!) {
                      // Error case: loaded more bytes than expected
                      return Container(
                        height: 170,
                        color: Colors.grey[400],
                        child: Center(
                          child: Icon(
                            Icons.error,
                            size: 34,
                            color: Colors.grey[700],
                          ),
                        ),
                      );
                    } else {
                      // Image is still loading
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Container(
                      height: 170,
                      color: Colors.grey[400],
                      child: Center(
                        child: Icon(
                          Icons.error,
                          size: 34,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style:
                      secondaryTextStyle.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
