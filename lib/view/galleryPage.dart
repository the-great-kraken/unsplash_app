import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../widgets/appBar.dart';
import '../widgets/photoCard.dart';
import '/services/getPhotos.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GalleryPage> {
  final ScrollController _scrollController = ScrollController();
  final GetPhotos _getPhotos = GetPhotos();
  int page = 1;
  List photos = [];

  @override
  void initState() {
    _getPhotos.getTrendingPhotos(page).then((value) {
      setState(() {
        photos = value;
      });
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        _getPhotos.getTrendingPhotos(page).then((value) {
          setState(() {
            photos.addAll(value);
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            photo(photos, context),
          ],
        ),
      ),
    );
  }
}