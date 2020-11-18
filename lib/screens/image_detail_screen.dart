import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixabay_picker/model/pixabay_media.dart';

class ImageDetailScreen extends StatefulWidget {
  ImageDetailScreen({Key key, this.pixImage}) : super(key: key);

  final PixabayImage pixImage;

  @override
  _ImageDetailScreenState createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: widget.pixImage.id,
              child: CachedNetworkImage(
                height: widget.pixImage.webformatHeight > h ? h : null,
                width: widget.pixImage.webformatWidth > w ? w : null,
                placeholder: (context, url) =>
                    Center(child: CupertinoActivityIndicator()),
                imageUrl: widget.pixImage.webformatURL,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
