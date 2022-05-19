# A Flutter material DropdownButton Plus package.

Getting started 🍺:

Add the flowing to your `pubspec.yaml`:

```java
dependencies:
  dropdown_button_plus: any
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
  ),
),
```

## Plus : 
### 1.dropdown at button with shadow.
```java
plus.DropdownView<String>(
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
),
```

![plus basic](https://upload-images.jianshu.io/upload_images/16981996-78926ba2e8552dc4.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/375)


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
  ),
),
```

![plus_customize](https://upload-images.jianshu.io/upload_images/16981996-36eb8052da1215d7.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/375)
