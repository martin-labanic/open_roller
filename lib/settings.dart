import "package:flutter/material.dart";
import "package:flutter_material_color_picker/flutter_material_color_picker.dart";
import "package:open_roller/preferences_state.dart";
import 'package:open_roller/theme_settings.dart';
import 'package:persist_theme/persist_theme.dart';
import "package:provider/provider.dart";

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<PreferencesState>(context);
    final _theme = Provider.of<ThemeModel>(context);
    TextStyle textStyle = TextStyle(color: _theme.textColor);
    return Scaffold(
        backgroundColor: _theme.backgroundColor,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Settings"),
        ),
        body: Container(

//          width: MediaQuery.of(context).size.width,
//          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(14),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text("reset modifier after roll", style: textStyle)
                  ),
                  Expanded(
                    flex: 1,
                    child: Switch(
                      onChanged: (value) {
                        preferences.resetModifierAfterRoll = value;
                      },
                      value: preferences.resetModifierAfterRoll,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text("reset modifier after add", style: textStyle)
                  ),
                  Expanded(
                    flex: 1,
                    child: Switch(
                      onChanged: (value) {
                        preferences.resetModifierAfterAdd = value;
                      },
                      value: preferences.resetModifierAfterAdd,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text("reset # of dice after roll", style: textStyle)
                  ),
                  Expanded(
                    flex: 1,
                    child: Switch(
                      onChanged: (value) {
                        preferences.resetNumberOfDiceAfterRoll = value;
                      },
                      value: preferences.resetNumberOfDiceAfterRoll,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text("reset # of dice after add", style: textStyle)
                  ),
                  Expanded(
                    flex: 1,
                    child: Switch(
                      onChanged: (value) {
                        preferences.resetNumberOfDiceAfterAdd = value;
                      },
                      value: preferences.resetNumberOfDiceAfterAdd,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Text("landscape: calcuator on right", style: textStyle)
                  ),
                  Expanded(
                    flex: 1,
                    child: Switch(
                      onChanged: (value) {
                        preferences.landscapeCalcOnRight = value;
                      },
                      value: preferences.landscapeCalcOnRight,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: _theme.textColor
                      ),
                      child: Text("Theme Settings", style: textStyle),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ThemeSettingsRoute()),
                        );
                      },
                    )
                  ),
                ],
              ),

            ],
          ),
        )
    );
  }

  ///
}