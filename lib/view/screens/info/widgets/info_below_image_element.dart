import 'package:flutter/material.dart';

class InfoBelowImageElement extends StatelessWidget {
  const InfoBelowImageElement(
      {super.key, required this.title, required this.data});

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          child: Text(
            data,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
