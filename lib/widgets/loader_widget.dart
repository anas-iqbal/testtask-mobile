import 'package:flutter/material.dart';

class LoaderWidget extends StatefulWidget {
  final bool isTrue;
  final Widget child;
  const LoaderWidget({required this.isTrue, required this.child, Key? key})
      : super(key: key);

  @override
  _LoaderWidget createState() => _LoaderWidget();
}

class _LoaderWidget extends State<LoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    offset = Tween<Offset>(
            begin: const Offset(0.0, -2.0), end: const Offset(0.0, 4.5))
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isTrue) {
      controller.forward();
    } else {
      controller.reverse();
    }
    return AbsorbPointer(
      absorbing: widget.isTrue,
      child: Stack(
        children: <Widget>[
          Container(child: widget.child),
          Align(
            alignment: const Alignment(0.0, -1.2),
            child: SlideTransition(
              position: offset,
              child: const RefreshProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xff151646),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
