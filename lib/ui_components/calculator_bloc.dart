import "package:dice_tower/dice_tower.dart";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:open_roller/history_bloc.dart";
import "package:open_roller/preferences_state.dart";
import "package:open_roller/ui_components/calculator_events_and_states.dart";

const String UI_DATA_CALCULATOR_DISPLAY = "display";
const String UI_DATA_NUMBER_OF_DICE = "number_of_dice";
const String UI_DATA_MODIFIER = "modifier";

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  PreferencesState preferences = PreferencesState();

  CalculatorBloc(CalculatorState initialState) : super(initialState);

  @override
  CalculatorState get initialState => CSUninitialized();

  var _diceToRoll = List<Dice>();

  String _currentCalcDisplay = "";
  String _currentCalcDisplayAppendToEnd = "";
  String _currentModifierDisplay = "";
  String _currentNumberOfDiceDisplay = "";

  int _minModifier = -10;
  int _maxModifier = 10;
  int _currentModifier = 0;
  void _incrementModifier() {
    currentModifier++;
  }
  void _decrementModifier() {
    currentModifier--;
  }
  int get currentModifier => _currentModifier;
  set currentModifier(int value) {
    _currentModifier = value;
    if (_currentModifier < _minModifier) {
      _currentModifier = _minModifier;
    } else if (_currentModifier > _maxModifier) {
      _currentModifier = _maxModifier;
    }
  }

  int _minNumberOfDice = 1;
  int _maxNumberOfDice = 12;
  int _currentNumberOfDice = 1;
  void _incrementNumberOfDice() {
    ++currentNumberOfDice;
  }
  void _decrementNumberOfDice() {
    --currentNumberOfDice;
  }
  int get currentNumberOfDice => _currentNumberOfDice;
  set currentNumberOfDice(int value) {
    _currentNumberOfDice = value;
    if (_currentNumberOfDice <= _minNumberOfDice) {
      _currentNumberOfDice = _minNumberOfDice;
    } else if (_currentNumberOfDice >= _maxNumberOfDice) {
      _currentNumberOfDice = _maxNumberOfDice;
    }
  }

  int _currentNumberOfSides = 20;

  Map<String, String> uiData() {
    return {
      UI_DATA_CALCULATOR_DISPLAY: _currentCalcDisplay,
      UI_DATA_NUMBER_OF_DICE: _currentNumberOfDiceDisplay,
      UI_DATA_MODIFIER: _currentModifierDisplay
    };
  }

  @override
  Stream<CalculatorState> mapEventToState(event) async* {
    if (event is CEButtonPressed) {
      var result = onPressedButton(event.value);
      updateUi();
      if (event.value == "=" && result != null) {
        yield CSNewRoll(value: result as RollResult);
      }
      yield CSLoaded(uiData: uiData());
    } else if (event is CELoad) {
      updateUi();
      yield CSLoaded(uiData: uiData());
    } else {
      print("calculator_bloc: mapEventToState: Unhandled event: ${event.toString()}");
    }
  }

  /// Returns a instance of [RollResult] if the user taps roll (=).
  /// [value] The button that was pressed.
  dynamic onPressedButton(dynamic value) {
    var result = null;
    _currentCalcDisplayAppendToEnd = "";
    if (value is String) {
      if (value == "+") { // If they tap `+` then add the current di selection and update the ui.
        if (_currentNumberOfSides != null) {
          _diceToRoll.add(Dice(_currentNumberOfSides, modifier: _currentModifier, numberOfDice: _currentNumberOfDice));
        }
        _currentNumberOfSides = null;

        if (preferences.resetNumberOfDiceAfterAdd) { // Update the number of dice based on the user preferences
          _currentNumberOfDice = 1;
        }
        if (preferences.resetModifierAfterAdd) { // Update the modifier based on the user preferences
          _currentModifier = 0;
        }
        _currentCalcDisplayAppendToEnd = "+";
      } else if (value == "-") { // If they tap back then remove the current dice value or the last di.
        if (_currentNumberOfSides != null) {
          _currentNumberOfSides = null;
        } else if (_diceToRoll.isNotEmpty) {
          _diceToRoll.removeLast();
        }
      } else if (value == "=") { // If they tap roll then add the current selection and roll the dice they've chosen.
        if (_currentNumberOfSides != null) {
          _diceToRoll.add(Dice(_currentNumberOfSides, modifier: _currentModifier, numberOfDice: _currentNumberOfDice));
        }
        if (_diceToRoll.isNotEmpty) {
          result = Dnd5eRuleset.roll(List<Dice>.from(_diceToRoll)); // Need to pass a copy.
          _diceToRoll.clear();

          if (preferences.resetNumberOfDiceAfterRoll) { // Update the number of dice based on the user preferences
            _currentNumberOfDice = 1;
          }
          if (preferences.resetModifierAfterRoll) { // Update the modifier based on the user preferences
            _currentModifier = 0;
          }
        }
      } else if (value == "+n") {
        _incrementNumberOfDice();
        updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
      } else if (value == "-n") {
        _decrementNumberOfDice();
        updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
      } else if (value == "+m") {
        _incrementModifier();
        updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
      } else if (value == "-m") {
        _decrementModifier();
        updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
      }
    } else if (value is int){
      _currentNumberOfSides = value;
    }
    updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
    return result;
  }

  /// Update the dice display UI elements
  void updateUi({String appendToEnd = ""}) {
    // Update the modifier display
    _currentModifierDisplay = _currentModifier > -1 ? "+$_currentModifier" : "$_currentModifier";

    // Update the number of dice display
    _currentNumberOfDiceDisplay = "${_currentNumberOfDice}x";

    // Update the main display
    _currentCalcDisplay = "";
    if (_diceToRoll != null && _diceToRoll.isNotEmpty) {
      for (int i = 0; i < _diceToRoll.length-1; i++) {
        _currentCalcDisplay += "${_diceToRoll[i].title} + ";
      }
      _currentCalcDisplay += _diceToRoll.last.title;
    }

    if (_currentNumberOfSides != null) {
      String modifierString = _currentModifier != 0
          ? (_currentModifier > 0 ? "+" + _currentModifier.toString() : _currentModifier.toString())
          : "";
      String completeTitle = _currentNumberOfDice > 1
          ? "${_currentNumberOfDice}xD$_currentNumberOfSides$modifierString"
          : "D$_currentNumberOfSides$modifierString";
      _currentCalcDisplay += (_currentCalcDisplay.isNotEmpty) ? " + $completeTitle" : "$completeTitle";
    }

    _currentCalcDisplay += appendToEnd;
  }

}
