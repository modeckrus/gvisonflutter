import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PostImageGallary extends StatefulWidget {
  PostImageGallary({Key key, @required this.imagespath, @required this.imageid, @required this.isOffline})
      : super(key: key);
  final List<String> imagespath;
  final int imageid;
  final bool isOffline;
  @override
  _PostImageGallaryState createState() => _PostImageGallaryState();
}

class _PostImageGallaryState extends State<PostImageGallary> {
  PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: widget.imageid);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
  PhotoViewGalleryPageOptions option(index){
    PhotoViewGalleryPageOptions option;
    if(widget.isOffline){
      option = PhotoViewGalleryPageOptions(
            imageProvider: Image.file(File(widget.imagespath[index])).image,
            initialScale: PhotoViewComputedScale.contained,
            // Contained = the smallest possible size to fit one dimension of the screen
            minScale: PhotoViewComputedScale.contained * 0.5,
            // Covered = the smallest possible size to fit the whole screen
            maxScale: PhotoViewComputedScale.covered * 3,
          );
    }else{
      option = PhotoViewGalleryPageOptions(
            imageProvider: Image.network(widget.imagespath[index]).image,
            initialScale: PhotoViewComputedScale.contained,
            // Contained = the smallest possible size to fit one dimension of the screen
            minScale: PhotoViewComputedScale.contained * 0.5,
            // Covered = the smallest possible size to fit the whole screen
            maxScale: PhotoViewComputedScale.covered * 3,
          );
    }
    return option;
  }
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
      ),
      body: PhotoViewGallery.builder(
        pageController: _pageController,
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return option(index);
        },
        itemCount: widget.imagespath.length,
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes,
            ),
          ),
        ),
      ),
    );
  }
}
