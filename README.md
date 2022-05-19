# A Flutter material DropdownButton Plus package.

Getting started 🍺:

Add the flowing to your `pubspec.yaml`:

```java
dependencies:
  dropdown_button_plus: 0.0.2
```
## import

`import 'package:dropdown_button_plus/dropdown_plus.dart' as plus;`

## Basic:
The same usage as the DropdownButton of flutter sdk.

```java
plus.DropdownView<String>(
  items: filters,
  itemPadding: EdgeInsets.zero,
  itemBuilder: (_, index, select) => ItemMenuString(
    label: filters[index],
    select: select,
    showIndicator: false,
    mainAxisAlignment: MainAxisAlignment.center,
  ),
  selectedItemBuilder: (_, index, select) => ItemMenuHeader(
    label: filters[index],
    select: select,
  ),
  hintBuilder: (context, focus) => hintWidgetBuilder(
    context,
    focus,
    'Dropdown',
  ),
),
```
![basic](https://github.com/good-good-study/dropdown_button_plus/blob/master/example/ui/basic.jpg)


## Plus Pinned:

```java
plus.DropdownView<String>(
  isDropdown: true,
  items: filters,
  itemPadding: EdgeInsets.zero,
  itemBuilder: (_, index, select) => ItemMenuString(
    label: filterStatus[index],
    select: select,
    showIndicator: false,
    mainAxisAlignment: MainAxisAlignment.center,
  ),
  selectedItemBuilder: (_, index, select) => ItemMenuHeader(
    label: filters[index],
    select: select,
  ),
  hintBuilder: (context, focus) => hintWidgetBuilder(
    context,
    focus,
    'Pinned',
  ),
),
```
![pinned](https://github.com/good-good-study/dropdown_button_plus/blob/master/example/ui/pinned.png)


## Plus : dropdown at button with shadow.

```java
plus.DropdownView<String>(
  onChanged: widget.onType,
  forceWidth: true,
  isDropdown: true,
  isOutsideShadow: true,
  isPinnedSelected: false,
  items: filters,
  itemBuilder: (_, index, select) => ItemMenuString(
    label: filters[index],
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
```

![pinned](https://github.com/good-good-study/dropdown_button_plus/blob/master/example/ui/plus_basic.png)


### 2.customize

```java
SizedBox(
  height: kMinInteractiveDimension,
  child: DropdownView<String>(
    forceWidth: true,
    isDropdown: true,
    isOutsideShadow: true,
    isPinnedSelected: false,
    itemPadding: EdgeInsets.zero,
    itemHeight: MediaQuery.of(context).size.height / 2,
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
      padding: const EdgeInsets.only(top: kMinInteractiveDimension / 8),
    ),
  ),
),
```

![pinned](https://github.com/good-good-study/dropdown_button_plus/blob/master/example/ui/plus_custom.png)
