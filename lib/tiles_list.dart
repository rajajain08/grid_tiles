import 'package:flutter/material.dart';
import 'package:grid_tiles/single_tile.dart';

class TilesList extends StatefulWidget {
  final ScrollController controller;

  TilesList({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  _TilesListState createState() => _TilesListState();
}

class _TilesListState extends State<TilesList> {
  @override
  void initState() {
    _children.shuffle();
    super.initState();
  }

  final List<Widget> _children = [
    SingleTile(
      title: "AC/DC",
      image: "assets/ac-dc.jpeg",
    ),
    SingleTile(
      title: "Led Zeppelin",
      image: "assets/creed.png",
    ),
    SingleTile(
      title: "Pearl Jam",
      image: "assets/pearl-jam.jpg",
    ),
    SingleTile(
      title: "Creed",
      image: "assets/creed.png",
    ),
    SingleTile(
      title: "Pink Floyd",
      image: "assets/pink-floyd.jpg",
    ),
    SingleTile(
      title: "Snow Patrol",
      image: "assets/snow-patrol.jpg",
    ),
    SingleTile(
      title: "AC/DC",
      image: "assets/ac-dc.jpeg",
    ),
    SingleTile(
      title: "Led Zeppelin",
      image: "assets/creed.png",
    ),
    SingleTile(
      title: "Pearl Jam",
      image: "assets/pearl-jam.jpg",
    ),
    SingleTile(
      title: "Creed",
      image: "assets/creed.png",
    ),
    SingleTile(
      title: "Pink Floyd",
      image: "assets/pink-floyd.jpg",
    ),
    SingleTile(
      title: "Snow Patrol",
      image: "assets/snow-patrol.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: _children);
  }
}
