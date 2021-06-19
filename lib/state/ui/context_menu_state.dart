import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu.dart';

class ContextMenuState extends ChangeNotifier {
  List<Widget> _contextMenus = [];
  List<Widget> get contextMenus => _contextMenus;

  openContextMenu(ContextMenu menu) {
    _contextMenus.add(menu);
    notifyListeners();
  }

  closeContextMenu() {
    _contextMenus.removeLast();
    notifyListeners();
  }
}
