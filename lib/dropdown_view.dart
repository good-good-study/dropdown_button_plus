import 'dart:math';

import 'package:dropdown_button_plus/dropdown.dart' as menu;
import 'package:flutter/material.dart';

typedef MenuIndexedWidgetBuilder = Widget Function(
  BuildContext context,
  int index,
  bool select,
);

typedef MenuFocusWidgetBuilder = Widget Function(
  BuildContext context,
  bool hasFocus,
);

/// DropdownView
class DropdownView<T> extends StatefulWidget {
  final bool isDropdown;
  final bool forceWidth;
  final T? initValue;
  final List<T> items;

  /// item Padding
  final EdgeInsets? itemPadding;
  final double? itemHeight;
  final double? menuMaxHeight;

  /// item选中背景色
  final Color? itemBackgroundColor;

  /// item未选中背景色
  final Color? unselectItemBackgroundColor;

  /// menu背景色
  final Color? dropdownColor;
  final int elevation;
  final BorderRadius? borderRadius;

  /// 当选中了一个item后，再次显示时，是否优先固定展示此项，默认为是,Flutter SDK默认效果。
  final bool? isPinnedSelected;

  /// 内容区域外，是否绘制背景层。
  final bool isOutsideShadow;

  /// [DropdownButton.icon]
  final Widget? icon;
  final Widget? iconSelect;
  final MenuFocusWidgetBuilder? hintBuilder;
  final Widget? disabledHint;

  final VoidCallback? onTap;
  final ValueChanged<T>? onChanged;
  final MenuIndexedWidgetBuilder itemBuilder;
  final MenuIndexedWidgetBuilder? selectedItemBuilder;

  const DropdownView({
    Key? key,
    this.initValue,
    required this.items,
    required this.itemBuilder,
    this.selectedItemBuilder,
    this.onTap,
    this.onChanged,
    this.itemPadding,
    this.itemBackgroundColor,
    this.unselectItemBackgroundColor,
    this.itemHeight,
    this.menuMaxHeight,
    this.isDropdown = false,
    this.forceWidth = false,
    this.isPinnedSelected,
    this.isOutsideShadow = false,
    this.dropdownColor,
    this.borderRadius,
    this.hintBuilder,
    this.disabledHint,
    this.icon,
    this.iconSelect,
    int elevation = 8,
  })  : elevation = isOutsideShadow ? 0 : elevation,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _DropdownViewState<T>();
}

class _DropdownViewState<T> extends State<DropdownView<T>> {
  /// 限定Menu最大高度为屏幕高度的一半。
  double maxHeight() {
    if (widget.menuMaxHeight != null) {
      return min(
        MediaQuery.of(context).size.height / 2,
        widget.menuMaxHeight!,
      );
    }
    return min(
      MediaQuery.of(context).size.height / 2,
      widget.items.length * (widget.itemHeight ?? kMinInteractiveDimension),
    );
  }

  Color get _unselectItemBackgroundColor {
    return widget.unselectItemBackgroundColor ??
        Theme.of(context).backgroundColor;
  }

  Color get _itemBackgroundColor {
    return widget.itemBackgroundColor ??
        Theme.of(context).scaffoldBackgroundColor;
  }

  /// select color
  Color? get color => _toggle ? Theme.of(context).primaryColor : null;

  /// finally icon
  Widget? get _icon {
    if (widget.icon != null && widget.iconSelect != null) {
      return _toggle ? widget.iconSelect : widget.icon;
    }
    return Icon(
      _toggle ? Icons.arrow_drop_up : Icons.arrow_drop_down,
      color: color,
    );
  }

  /// 焦点状态
  bool _toggle = false;

  /// 记录点击事件是否来自于本身。
  bool isInEffect = false;

  /// 焦点侦测器
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode!.addListener(_handleFocus);
  }

  @override
  void dispose() {
    _focusNode?.removeListener(_handleFocus);
    _focusNode?.dispose();
    super.dispose();
  }

  /// 处理菜单按钮的焦点问题：
  /// 菜单从显示到消失的执行流程：
  /// step1：触发点击事件： _onTap
  /// step2：回调_handleFocus： hasFocus-> true
  /// step3：显示弹出菜单，然后回调_handleFocus：hasFocus-> false
  /// step4：step1：关闭弹出菜单，回调_handleFocus：hasFocus-> true
  ///
  void _handleFocus() {
    // 当前菜单按钮的焦点状态
    final hasFocus = _focusNode?.hasPrimaryFocus ?? true;

    // 处于step3时，菜单已经弹出来了，可以进行icon和字体的颜色变更等操作了。
    if (!hasFocus && isInEffect) {
      isInEffect = false;
      _toggle = true;
      setState(() {});
      return;
    }

    // 触发时机：
    // 1. 当自身处于step4时，此时菜单已经关闭了，可以进行icon和字体的恢复操作了。
    // 2. 当前菜单处于焦点状态时(例如step4)，如果点击了其他按钮，会触发当前菜单失去焦点的事件。
    if (!isInEffect) {
      if (_toggle) {
        setState(() => _toggle = false);
      }
      return;
    }
    // 处理来自于按钮自身的事件，例如step2
    if (_toggle != hasFocus) {
      setState(() => _toggle = hasFocus);
    }
  }

  /// 按钮：菜单触发器点击事件
  void _onTap() {
    widget.onTap?.call();
    isInEffect = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: _DropdownMenu<T>(
        isDropdown: widget.isDropdown,
        forceWidth: widget.forceWidth,
        isPinnedSelected: widget.isPinnedSelected,
        isOutsideShadow: widget.isOutsideShadow,
        focusNode: _focusNode,
        isToggle: _toggle,
        dropdownColor: const Color(0x80000000),
        itemBackgroundColor: _itemBackgroundColor,
        unselectItemBackgroundColor: _unselectItemBackgroundColor,
        initValue: widget.initValue,
        items: widget.items,
        itemBuilder: widget.itemBuilder,
        selectedItemBuilder: widget.selectedItemBuilder,
        itemHeight: widget.itemHeight,
        itemPadding: widget.itemPadding,
        elevation: widget.elevation,
        borderRadius: widget.borderRadius,
        menuMaxHeight: maxHeight(),
        onTap: _onTap,
        onChanged: widget.onChanged,
        hint: widget.hintBuilder,
        disabledHint: widget.disabledHint,
        icon: _icon,
      ),
    );
  }
}

