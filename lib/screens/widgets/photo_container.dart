import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_picker/model/pixabay_media.dart';

class PhotoContainer extends StatelessWidget {
  const PhotoContainer({
    Key key,
    @required this.img,
    this.backgroundColor,
  }) : super(key: key);

  final PixabayImage img;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        placeholder: (context, url) {
          return Container(
            width: img.previewWidth.toDouble(),
            height: img.previewHeight.toDouble() - 18.0,
          );
        },
        fit: BoxFit.cover,
        imageUrl: img.previewURL,
      ),
    );
  }
}
