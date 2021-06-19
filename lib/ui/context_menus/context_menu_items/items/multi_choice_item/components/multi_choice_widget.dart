import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class MultiChoiceWidget extends StatefulWidget {
  static const double itemHeight = 42.0;
  final List<Tuple2<String, String>> options;
  final List<String> initiallySelected;
  final Function(String value) onSelected;
  final Function(String value) onDeselected;

  MultiChoiceWidget(this.options, this.initiallySelected, this.onSelected, this.onDeselected);

  double calculateHeight() => itemHeight * options.length;

  @override
  State<StatefulWidget> createState() => _MultiChoiceWidgetState();
}

class _MultiChoiceWidgetState extends State<MultiChoiceWidget> {
  List<bool> _selected = [];

  @override
  initState() {
    super.initState();
    widget.options.forEach((option) {
      _selected.add(widget.initiallySelected.contains(option.item1));
    });
  }

  Widget _option(int i, Tuple2<String, String> option) {
    return Container(
      height: MultiChoiceWidget.itemHeight,
      alignment: Alignment.centerLeft,
      child: CheckboxListTile(
        title: Transform.translate(
          offset: Offset(-16, 0),
          child: Text(option.item2),
        ),
        value: _selected[i],
        onChanged: (bool? itemSelected) {
          if (itemSelected == null) return;

          setState(() {
            _selected[i] = itemSelected;

            if (itemSelected) {
              widget.onSelected(option.item1);
            } else {
              widget.onDeselected(option.item1);
            }
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> optionItems = [];

    for (int i = 0; i < widget.options.length; i++) {
      optionItems.add(_option(i, widget.options[i]));
    }

    return Column(
      children: optionItems,
    );
  }
}
