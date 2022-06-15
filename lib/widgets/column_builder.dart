import 'package:flutter/material.dart';

class ColumnBuilder extends StatelessWidget {
  const ColumnBuilder({
    required this.itemBuilder,
    required this.itemCount,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection = TextDirection.ltr,
    this.mainAxisSize = MainAxisSize.max,
    this.topWidget,
    this.botWidget,
    Key? key,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final VerticalDirection verticalDirection;
  final TextDirection textDirection;
  final MainAxisSize mainAxisSize;
  final Widget? topWidget, botWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topWidget ?? const SizedBox(),
        Column(children: List.generate(itemCount, (index) => itemBuilder(context, index)).toList()),
        botWidget ?? const SizedBox(),
      ],
    );
  }
}
