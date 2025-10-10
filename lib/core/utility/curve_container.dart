import 'package:flutter/material.dart';

class CurvedWhiteContainer extends StatelessWidget {
  final Widget? child;
  final double borderRadius;
  final double padding;

  const CurvedWhiteContainer({
    Key? key,
    this.child,
    this.borderRadius = 12.0,
    this.padding = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
        ),
    );
  }
}
