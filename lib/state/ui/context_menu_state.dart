import 'package:flutter/material.dart';
import 'package:klint/state/ui/mouse_state.dart';
import 'package:klint/ui/context_menus/debug_context_menu.dart';
import 'package:klint/ui/widgets/tapable_overlay.dart';
import 'package:provider/provider.dart';

class ContextMenuState extends ChangeNotifier {
  List<Widget> _contextMenus = [];
  get contextMenus => _contextMenus;

  _openContextMenu(Widget menu, Offset position) {
    Widget contextMenu = Stack(
      children: <Widget>[
        Positioned.fill(
          child: TapableOverlay(
            onTap: _closeContextMenu,
          ),
        ),
        Positioned(
          left: position.dx,
          top: position.dy,
          child: menu,
        ),
      ],
    );

    _contextMenus.add(contextMenu);
    notifyListeners();
  }

  _closeContextMenu() {
    _contextMenus.removeLast();
    notifyListeners();
  }

  openDebugMenu(BuildContext context) {
    _openContextMenu(DebugContextMenu(), context.read<MouseState>().position);
  }
}
