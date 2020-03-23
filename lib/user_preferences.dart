import "package:shared_preferences/shared_preferences.dart";

const String USER_PREF_MAX_NUMBER_OF_DICE = "max_number_of_dice";
const String USER_PREF_RESET_MODIFIER_AFTER_ROLL = "reset_modifier_after_roll";
const String USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ROLL = "reset_number_of_dice_after_roll";
const String USER_PREF_RESET_MODIFIER_AFTER_ADD = "reset_modifier_after_add";
const String USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ADD = "reset_number_of_dice_after_add";
const String USER_PREF_LANDSCAPE_CALC_ON_RIGHT = "landscape_calc_on_right";
//const String USER_PREF_ = "";

class SharedPreferencesHelper {
  ///
  static Future<int> getMaxNumberOfDice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getInt(USER_PREF_MAX_NUMBER_OF_DICE);
    if (result == null) {
      result = 12;
      prefs.setInt(USER_PREF_MAX_NUMBER_OF_DICE, result);
    }

    return result;
  }

  ///
  static Future<bool> getResetModifierAfterRoll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(USER_PREF_RESET_MODIFIER_AFTER_ROLL);
    if (result == null) {
      result = true;
      prefs.setBool(USER_PREF_RESET_MODIFIER_AFTER_ROLL, result);
    }

    return result;
  }

  ///
  static Future<bool> getResetNumberOfDiceAfterRoll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ROLL);
    if (result == null) {
      result = true;
      prefs.setBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ROLL, result);
    }

    return result;
  }

  ///
  static Future<bool> getResetModifierAfterAdd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(USER_PREF_RESET_MODIFIER_AFTER_ADD);
    if (result == null) {
      result = true;
      prefs.setBool(USER_PREF_RESET_MODIFIER_AFTER_ADD, result);
    }

    return result;
  }

  ///
  static Future<bool> getResetNumberOfDiceAfterAdd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ADD);
    if (result == null) {
      result = true;
      prefs.setBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ADD, result);
    }

    return result;
  }

  ///
  static Future<bool> setMaxNumberOfDice(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return value != null ? await prefs.setInt(USER_PREF_MAX_NUMBER_OF_DICE, value) : false;
  }

  ///
  static Future<bool> setResetModifierAfterRoll(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return value != null ? await prefs.setBool(USER_PREF_RESET_MODIFIER_AFTER_ROLL, value) : false;
  }

  ///
  static Future<bool> setResetNumberOfDiceAfterRoll(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return value != null ? await prefs.setBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ROLL, value) : false;
  }
  ///
  static Future<bool> setResetModifierAfterAdd(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return value != null ? await prefs.setBool(USER_PREF_RESET_MODIFIER_AFTER_ADD, value) : false;
  }

  ///
  static Future<bool> setResetNumberOfDiceAfterAdd(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return value != null ? await prefs.setBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ADD, value) : false;
  }
}