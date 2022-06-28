import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String imageUrl;

  const AvatarWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60 / 2),
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(imageUrl))));
  }
}
