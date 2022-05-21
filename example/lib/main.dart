import 'dart:developer';

import 'package:dropdown_button_plus/dropdown_plus.dart' as plus;
import 'package:example/constants.dart';
import 'package:example/widget/dropdown.dart';
import 'package:flutter/material.dart';

import 'widget/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primarySwatch: Colors.green,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xF5F5F5F5),
      ),
      home: const DropdownPage(title: 'DropdownButton Plus'),
    );
  }
}

/// Plus: [DropdownPlusView]
/// Flutter SDK Material : [DropdownButton]
class DropdownPage extends StatefulWidget {
  const DropdownPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DropdownPage> createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Basic Flutter SDK Material DropdownButton
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Basic: DropdownButton',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            Material(
              color: Theme.of(context).backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  plus.DropdownView<String>(
                    items: filterSort,
                    itemPadding: EdgeInsets.zero,
                    itemBuilder: (_, index, select) => ItemMenuString(
                      label: filterSort[index],
                      select: select,
                      showIndicator: false,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    selectedItemBuilder: (_, index, select) => ItemMenuHeader(
                      label: filterSort[index],
                      select: select,
                    ),
                    hintBuilder: (context, focus) => HintWidgetBuilder(
                      'Dropdown',
                      focus: focus,
                    ),
                  ),
                  plus.DropdownView<String>(
                    isDropdown: true,
                    items: filterStatus,
                    itemPadding: EdgeInsets.zero,
                    itemBuilder: (_, index, select) => ItemMenuString(
                      label: filterStatus[index],
                      select: select,
                      showIndicator: false,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    selectedItemBuilder: (_, index, select) => ItemMenuHeader(
                      label: filterStatus[index],
                      select: select,
                    ),
                    hintBuilder: (context, focus) => HintWidgetBuilder(
                      'Pinned',
                      focus: focus,
                    ),
                  ),
                ],
              ),
            ),

            /// Plus
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Plus:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            DropdownPlusView(
              onType: _onType,
              onOption: _onOption,
              onStatus: _onStatus,
            ),
          ],
        ),
      ),
    );
  }

  void _onType(value) {
    log('$value');
  }

  void _onStatus(value) async {
    log('$value');
  }

  void _onOption(value) {
    log('$value');
  }
}
