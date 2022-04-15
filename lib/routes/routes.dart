import 'package:flutter/material.dart';
import '../view/galleryPage.dart';
import '../view/imagePage.dart';

class Routes {
  static Route<dynamic> routesGenerater(RouteSettings siettings) {
    final dynamic argument = siettings.arguments;
    switch (siettings.name) {
      case '\GalleryPage':
        return MaterialPageRoute(builder: (context) => const GalleryPage());
      case '\ImagePage':
        return MaterialPageRoute(
            builder: (context) => ImagePage(photo: argument));
      default:
        return MaterialPageRoute(builder: (context) => const GalleryPage());
    }
  }
}
