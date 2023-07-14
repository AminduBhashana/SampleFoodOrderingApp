import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget customListTile({
  required String name,
  required String description,
  required double price,
  required String imageUrl,
}) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 80,
          height: 120,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const CircularProgressIndicator(),
          errorWidget: (context, url, error) => CachedNetworkImage(
            imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/fastfoodapp-1c735.appspot.com/o/defaults%2Fimage4.png?alt=media&token=9a23e850-c8d4-49a4-8b7a-d4b654e172f9',
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Price: \$${price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}
