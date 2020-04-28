import "dart:ui";

import "package:flutter/foundation.dart";
import "package:open_roller/shared_preferences_helper.dart";
import "package:provider/provider.dart";

class PreferencesState with ChangeNotifier {
  int _maxNumberOfDice = 12;
  bool _resetModifierAfterRoll = true;
  bool _resetNumberOfDiceAfterRoll = true;
  bool _resetModifierAfterAdd = true;
  bool _resetNumberOfDiceAfterAdd = true;
  bool _landscapeCalcOnRight = true;
  Color _primaryColor;
  Color _secondaryColor;
  Color _tertiaryColor;
  Color _diceRolledTextColor;
  Color _resultTextColor;
  Color _resultDetailsTextColor;

  ///
  PreferencesState() {
    init();
  }

  ///
  void init() async {
    _maxNumberOfDice = await SharedPreferencesHelper.getMaxNumberOfDice();
    _resetModifierAfterRoll = await SharedPreferencesHelper.getResetModifierAfterRoll();
    _resetNumberOfDiceAfterRoll = await SharedPreferencesHelper.getResetNumberOfDiceAfterRoll();
    _resetModifierAfterAdd = await SharedPreferencesHelper.getResetModifierAfterAdd();
    _resetNumberOfDiceAfterAdd = await SharedPreferencesHelper.getResetNumberOfDiceAfterAdd();
    _landscapeCalcOnRight = await SharedPreferencesHelper.getLandscapeCalcOnRight();
    _primaryColor = await SharedPreferencesHelper.getPrimaryColor();
    _secondaryColor = await SharedPreferencesHelper.getSecondaryColor();
    _tertiaryColor = await SharedPreferencesHelper.getTertiaryColor();
    _diceRolledTextColor = await SharedPreferencesHelper.getDiceRolledTextColor();
    _resultTextColor = await SharedPreferencesHelper.getResultTextColor();
    _resultDetailsTextColor = await SharedPreferencesHelper.getResultDetailsTextColor();
  }

  ///
  int get maxNumberOfDice => _maxNumberOfDice;
  set maxNumberOfDice(int value) {
    SharedPreferencesHelper.setMaxNumberOfDice(value);
    _maxNumberOfDice = value;
    notifyListeners();
  }

  ///
  bool get resetModifierAfterRoll => _resetModifierAfterRoll;
  set resetModifierAfterRoll(bool value) {
    SharedPreferencesHelper.setResetModifierAfterRoll(value);
    _resetModifierAfterRoll = value;
    notifyListeners();
  }

  ///
  bool get resetNumberOfDiceAfterRoll => _resetNumberOfDiceAfterRoll;
  set resetNumberOfDiceAfterRoll(bool value) {
    SharedPreferencesHelper.setResetNumberOfDiceAfterRoll(value);
    _resetNumberOfDiceAfterRoll = value;
    notifyListeners();
  }

  ///
  bool get resetModifierAfterAdd => _resetModifierAfterAdd;
  set resetModifierAfterAdd(bool value) {
    SharedPreferencesHelper.setResetModifierAfterAdd(value);
    _resetModifierAfterAdd = value;
    notifyListeners();
  }

  ///
  bool get resetNumberOfDiceAfterAdd => _resetNumberOfDiceAfterAdd;
  set resetNumberOfDiceAfterAdd(bool value) {
    SharedPreferencesHelper.setResetNumberOfDiceAfterAdd(value);
    _resetNumberOfDiceAfterAdd = value;
    notifyListeners();
  }

  ///
  bool get landscapeCalcOnRight => _landscapeCalcOnRight;
  set landscapeCalcOnRight(bool value) {
    SharedPreferencesHelper.setLandscapeCalcOnRight(value);
    _landscapeCalcOnRight = value;
    notifyListeners();
  }

  ///
  Color get primaryColor => _primaryColor;
  set primaryColor(Color value) {
    SharedPreferencesHelper.setPrimaryColor(value);
    _primaryColor = value;
    notifyListeners();
  }

  ///
  Color get secondaryColor => _secondaryColor;
  set secondaryColor(Color value) {
    SharedPreferencesHelper.setSecondaryColor(value);
    _secondaryColor = value;
    notifyListeners();
  }

  ///
  Color get tertiaryColor => _tertiaryColor;
  set tertiaryColor(Color value) {
    SharedPreferencesHelper.setTertiaryColor(value);
    _tertiaryColor = value;
    notifyListeners();
  }

  ///
  Color get diceRolledTextColor => _diceRolledTextColor;
  set diceRolledTextColor(Color value) {
    SharedPreferencesHelper.setDiceRolledTextColor(value);
    _diceRolledTextColor = value;
    notifyListeners();
  }

  ///
  Color get resultTextColor => _resultTextColor;
  set resultTextColor(Color value) {
    SharedPreferencesHelper.setResultTextColor(value);
    _resultTextColor = value;
    notifyListeners();
  }

  ///
  Color get resultDetailsTextColor => _resultDetailsTextColor;
  set resultDetailsTextColor(Color value) {
    SharedPreferencesHelper.setDetailedResultTextColor(value);
    _resultDetailsTextColor = value;
    notifyListeners();
  }
}