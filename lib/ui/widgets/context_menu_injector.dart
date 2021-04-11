import 'package:flutter/material.dart';
import 'package:klint/state/ui/context_menu_state.dart';
import 'package:provider/provider.dart';

class ContextMenuInjector extends StatelessWidget {
  final Widget child;

  const ContextMenuInjector({Key key, this.child}) : super(key: key);

  Widget _contextMenus() {
    return Consumer<ContextMenuState>(builder: (_, contextMenus, __) {
      return Stack(
        children: [...contextMenus.contextMenus],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContextMenuState(),
      child: Stack(
        children: <Widget>[
          child,
          _contextMenus(),
        ],
      ),
    );
  }
}
