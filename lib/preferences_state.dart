import 'package:flutter/foundation.dart';
import 'package:open_roller/shared_preferences_helper.dart';
import "package:provider/provider.dart";

class PreferencesState with ChangeNotifier {
  int _maxNumberOfDice = 12;
  bool _resetModifierAfterRoll = true;
  bool _resetNumberOfDiceAfterRoll = true;//await SharedPreferencesHelper.getResetNumberOfDiceAfterRoll();
  bool _resetModifierAfterAdd = true;//await SharedPreferencesHelper.getResetModifierAfterAdd();
  bool _resetNumberOfDiceAfterAdd = true;//await SharedPreferencesHelper.getResetNumberOfDiceAfterAdd();
  bool _landscapeCalcOnRight = true;//SharedPreferencesHelper.getLandscapeCalcOnRight();

  int get maxNumberOfDice => _maxNumberOfDice;
  set maxNumberOfDice(int value) {
    SharedPreferencesHelper.setMaxNumberOfDice(value);
    _maxNumberOfDice = value;
    notifyListeners();
  }

  bool get resetModifierAfterRoll => _resetModifierAfterRoll;
  set resetModifierAfterRoll(bool value) {
    SharedPreferencesHelper.setResetModifierAfterRoll(value);
    _resetModifierAfterRoll = value;
    notifyListeners();
  }

  bool get resetNumberOfDiceAfterRoll => _resetNumberOfDiceAfterRoll;
  set resetNumberOfDiceAfterRoll(bool value) {
    SharedPreferencesHelper.setResetNumberOfDiceAfterRoll(value);
    _resetNumberOfDiceAfterRoll = value;
    notifyListeners();
  }

  bool get resetModifierAfterAdd => _resetModifierAfterAdd;
  set resetModifierAfterAdd(bool value) {
    SharedPreferencesHelper.setResetModifierAfterAdd(value);
    _resetModifierAfterAdd = value;
    notifyListeners();
  }

  bool get resetNumberOfDiceAfterAdd => _resetNumberOfDiceAfterAdd;
  set resetNumberOfDiceAfterAdd(bool value) {
    SharedPreferencesHelper.setResetNumberOfDiceAfterAdd(value);
    _resetNumberOfDiceAfterAdd = value;
    notifyListeners();
  }


  bool get landscapeCalcOnRight => _landscapeCalcOnRight;
  set landscapeCalcOnRight(bool value) {
    SharedPreferencesHelper.setLandscapeCalcOnRight(value);
    _landscapeCalcOnRight = value;
    notifyListeners();
  }
}