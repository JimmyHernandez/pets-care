import 'package:flutter/material.dart';

class FlipCardWidget extends StatefulWidget {
  final Widget frontWidget;
  final Widget backWidget;

  const FlipCardWidget({super.key,
    required this.frontWidget,
    required this.backWidget,
  });

  @override
  FlipCardWidgetState createState() => FlipCardWidgetState();
}

class FlipCardWidgetState extends State<FlipCardWidget> {
  bool _isFlipped = false;

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFlip,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _isFlipped ? widget.backWidget : widget.frontWidget,
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
      ),
    );
  }
}
