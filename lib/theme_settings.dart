
import 'package:flutter/material.dart';
import 'package:persist_theme/persist_theme.dart';
import "package:provider/provider.dart";
import 'package:persist_theme/data/models/theme_model.dart';

class ThemeSettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeModel>(context);
//    final TextStyle textStyle = TextStyle(color: _theme.textColor);
    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        title: const Text("Theme"),
      ),
      body: Container(
        child: ListView(
          children: MediaQuery.of(context).size.width >= 480
              ? <Widget>[
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Flexible(child: DarkModeSwitch()),
                    Flexible(child: TrueBlackSwitch()),
                  ],
                ),
//                CustomThemeSwitch(),
//                Flex(
//                  direction: Axis.horizontal,
//                  children: <Widget>[
//                    Flexible(child: PrimaryColorPicker()),
//                    Flexible(child: AccentColorPicker()),
//                  ],
//                ),
//                DarkAccentColorPicker(),
              ]
              : <Widget>[
            DarkModeSwitch(),
            TrueBlackSwitch(),
//            CustomThemeSwitch(),
//            PrimaryColorPicker(),
//            AccentColorPicker(),
//            DarkAccentColorPicker(),
          ],
        ),
      ),
    );
  }
}