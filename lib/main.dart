import 'package:flutter/material.dart';
import 'package:grid_tiles/tiles_list.dart';

void main() {
  runApp(
    MaterialApp(
      home: DynamicGrid(),
    ),
  );
}

class DynamicGrid extends StatefulWidget {
  @override
  _DynamicGridState createState() => _DynamicGridState();
}

class _DynamicGridState extends State<DynamicGrid>
    with SingleTickerProviderStateMixin {
  Animation<Offset> animation;
  AnimationController controller;
  Offset currentOffset = Offset(0, 0);
  DragUpdateDetails position = DragUpdateDetails(globalPosition: Offset(0, 0));
  double top = 0;
  double left = 0;
  double containerHeight = 0;
  double containerWidth = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  GlobalKey _keyContainer = GlobalKey();

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);

    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _getSizes();
  }

  _getSizes() {
    final RenderBox _renderBox =
        _keyContainer.currentContext.findRenderObject();
    final containerSize = _renderBox.size;
    containerHeight = containerSize.height;
    containerWidth = containerSize.width;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: GestureDetector(
            onPanStart: (DragStartDetails details) {
              controller.stop();
              controller.reset();
              currentOffset = Offset(details.globalPosition.dx - left,
                  details.globalPosition.dy - top);
            },
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                position = details;
              });
              double newTop = (position.globalPosition.dy - (currentOffset.dy));
              double newLeft =
                  (position.globalPosition.dx - (currentOffset.dx));
              top = (newTop <= 0 && newTop >= (screenHeight - containerHeight))
                  ? newTop
                  : top;
              left = (newLeft <= 0 && newLeft >= (screenWidth - containerWidth))
                  ? newLeft
                  : left;
            },
            onPanEnd: (DragEndDetails details) {
              controller.reset();
              animation = Tween<Offset>(
                      begin: details.velocity.pixelsPerSecond,
                      end: Offset(0, 0))
                  .animate(controller)
                    ..addListener(
                      () {
                        setState(
                          () {
                            double newTop = top + animation.value.dy * 0.002;
                            double newLeft = left + animation.value.dx * 0.002;
                            top = (newTop <= 0 &&
                                    newTop >= (screenHeight - containerHeight))
                                ? newTop
                                : top;
                            left = (newLeft <= 0 &&
                                    newLeft >= (screenWidth - containerWidth))
                                ? newLeft
                                : left;
                          },
                        );
                      },
                    );

              controller.forward();
            },
            child: Container(
              key: _keyContainer,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  TilesList(),
                  TilesList(),
                  TilesList(),
                  TilesList(),
                  TilesList(),
                  TilesList(),
                  TilesList(),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
