import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

// Bottom-sheet displaying info for a given [image].
class InfoSheet extends StatelessWidget {
  final Map photo;

  InfoSheet(this.photo);

  @override
  Widget build(BuildContext context) {
    print('TEST' + photo.toString());

    return Card(
        margin: const EdgeInsets.only(top: 16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                  children: <Widget>[
                    const SizedBox(width: 16),
                    Text(
                      '${photo["user"]}',
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        formatDate(DateTime.parse(photo["created_at"]),
                            [dd, '. ', M, ' ', yyyy]).toUpperCase(),
                        style: const TextStyle(
                            color: Colors.black26,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              // show description
              _buildDescriptionWidget(photo['description']),
              // show location
              _buildLocationWidget(photo['location']),
              // show exif data
              _buildExifWidget(photo["exif_a"], photo["exif_e"],
                  photo["exif_f"], photo["exif_iso"]),
              // filter null views
            ].toList()));
  }

  Widget _buildDescriptionWidget(String description) => description != ''
      ? Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 16.0),
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 16.0,
              letterSpacing: 0.1,
            ),
          ),
        )
      : const Text("");

  Widget _buildLocationWidget(dynamic location) => location != ''
      ? Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
          child: Row(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.black54,
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$location'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        )
      : const Text("");

  Widget _buildExifWidget(
          dynamic aperture, dynamic exposure, dynamic focal, dynamic iso) =>
      aperture != '' && exposure != '' && focal != '' && iso != ''
          ? Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
              child: Row(
                children: <Widget>[
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.black54,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: Text(
                            photo['model'],
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          )),
                      Row(
                        children: <Widget>[
                          // display exif info
                          _buildExifInfoItem('ƒ$aperture'),
                          _buildExifInfoItem(exposure),
                          _buildExifInfoItem('$focal mm'),
                          _buildExifInfoItem('ISO$iso'),
                        ],
                      ),
                    ],
                  )
                ].toList(),
              ))
          : const Text("");

  Widget _buildExifInfoItem(String data) => data != ''
      ? Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
          child: Text(
            data,
            style: const TextStyle(
                color: Colors.black26,
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          ))
      : const Text("");
}