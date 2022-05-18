import 'package:example/constants.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

/// 菜单项
/// 最小高度为 [kMinInteractiveDimension]
class ItemMenuOption extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const ItemMenuOption({Key? key, this.onChanged}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemMenuOptionState();
}

class _ItemMenuOptionState extends State<ItemMenuOption> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Column(
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '快捷筛选',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '分类',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 行政区
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: menuOptions.length,
                      itemBuilder: (_, index) => _itemAddress(
                        menuOptions[index],
                      ),
                    ),
                  ),

                  /// 机构
                  Expanded(
                    child: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: _values?.isEmpty ?? true
                          ? const Center(
                              child: Icon(
                                Icons.image_search,
                                size: 64,
                                color: Color(0xA8000000),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _values?.length ?? 0,
                              itemBuilder: (_, index) => _itemOrg(
                                _values![index],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _option;
  List<String>? _values;

  @override
  void initState() {
    super.initState();
    _option = menuOptions.first;
    _values = menuValues[_option];
  }

  /// 行政区
  Widget _itemAddress(String address) {
    final select = _option == address;
    return Material(
      color: select
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).backgroundColor,
      child: InkWell(
        onTap: () {
          setState(() {
            _option = address;
            _values = menuValues[_option];
          });
        },
        child: ItemMenuString(label: address, select: select),
      ),
    );
  }

  /// 机构
  Widget _itemOrg(String value) {
    return InkWell(
      onTap: () {
        widget.onChanged?.call('$_option$value');
        Navigator.pop(context);
      },
      child: ItemMenuString(label: value, showIndicator: false),
    );
  }
}
