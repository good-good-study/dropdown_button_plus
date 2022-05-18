import 'package:flutter/material.dart';

/// 菜单一级分类
class ItemMenuHeader extends StatelessWidget {
  final String label;
  final bool select;

  const ItemMenuHeader({
    Key? key,
    required this.label,
    this.select = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        color: select ? Theme.of(context).primaryColor : null,
      ),
    );
  }
}

/// 菜单项
/// 最小高度为 [kMinInteractiveDimension]
class ItemMenuString extends StatelessWidget {
  final String label;
  final bool select;
  final bool showIndicator;
  final MainAxisAlignment mainAxisAlignment;

  const ItemMenuString({
    Key? key,
    required this.label,
    this.select = false,
    this.showIndicator = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        if (showIndicator)
          Container(
            width: 3,
            height: kMinInteractiveDimension,
            color: select ? Theme.of(context).primaryColor : Colors.transparent,
          )
        else
          const SizedBox(height: kMinInteractiveDimension),

        ///
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: select ? Theme.of(context).primaryColor : null,
            ),
          ),
        ),
      ],
    );
  }
}
