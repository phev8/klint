import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:klint/state/ui/mouse_state.dart';
import 'package:provider/provider.dart';

class MouseProvider extends StatelessWidget {
  final Widget child;

  const MouseProvider({Key key, this.child}) : super(key: key);

  void onHover(BuildContext context, PointerHoverEvent event) {
    Provider.of<MouseState>(context, listen: false).position = event.position;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MouseState(),
      builder: (context, _) => MouseRegion(
        onHover: (PointerHoverEvent event) => onHover(context, event),
        child: child,
      ),
    );
  }
}
