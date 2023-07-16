import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Category(
                image_location: 'images/cat/ticket.png',
                image_caption: 'Trade'),
            Category(
                image_location: 'images/cat/Sports.jpg',
                image_caption: 'Sports'),
            Category(
                image_location: 'images/cat/sing.png', image_caption: 'Concert')
          ],
        ));
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
    required this.image_location,
    required this.image_caption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Text(image_caption),
          ),
        ),
      ),
    );
  }
}
