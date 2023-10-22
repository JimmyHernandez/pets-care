import 'package:flutter/material.dart';

class FlipcardWidget extends StatefulWidget {
  final Widget frontWidget;
  final Widget backWidget;

  FlipcardWidget({
    required this.frontWidget,
    required this.backWidget,
  });

  @override
  _FlipcardWidgetState createState() => _FlipcardWidgetState();
}

class _FlipcardWidgetState extends State<FlipcardWidget> {
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
