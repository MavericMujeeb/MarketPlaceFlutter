import 'package:flutter/material.dart';

import 'circle_page_indicator.dart';

class CirclePageIndicatorHome extends StatefulWidget {
  const CirclePageIndicatorHome({super.key});

  @override
  CirclePageIndicatorHomeState createState() {
    return CirclePageIndicatorHomeState();
  }
}

class CirclePageIndicatorHomeState extends State<CirclePageIndicatorHome> {
  final _items = [
    Icon(Icons.image,color: Colors.blue),
    Icon(Icons.image,color: Colors.blue),
    Icon(Icons.image,color: Colors.blue),
    Icon(Icons.image,color: Colors.blue),
    Icon(Icons.image,color: Colors.blue)
  ];
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _boxHeight = 180.0;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
      //appBar: CustomAppBar('Product Name', bgColor: Colors.blue, titleColor: Colors.black),
      //body:_buildBody() ,
    //);
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            _buildPageView(),
            _buildCircleIndicator(),
          ],
        ),
      ],
    );
  }

  _buildPageView() {
    return Container(
      color: const Color(0xFFE3F2FD),
      height: _boxHeight,
      child: PageView.builder(
          itemCount: _items.length,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Icon(
                Icons.image,
                color: Colors.blue[200],
                // _items[index],
                size: 50.0,
              ),
            );
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
    );
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: _items.length,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }
  }

