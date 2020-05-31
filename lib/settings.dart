import "package:flutter/material.dart";
import "package:flutter_material_color_picker/flutter_material_color_picker.dart";
import "package:open_roller/preferences_state.dart";
import "package:provider/provider.dart";

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<PreferencesState>(context);
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Settings"),
//          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Text("reset modifier after roll")
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
                    child: Text("reset modifier after add")
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
                    child: Text("reset # of dice after roll")
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
                    child: Text("reset # of dice after add")
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
                      child: Text("landscape: calcuator on right")
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
                      flex: 5,
                      child: Text("primary color")
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector (
                        onTap: () {
                          _openColorPicker(context, preferences.primaryColor, (color) {
                            preferences.primaryColor = color;
                          });
                        },
                        child: CircleColor(
                          color: preferences.primaryColor,
                          circleSize: 50,
                        ),
                      )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Text("secondary color")
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector (
                        onTap: () {
                          _openColorPicker(context, preferences.secondaryColor, (color) {
                            preferences.secondaryColor = color;
                          });
                        },
                        child: CircleColor(
                          color: preferences.secondaryColor,
                          circleSize: 50,
                        ),
                      )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Text("tertiary color")
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector (
                        onTap: () {
                          _openColorPicker(context, preferences.tertiaryColor, (color) {
                            preferences.tertiaryColor = color;
                          });
                        },
                        child: CircleColor(
                          color: preferences.tertiaryColor,
                          circleSize: 50,
                        ),
                      )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Text("dice rolled text color")
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector (
                        onTap: () {
                          _openColorPicker(context, preferences.diceRolledTextColor, (color) {
                            preferences.diceRolledTextColor = color;
                          });
                        },
                        child: CircleColor(
                          color: preferences.diceRolledTextColor,
                          circleSize: 50,
                        ),
                      )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Text("result text color")
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector (
                        onTap: () {
                          _openColorPicker(context, preferences.resultTextColor, (color) {
                            preferences.resultTextColor = color;
                          });
                        },
                        child: CircleColor(
                          color: preferences.resultTextColor,
                          circleSize: 50,
                        ),
                      )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Text("result details text color")
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector (
                        onTap: () {
                          _openColorPicker(context, preferences.resultDetailsTextColor, (color) {
                            preferences.resultDetailsTextColor = color;
                          });
                        },
                        child: CircleColor(
                          color: preferences.resultDetailsTextColor,
                          circleSize: 50,
                        ),
                      )
                  )
                ],
              ),
            ],
          ),
        )
    );
  }

  ///
  void _openColorPicker(BuildContext context, Color selectedColor, ValueSetter<Color> callback) {
    Color c;
    showDialog(
      context: context,
        builder: (_) {
          return AlertDialog(
            content: MaterialColorPicker(
              selectedColor: selectedColor,
              onColorChange: (color) {
                c = color;
              },
            ),
            actions: [
              FlatButton(
                child: Text("cancel"),
                onPressed: Navigator.of(context).pop,
              ),
              FlatButton(
                child: Text("save"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (callback != null) {
                    callback(c);
                  }
                },
              ),
            ],
          );
        }
    );
  }
}