import 'package:flutter/material.dart';
import 'package:klint/state/ui/context_menu_state.dart';
import 'package:klint/state/ui/mouse_state.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';
import 'package:klint/ui/widgets/tapable_overlay.dart';
import 'package:provider/provider.dart';

import 'context_menu_items/context_menu_item.dart';

class ContextMenu extends StatefulWidget {
  final List<ContextMenuItem> items;
  final Offset? position;

  ContextMenu(this.items, [this.position]);

  onOpen() {}
  onClose() {}

  @override
  _ContextMenuState createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  double _height = 0;
  Offset _position = Offset.zero;

  double get width => KlintThemeData.contextMenuWidth;
  double get height => _height;

  @override
  initState() {
    super.initState();
    widget.items.forEach((item) => _height += item.calculateHeight());
    _height += KlintThemeData.contextMenuPadding * 2;
    _position = widget.position ?? context.read<MouseState>().position;
  }

  Widget _menu() {
    return SizedBox(
      width: KlintThemeData.contextMenuWidth,
      child: Container(
        color: Colors.grey.shade800,
        child: Padding(
          padding: const EdgeInsets.all(KlintThemeData.contextMenuPadding),
          child: Column(
            children: widget.items,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget menuWidget = _menu();
    Size window = MediaQuery.of(context).size;

    double? left;
    double? top;
    double? right;
    double? bottom;

    if (_position.dx + KlintThemeData.contextMenuWidth > window.width) {
      right = 0;
    } else {
      left = _position.dx;
    }

    if (_height > window.height) {
      top = 0;
      bottom = 0;

      menuWidget = SingleChildScrollView(child: menuWidget);
    } else {
      if (_position.dy + _height > window.height) {
        bottom = 0;
      } else {
        top = _position.dy;
      }
    }

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: TapableOverlay(
            onTap: () {
              context.read<ContextMenuState>().closeContextMenu();
            },
          ),
        ),
        Positioned(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          child: menuWidget,
        ),
      ],
    );
  }
}
