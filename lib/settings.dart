import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_roller/preferences_state.dart';
import 'package:provider/provider.dart';

class SettingsRoute extends StatelessWidget {//StatefulWidget {
//  @override
//  _SettingsRouteState createState() => _SettingsRouteState();
//}
//
//class _SettingsRouteState extends State<SettingsRoute> {
////  bool _hasSetup = false;
////  int _maxNumberOfDice = 12;
////  bool _resetModifierAfterRoll = true;
////  bool _resetNumberOfDiceAfterRoll = true;
////  bool _resetModifierAfterAdd = true;
////  bool _resetNumberOfDiceAfterAdd = true;
////  bool _landscapeCalcOnRight = true;
//
//  @override
//  void initState() {
////    _setup();
//    super.initState();
//  }
//
////  void _setup() async {
////    _resetModifierAfterRoll = await SharedPreferencesHelper.getResetModifierAfterRoll();
////    _resetNumberOfDiceAfterRoll = await SharedPreferencesHelper.getResetNumberOfDiceAfterRoll();
////    _resetModifierAfterAdd = await SharedPreferencesHelper.getResetModifierAfterAdd();
////    _resetNumberOfDiceAfterAdd = await SharedPreferencesHelper.getResetNumberOfDiceAfterAdd();
////    _landscapeCalcOnRight = await SharedPreferencesHelper.getLandscapeCalcOnRight();
////    _resetModifierAfterRoll =
////    _resetNumberOfDiceAfterRoll = await SharedPreferencesHelper.getResetNumberOfDiceAfterRoll();
////    _resetModifierAfterAdd = await SharedPreferencesHelper.getResetModifierAfterAdd();
////    _resetNumberOfDiceAfterAdd = await SharedPreferencesHelper.getResetNumberOfDiceAfterAdd();
////    _landscapeCalcOnRight = await SharedPreferencesHelper.getLandscapeCalcOnRight();
//
//    setState(() {
//      _hasSetup = true;
//    });
//  }

  @override
  Widget build(BuildContext context) {
//    if (_hasSetup) {
//      return buildSettingsScreen(context);
////    } else {
////      return buildLoading();
////    }
//  }
//
////  Widget buildLoading() {
////    return Scaffold(
////        body: Container(
////          child: Text("loading."),
////        )
////    );
////  }
//
//  Widget buildSettingsScreen(BuildContext context) {
    final preferences = Provider.of<PreferencesState>(context);
    return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("reset modifier after roll"),
                  Switch(
                    onChanged: (value) {
//                      _resetModifierAfterRoll = value;
//                      SharedPreferencesHelper.setResetModifierAfterRoll(value);
                      preferences.resetModifierAfterRoll = value;
                    },
                    value: preferences.resetModifierAfterRoll,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text("reset modifier after add"),
                  Switch(
                    onChanged: (value) {
//                      _resetModifierAfterAdd = value;
//                      SharedPreferencesHelper.setResetModifierAfterAdd(value);
                      preferences.resetModifierAfterAdd = value;
                    },
                    value: preferences.resetModifierAfterAdd,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text("reset # of dice after roll"),
                  Switch(
                    onChanged: (value) {
//                      _resetNumberOfDiceAfterRoll = value;
//                      SharedPreferencesHelper.setResetNumberOfDiceAfterRoll(value);
                      preferences.resetNumberOfDiceAfterRoll = value;
                    },
                    value: preferences.resetNumberOfDiceAfterRoll,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text("reset # of dice after add"),
                  Switch(
                    onChanged: (value) {
//                      _resetNumberOfDiceAfterAdd = value;
//                      SharedPreferencesHelper.setResetNumberOfDiceAfterAdd(value);
                      preferences.resetNumberOfDiceAfterAdd = value;
                    },
                    value: preferences.resetNumberOfDiceAfterAdd,
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text("landscape: calcuator on right"),
                  Switch(
                    onChanged: (value) {
//                      _landscapeCalcOnRight = value;
//                      SharedPreferencesHelper.setLandscapeCalcOnRight(value);
                      preferences.landscapeCalcOnRight = value;
                    },
                    value: preferences.landscapeCalcOnRight,
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
}