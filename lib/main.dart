import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'routes/routes.dart';

const debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: debug);

  runApp(UnsplashFlutter());
}

class UnsplashFlutter extends StatelessWidget {
  const UnsplashFlutter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      initialRoute: '\GalleryPage',
      onGenerateRoute: Routes.routesGenerater,
    );
  }
}
