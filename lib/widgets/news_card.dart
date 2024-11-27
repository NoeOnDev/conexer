import 'package:flutter/material.dart';
import 'base_card.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String locality;
  final String description;
  final String date;
  final Widget image;

  const NewsCard({
    super.key,
    required this.title,
    required this.locality,
    required this.description,
    required this.date,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: title,
      subtitle: 'Locality: $locality',
      description: description,
      date: date,
      image: image,
      backgroundColor: const Color(0x8077A1DD),
      textColor: Colors.black,
    );
  }
}
