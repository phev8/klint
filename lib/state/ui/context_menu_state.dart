import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu.dart';

class ContextMenuState extends ChangeNotifier {
  List<ContextMenu> _contextMenus = [];
  List<ContextMenu> get contextMenus => _contextMenus;

  openContextMenu(ContextMenu menu) {
    menu.onOpen();
    _contextMenus.add(menu);
    notifyListeners();
  }

  closeContextMenu() {
    if (_contextMenus.isNotEmpty) {
      _contextMenus.last.onClose();
      _contextMenus.removeLast();
      notifyListeners();
    }
  }
}
