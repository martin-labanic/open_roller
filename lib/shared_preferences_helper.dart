import "dart:ui";

import "package:shared_preferences/shared_preferences.dart";

const String USER_PREF_MAX_NUMBER_OF_DICE = "max_number_of_dice";
const String USER_PREF_RESET_MODIFIER_AFTER_ROLL = "reset_modifier_after_roll";
const String USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ROLL = "reset_number_of_dice_after_roll";
const String USER_PREF_RESET_MODIFIER_AFTER_ADD = "reset_modifier_after_add";
const String USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ADD = "reset_number_of_dice_after_add";
const String USER_PREF_LANDSCAPE_CALC_ON_RIGHT = "landscape_calc_on_right";

const String USER_PREF_PRIMARY_COLOR = "primary_colour";
const String USER_PREF_PRIMARY_COLOR_DEFAULT = "0xFFEEEEEE";
const String USER_PREF_SECONDARY_COLOR = "secondary_colour";
const String USER_PREF_SECONDARY_COLOR_DEFAULT = "0xFFEEEEEE";
const String USER_PREF_TERTIARY_COLOR = "tertiary_colour";
const String USER_PREF_TERTIARY_COLOR_DEFAULT = "0xFF000000";
const String USER_PREF_DICE_ROLLED_TEXT_COLOR = "_dice_rolled_text_colour";
const String USER_PREF_DICE_ROLLED_TEXT_COLOR_DEFAULT = "0xFF03A9F4";
const String USER_PREF_RESULT_TEXT_COLOR = "result_text_colour";
const String USER_PREF_RESULT_TEXT_COLOR_DEFAULT = "0xFF000000";
const String USER_PREF_RESULT_DETAILS_TEXT_COLOR = "detailed_result_text_colour";
const String USER_PREF_RESULT_DETAILS_TEXT_COLOR_DEFAULT = "0x73000000";

/// Implementation note: Not using the get / set keywords as you can't use async.
class SharedPreferencesHelper {
  ///
  static Future<int> getMaxNumberOfDice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getInt(USER_PREF_MAX_NUMBER_OF_DICE);
    if (result == null) {
      result = 12;
      await prefs.setInt(USER_PREF_MAX_NUMBER_OF_DICE, result);
    }

    return result;
  }

  ///
  static Future<bool> getResetModifierAfterRoll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(USER_PREF_RESET_MODIFIER_AFTER_ROLL);
    if (result == null) {
      result = true;
      await prefs.setBool(USER_PREF_RESET_MODIFIER_AFTER_ROLL, result);
    }

    return result;
  }

  ///
  static Future<bool> getResetNumberOfDiceAfterRoll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ROLL);
    if (result == null) {
      result = true;
      await prefs.setBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ROLL, result);
    }

    return result;
  }

  ///
  static Future<bool> getResetModifierAfterAdd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(USER_PREF_RESET_MODIFIER_AFTER_ADD);
    if (result == null) {
      result = true;
      await prefs.setBool(USER_PREF_RESET_MODIFIER_AFTER_ADD, result);
    }

    return result;
  }

  ///
  static Future<bool> getResetNumberOfDiceAfterAdd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ADD);
    if (result == null) {
      result = true;
      await prefs.setBool(USER_PREF_RESET_NUMBER_OF_DICE_AFTER_ADD, result);
    }

    return result;
  }

  ///
  static Future<bool> getLandscapeCalcOnRight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getBool(USER_PREF_LANDSCAPE_CALC_ON_RIGHT);
    if (result == null) {
      result = true;
      await prefs.setBool(USER_PREF_LANDSCAPE_CALC_ON_RIGHT, result);
    }

    return result;
  }

  ///
  static Future<Color> getPrimaryColor() async {
    return await _getColor(USER_PREF_PRIMARY_COLOR, USER_PREF_PRIMARY_COLOR_DEFAULT);
  }

  ///
  static Future<Color> getSecondaryColor() async {
    return await _getColor(USER_PREF_SECONDARY_COLOR, USER_PREF_SECONDARY_COLOR_DEFAULT);
  }

  ///
  static Future<Color> getTertiaryColor() async {
    return await _getColor(USER_PREF_TERTIARY_COLOR, USER_PREF_TERTIARY_COLOR_DEFAULT);
  }

  ///
  static Future<Color> getDiceRolledTextColor() async {
    return await _getColor(USER_PREF_DICE_ROLLED_TEXT_COLOR, USER_PREF_DICE_ROLLED_TEXT_COLOR_DEFAULT);
  }

  ///
  static Future<Color> getResultTextColor() async {
    return await _getColor(USER_PREF_RESULT_TEXT_COLOR, USER_PREF_RESULT_TEXT_COLOR_DEFAULT);
  }

  ///
  static Future<Color> getResultDetailsTextColor() async {
    return await _getColor(USER_PREF_RESULT_DETAILS_TEXT_COLOR, USER_PREF_RESULT_DETAILS_TEXT_COLOR_DEFAULT);
  }

  ///
  static Future<Color> _getColor(String colourName, String defaultColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Color result;
    try {
      var hexColor = prefs.getString(colourName);
      if (hexColor != null && hexColor.isNotEmpty) {
        result = Color(int.parse(hexColor));
      } else {
        result = Color(int.parse(defaultColor));
        await prefs.setString(colourName, defaultColor);
      }
    } catch (e, s) {
      print(e.toString() + s.toString()); // TODO Make this use crashlytics.
      result = Color(int.parse(defaultColor));
      await prefs.setString(colourName, defaultColor);
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

  ///
  static Future<bool> setLandscapeCalcOnRight(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return value != null ? await prefs.setBool(USER_PREF_LANDSCAPE_CALC_ON_RIGHT, value) : false;
  }

  ///
  static Future<bool> setPrimaryColor(Color value) async {
    return await _setColor(USER_PREF_PRIMARY_COLOR, value);
  }

  ///
  static Future<bool> setSecondaryColor(Color value) async {
    return await _setColor(USER_PREF_SECONDARY_COLOR, value);
  }

  ///
  static Future<bool> setTertiaryColor(Color value) async {
    return await _setColor(USER_PREF_TERTIARY_COLOR, value);
  }

  ///
  static Future<bool> setDiceRolledTextColor(Color value) async {
    return await _setColor(USER_PREF_DICE_ROLLED_TEXT_COLOR, value);
  }

  ///
  static Future<bool> setResultTextColor(Color value) async {
    return await _setColor(USER_PREF_RESULT_TEXT_COLOR, value);
  }

  ///
  static Future<bool> setDetailedResultTextColor(Color value) async {
    return await _setColor(USER_PREF_RESULT_DETAILS_TEXT_COLOR, value);
  }

  ///
  static Future<bool> _setColor(String name, Color value) async {
    if (name == null || name.isEmpty || value == null) {
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(name, value.value.toString());
  }
}