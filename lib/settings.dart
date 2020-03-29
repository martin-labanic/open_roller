import 'package:flutter/material.dart';
import 'package:open_roller/preferences_state.dart';
import 'package:provider/provider.dart';

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<PreferencesState>(context);
    return Scaffold(
        appBar: AppBar( // TODO Keep this or remove it once you implement user preferences.
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
            ],
          ),
        )
    );
  }
}