import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget photo(List<dynamic> listPhotos, BuildContext context) {
  //print('LIST' + listPhotos.toString();
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
    color: Colors.black87,
    child: MasonryGridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: listPhotos.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemBuilder: (context, index) {
        return itemOfCats(listPhotos[index], context);
      },
    ),
  );
}

Widget itemOfCats(dynamic item, context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed('\ImagePage', arguments: item);
    },
    child: Hero(
      tag: item["id"],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: item["portrait"],
          placeholder: (context, text) => Container(
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}
