import 'dart:math';

import 'package:flutter/material.dart';
import 'package:klint/ui/context_menus/context_menu_items/context_menu_item.dart';

class DebugItem extends ContextMenuItem {
  final double _height = 40;

  @override
  Widget build(BuildContext context) {
    Random r = Random();
    return Container(height: _height, color: Color.fromRGBO(r.nextInt(255), r.nextInt(255), r.nextInt(255), 1.0));
  }

  @override
  calculateHeight() => _height;
}
