import 'package:flutter/material.dart';

import '../../../../data/models/mylist/mylist_model.dart';

class MylistImage extends StatelessWidget {
  const MylistImage({
    super.key,
    required this.data,
  });

  final MylistModel data;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      data.imageUrl,
      height: MediaQuery.sizeOf(context).height * 0.16,
      width: MediaQuery.sizeOf(context).width * 0.2,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
