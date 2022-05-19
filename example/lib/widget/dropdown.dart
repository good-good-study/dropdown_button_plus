import 'package:dropdown_button_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'menu.dart';
import 'option.dart';

/// 条件筛选
class DropdownPlusView extends StatefulWidget {
  final ValueChanged? onOption;
  final ValueChanged? onType;
  final ValueChanged? onStatus;

  const DropdownPlusView({
    Key? key,
    this.onOption,
    this.onType,
    this.onStatus,
  }) : super(key: key);

  @override
  State<DropdownPlusView> createState() => _DropdownPlusViewState();
}

class _DropdownPlusViewState extends State<DropdownPlusView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 综合排序
            DropdownView<String>(
              onChanged: widget.onType,
              forceWidth: true,
              isDropdown: true,
              isOutsideShadow: true,
              isPinnedSelected: false,
              items: filterSort,
              itemBuilder: (_, index, select) => ItemMenuString(
                label: filterSort[index],
                select: select,
              ),
              selectedItemBuilder: (_, index, select) => ItemMenuHeader(
                label: '综合排序',
                select: select,
              ),
              hintBuilder: (context, focus) => hintWidgetBuilder(
                context,
                focus,
                '综合排序',
              ),
            ),

            /// 对账单
            SizedBox(
              height: kMinInteractiveDimension,
              child: DropdownView<String>(
                forceWidth: true,
                isDropdown: true,
                isOutsideShadow: true,
                isPinnedSelected: false,
                itemPadding: EdgeInsets.zero,
                itemHeight: MediaQuery.of(context).size.height / 2,
                menuMaxHeight: MediaQuery.of(context).size.height / 2,
                items: const [''],
                itemBuilder: (_, index, select) => ItemMenuOption(
                  onChanged: widget.onOption,
                ),
                selectedItemBuilder: (_, index, select) => ItemMenuHeader(
                  label: '对账单',
                  select: select,
                ),
                hintBuilder: (context, focus) => hintWidgetBuilder(
                  context,
                  focus,
                  '对账单',
                  padding:
                      const EdgeInsets.only(top: kMinInteractiveDimension / 8),
                ),
              ),
            ),

            /// 商家特色
            DropdownView<String>(
              onChanged: widget.onStatus,
              forceWidth: true,
              isDropdown: true,
              isOutsideShadow: true,
              isPinnedSelected: false,
              items: filterStatus,
              itemBuilder: (_, index, select) => ItemMenuString(
                label: filterStatus[index],
                select: select,
              ),
              selectedItemBuilder: (_, index, select) => ItemMenuHeader(
                label: '商家特色',
                select: select,
              ),
              hintBuilder: (context, focus) => hintWidgetBuilder(
                context,
                focus,
                '商家特色',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
