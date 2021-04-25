import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:klint/state/ui/mouse_state.dart';
import 'package:provider/provider.dart';

class MouseProvider extends StatelessWidget {
  final Widget child;
  final MouseCursor? mouseCursor;

  const MouseProvider({Key? key, required this.child, this.mouseCursor}) : super(key: key);

  void onMove(BuildContext context, PointerEvent event) {
    context.read<MouseState>().position = event.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MouseState(),
      builder: (context, _) => MouseRegion(
        onHover: (event) => onMove(context, event),
        onEnter: (_) => context.read<MouseState>().isPresent = true,
        onExit: (_) => context.read<MouseState>().isPresent = false,
        cursor: mouseCursor ?? MouseCursor.defer,
        opaque: false,
        child: Listener(
          // TODO: Remove this once MouseRegion has this feature.
          onPointerMove: (event) => onMove(context, event),
          behavior: HitTestBehavior.translucent,
          child: child,
        ),
      ),
    );
  }
}
