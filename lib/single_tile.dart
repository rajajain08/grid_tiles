import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class SingleTile extends StatefulWidget {
  final String title;
  final String image;
  const SingleTile({
    Key key,
    this.title,
    this.image,
  }) : super(key: key);

  @override
  _SingleTileState createState() => _SingleTileState();
}

class _SingleTileState extends State<SingleTile>
    with SingleTickerProviderStateMixin {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  Animation<double> animation;
  AnimationController controller;
  FlipDirection direction;
  toggleCard(int duration) {
    direction =
        duration % 2 == 0 ? FlipDirection.HORIZONTAL : FlipDirection.VERTICAL;
    Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 1000 + duration));
      cardKey.currentState.toggleCard();
      return true;
    });
  }

  Color colorflip;
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    toggleCard(Random().nextInt(2000));
    animation = Tween<double>(begin: 1.0, end: 1.3)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOutExpo))
          ..addListener(
            () {
              setState(
                () {},
              );
            },
          );
    colorflip = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200 * animation.value,
        width: 200 * animation.value,
        child: GestureDetector(
          onTap: () {
            controller.forward();
            Future.delayed(Duration(seconds: 1)).then((onValue) {
              controller.reverse();
            });
          },
          child: Container(
            child: FlipCard(
              key: cardKey,
              flipOnTouch: false,
              direction: direction,
              front: Container(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorflip,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ),
              ),
              back: Container(
                decoration: BoxDecoration(
                  color: colorflip,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      widget.image,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
