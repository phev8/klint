import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class SingleChoiceWidget extends StatefulWidget {
  static const double itemHeight = 42.0;
  final List<Tuple2<String, String>> options;
  final Function(String? value) onChanged;
  final String? initiallySelected;

  SingleChoiceWidget(this.options, this.initiallySelected, this.onChanged);

  double calculateHeight() => itemHeight * options.length;

  @override
  State<StatefulWidget> createState() => _SingleChoiceWidgetState();
}

class _SingleChoiceWidgetState extends State<SingleChoiceWidget> {
  String? _selected;

  @override
  initState() {
    super.initState();
    _selected = widget.initiallySelected;
  }

  Widget _option(Tuple2<String, String> option) {
    return Container(
      height: SingleChoiceWidget.itemHeight,
      alignment: Alignment.centerLeft,
      child: RadioListTile<String>(
        title: Transform.translate(
          offset: Offset(-16, 0),
          child: Text(option.item2),
        ),
        value: option.item1,
        groupValue: _selected,
        toggleable: true,
        onChanged: (String? value) {
          setState(() {
            _selected = value;
            widget.onChanged(value);
          });
        },
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...widget.options.map((element) => _option(element))],
    );
  }
}
