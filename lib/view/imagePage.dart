import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:photo_view/photo_view.dart';
import '../services/getPhotos.dart';
import '../widgets/infoSheet.dart';

class ImagePage extends StatefulWidget {
  final Map photo;

  ImagePage({required this.photo});

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late PersistentBottomSheetController infoBottomSheetController;

  final GetPhotos _getPhotos = GetPhotos();
  Map info = {};

  @override
  void initState() {
    print('ID' + widget.photo['id']);
    _getPhotos.getInfo(widget.photo['id']).then((value) {
      setState(() {
        info = value;
      });
    });

    FlutterDownloader.registerCallback(downloadCallback);

    super.initState();
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  void _requestDownload(String link) async {
    final taskId = await FlutterDownloader.enqueue(
      url: link,
      savedDir: '/storage/emulated/0/Download',
      saveInPublicStorage: true,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  Widget _buildAppBar() => AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading:
            // back button
            IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          // show photo info
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            tooltip: 'Image Info',
            onPressed: () => infoBottomSheetController = _showInfoBottomSheet(),
          ),
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            tooltip: 'Image Info',
            onPressed: () => _requestDownload(widget.photo['download']),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      );

  Widget _buildPhotoView(String imageId, String imageUrl) => Hero(
        tag: imageId,
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          initialScale: PhotoViewComputedScale.covered,
          minScale: PhotoViewComputedScale.covered,
          maxScale: PhotoViewComputedScale.covered,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _buildPhotoView(widget.photo['id'], widget.photo['big']),
          Positioned(top: 0.0, left: 0.0, right: 0.0, child: _buildAppBar()),
        ],
      ),
    );
  }

  PersistentBottomSheetController _showInfoBottomSheet() {
    print('INFO' + info.toString());
    return _scaffoldKey.currentState!
        .showBottomSheet((context) => InfoSheet(info));
  }
}
