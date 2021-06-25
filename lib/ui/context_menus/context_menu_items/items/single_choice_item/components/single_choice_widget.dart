import 'package:flutter/material.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';
import 'package:klint/ui/widgets/tile_title.dart';
import 'package:tuple/tuple.dart';

class SingleChoiceWidget extends StatefulWidget {
  final List<Tuple2<String, String>> options;
  final String? initiallySelected;
  final Function(String? value) onChanged;

  SingleChoiceWidget(this.options, this.initiallySelected, this.onChanged);

  double calculateHeight() => KlintThemeData.tileItemHeight * options.length;

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
      height: KlintThemeData.tileItemHeight,
      alignment: Alignment.centerLeft,
      child: RadioListTile<String>(
        title: TileTitle(option.item2),
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
