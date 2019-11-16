import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressLoading extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final Color containerColor;
  final double borderRadius;
  final String text;
  final bool loading;
  // final _ProgressLoadingState _state = _ProgressLoadingState();

  // _ProgressLoadingState get state => _state;

  ProgressLoading({
    Key key,
    this.backgroundColor = Colors.black54,
    this.color = Colors.white,
    this.containerColor = Colors.transparent,
    this.borderRadius = 10.0,
    this.text,
    this.loading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return empty widget
    if (!loading)
      return Container();
    else
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                ),
              ),
            ),
            Center(
                child: Opacity(
                    opacity: 0.5,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        width: 70,
                        height: 70,
                        child: CupertinoActivityIndicator(animating: true))))
          ],
        ),
      );
  }
}
