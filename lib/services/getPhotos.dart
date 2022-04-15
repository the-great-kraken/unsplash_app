import 'dart:convert';
import 'package:http/http.dart' as http;

const UNSPLASH_API_CLIENT_ID = "kyZ2kO-q_k2twON8gRIO8Z2PQ_3XaKhj2iTVTiofAWY";

class ApiServices {
  Future getTrendingPhotos(int page, String apiKEY) async {
    dynamic response;
    try {
      await http
          .get(Uri.parse(
              "https://api.unsplash.com/photos/?client_id=$apiKEY&per_page=30&page=$page"))
          .then((value) {
        response = jsonDecode(value.body);
      });
      return response;
    } catch (error) {
      print("Error Getting Trending Photos: ($error)");
      return null;
    }
  }

  Future loadImage(String id, String apiKEY) async {
    dynamic response;
    try {
      await http
          .get(Uri.parse(
              "https://api.unsplash.com/photos/$id/?client_id=$apiKEY"))
          .then((value) {
        response = jsonDecode(value.body);
      });
      return response;
    } catch (error) {
      print("Error Getting Trending Photos: ($error)");
      return null;
    }
  }
}

class GetPhotos {
  String apiKEY = UNSPLASH_API_CLIENT_ID;
  final ApiServices _apiServices = ApiServices();
  Future getTrendingPhotos(int page) async {
    List photos = [];
    dynamic response = await _apiServices.getTrendingPhotos(page, apiKEY);
    if (response != null) {
      response.forEach((element) async {
        photos.add({
          "id": element["id"],
          "link": element["links"]["self"],
          "user": element["user"]["name"].toString().contains('null')
              ? 'Unknown Photographer'
              : element["user"]["name"],
          "portrait": element["urls"]["small"],
          "big": element['urls']['full'],
          "created_at": element["created_at"],
          "description": element["description"].toString().contains('null')
              ? ''
              : element["description"],
          "likes": element["likes"],
          "download": element["urls"]["raw"],
        });
      });
      return photos;
    } else {
      return null;
    }
  }

  Future getInfo(String id) async {
    Map info = {};
    dynamic element = await _apiServices.loadImage(id, apiKEY);

    if (element != null) {
      info = ({
        "id": element["id"],
        "link": element["links"]["self"],
        "user": element["user"]["name"].toString().contains('null')
            ? 'Unknown Photographer'
            : element["user"]["name"],
        "portrait": element["urls"]["small"],
        "big": element['urls']['full'],
        "created_at": element["created_at"],
        "description": element["description"].toString().contains('null')
            ? ''
            : element["description"],
        "likes": element["likes"],
        "download": element["urls"]["raw"],
        "location": element["location"]["city"].toString().contains('null')
            ? ''
            : element["location"]["city"],
        "exif_a": element["exif"]["aperture"].toString().contains('null')
            ? ''
            : element["exif"]["aperture"],
        "exif_e": element["exif"]["exposure_time"].toString().contains('null')
            ? ''
            : element["exif"]["exposure_time"],
        "exif_f": element["exif"]["focal_length"].toString().contains('null')
            ? ''
            : element["exif"]["focal_length"],
        "exif_iso": element["exif"]["iso"].toString().contains('null')
            ? ''
            : element["exif"]["iso"],
        "model": element["exif"]["model"].toString().contains('null')
            ? ''
            : element["exif"]["model"],
      });
      return info;
    } else {
      return null;
    }
  }
}
