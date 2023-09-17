import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/utils/functions/download.dart';
 
class ViewImageItem extends StatelessWidget {
  final String image;
  final String tag;
  const ViewImageItem({super.key, required this.image, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                onDownloadItme(url: image, context: context, isDownload: true);
              },
              icon: const FaIcon(
                FontAwesomeIcons.download,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: image,
              width: double.infinity,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