class _DropdownMenu<T> extends StatefulWidget {
  final T? initValue;
  final List<T> items;
  final bool isDropdown;
  final bool forceWidth;
  final MenuIndexedWidgetBuilder itemBuilder;
  final MenuIndexedWidgetBuilder? selectedItemBuilder;
  final MenuFocusWidgetBuilder? hint;
  final Widget? disabledHint;
  final Widget? icon;
  final double? menuMaxHeight;
  final double? itemHeight;

  /// item选中背景色
  final Color? itemBackgroundColor;

  /// item未选中背景色
  final Color? unselectItemBackgroundColor;

  /// item Padding
  final EdgeInsets? itemPadding;

  /// 当选中了一个item后，再次显示时，是否优先固定展示此项，默认为是,Flutter SDK默认效果。
  final bool? isPinnedSelected;

  /// 内容区域外，是否绘制背景层。
  final bool isOutsideShadow;

  /// menu背景色
  final Color? dropdownColor;
  final int elevation;
  final BorderRadius? borderRadius;

  final bool isToggle;

  final FocusNode? focusNode;

  final VoidCallback? onTap;

  final ValueChanged<T>? onChanged;

  const _DropdownMenu({
    Key? key,
    this.initValue,
    required this.items,
    required this.itemBuilder,
    this.selectedItemBuilder,
    this.icon,
    this.hint,
    this.disabledHint,
    this.isDropdown = false,
    this.forceWidth = false,
    this.isOutsideShadow = false,
    this.isPinnedSelected,
    this.menuMaxHeight,
    this.itemHeight,
    this.itemPadding,
    this.itemBackgroundColor,
    this.unselectItemBackgroundColor,
    this.dropdownColor,
    this.elevation = 8,
    this.borderRadius,
    this.isToggle = false,
    this.focusNode,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  State<_DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState<T> extends State<_DropdownMenu> {
  /// 当前选中的 menu
  T? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return menu.DropdownButton<T>(
      isDropdown: widget.isDropdown,
      forceWidth: widget.forceWidth,
      hint: widget.hint == null ? null : widget.hint!(context, widget.isToggle),
      disabledHint: widget.disabledHint,
      value: dropdownValue,
      icon: widget.icon,
      focusNode: widget.focusNode,
      underline: const SizedBox(),
      onTap: widget.onTap,
      onChanged: _onChanged,
      borderRadius: widget.borderRadius ?? buildBorderRadius(),
      elevation: widget.elevation,
      menuMaxHeight: widget.menuMaxHeight,
      itemHeight: widget.itemHeight,
      itemPadding: widget.itemPadding,
      isPinnedSelected: widget.isPinnedSelected,
      isOutsideShadow: widget.isOutsideShadow,
      dropdownColor: widget.dropdownColor,
      itemBackgroundColor: widget.itemBackgroundColor,
      unselectItemBackgroundColor: widget.unselectItemBackgroundColor,
      selectedItemBuilder: (_) => selectedItems(),
      items: items(),
    );
  }

  BorderRadius buildBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(widget.isDropdown ? 2 : 8),
      topRight: Radius.circular(widget.isDropdown ? 2 : 8),
      bottomLeft: const Radius.circular(12),
      bottomRight: const Radius.circular(12),
    );
  }

  /// 切换选项
  void _onChanged(T? newValue) {
    widget.onChanged?.call(newValue);
    setState(() {
      dropdownValue = newValue;
    });
  }

  /// 选中的菜单
  List<menu.DropdownMenuItem<T>> selectedItems() {
    if (widget.selectedItemBuilder == null) {
      return <menu.DropdownMenuItem<T>>[];
    }
    return widget.items.map((value) {
      return menu.DropdownMenuItem<T>(
        value: value,
        child: Builder(
          builder: (context) => widget.selectedItemBuilder!(
            context,
            widget.items.indexOf(value),
            widget.isToggle,
          ),
        ),
      );
    }).toList();
  }

  /// 菜单
  List<menu.DropdownMenuItem<T>> items() {
    return widget.items.map((value) {
      return menu.DropdownMenuItem<T>(
        value: value,
        child: Builder(
          builder: (context) => widget.itemBuilder(
            context,
            widget.items.indexOf(value),
            dropdownValue == value,
          ),
        ),
      );
    }).toList();
  }
}
