
import "package:auto_size_text/auto_size_text.dart";
import "package:dice_tower/dice_tower.dart";
import "package:flutter/material.dart";
import "package:flutter_grid_button/flutter_grid_button.dart";
import "package:open_roller/preferences_state.dart";
import "package:provider/provider.dart";

class DndCalculator extends StatefulWidget {
  DndCalculator(this.onRollPressed(RollResult result), {Key key, this.title}) : super(key: key);

  final String title;
  final ValueSetter<RollResult> onRollPressed;

  @override
  _DndCalculatorState createState() => _DndCalculatorState(this);
}

class _DndCalculatorState extends State<DndCalculator> {
  final normalStyle = TextStyle(fontSize: 18);
  final calcIconStyle = TextStyle(fontSize: 26, fontFamily: "CalcIcon");// backgroundColor: Colors.grey[300]);

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

  DndCalculator _dndCalculator;
  _DndCalculatorState(this._dndCalculator);

  /// Overridden to get an initial call off to the ui state.
  @override
  void initState() {
    super.initState();
//    _setup();
    updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
  }

  /// Update the dice display UI elements
  void updateUi({String appendToEnd = ""}) {
    setState(() {
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
    });
  }

  Widget build(BuildContext context) {
//    final preferences = Provider.of<PreferencesState>(context);
    return Consumer<PreferencesState>(
      builder: (context, preferences, _) =>
    Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            color:  Colors.grey[200],
            constraints: BoxConstraints.expand(),
            alignment: Alignment(1.0, 0.0),
            padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0, bottom: 1.0),
            child: AutoSizeText(
              _currentCalcDisplay,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 32.0),
              maxLines: 1,
            ),
          )
        ),
        Expanded(
          flex: 6,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: () {
                          _incrementNumberOfDice();
                          updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
                        },
                        child: Text("+"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        alignment: Alignment(0.0, 0.0),
                        padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0, bottom: 1.0),
                        child: AutoSizeText(
                          _currentNumberOfDiceDisplay,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24.0),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: (){
                          _decrementNumberOfDice();
                          updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
                        },
                        child: Text("-"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: () {
                          _incrementModifier();
                          updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
                        },
                        child: Text("+"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        alignment: Alignment(0.0, 0.0),
                        padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0, bottom: 1.0),
                        child: AutoSizeText(
                          _currentModifierDisplay,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24.0),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        onPressed: (){
                          _decrementModifier();
                          updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
                        },
                        child: Text("-"),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: GridButton(
                    textStyle: normalStyle,
                    borderColor: Colors.transparent,
//        borderWidth: 2,
                    onPressed: (dynamic val) {
                      _currentCalcDisplayAppendToEnd = "";
                      if (val is String) {
                        if (val == "+") { // If they tap `+` then add the current di selection and update the ui.
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
                        } else if (val == "-") { // If they tap `<` then remove the current dice value or the last di.
                          if (_currentNumberOfSides != null) {
                            _currentNumberOfSides = null;
                          } else if (_diceToRoll.isNotEmpty) {
                            _diceToRoll.removeLast();
                          }
                        } else if (val == "=") { // If they tap roll then add the current selection and roll the dice they've chosen.
                          if (_currentNumberOfSides != null) {
                            _diceToRoll.add(Dice(_currentNumberOfSides, modifier: _currentModifier, numberOfDice: _currentNumberOfDice));
                          }
                          if (_diceToRoll.isNotEmpty) {
                            RollResult result = Dnd5eRuleset.roll(List<Dice>.from(_diceToRoll)); // Need to pass a copy.
                            this._dndCalculator.onRollPressed(result);
                            _diceToRoll.clear();

                            if (preferences.resetNumberOfDiceAfterRoll) { // Update the number of dice based on the user preferences
                              _currentNumberOfDice = 1;
                            }
                            if (preferences.resetModifierAfterRoll) { // Update the modifier based on the user preferences
                              _currentModifier = 0;
                            }
                          }
                        }
                      } else if (val is int){
                        _currentNumberOfSides = val;
                      }
                      updateUi(appendToEnd: _currentCalcDisplayAppendToEnd);
                    },
                    items: [
                      [
                        GridButtonItem(title: "D4", value: 4),
                        GridButtonItem(title: "D6", value: 6),
                        GridButtonItem(title: "D8", value: 8),
//                        IconButton(
//                          icon: Icon(Icons.volume_up),
//                          tooltip: 'Increase volume by 10',
//                          onPressed: () {
//                            setState(() {
//                              _volume += 10;
//                            });
//                          },
//                        )
                        GridButtonItem(title: "<", value: "-", color: Colors.grey[300], textStyle: calcIconStyle),
                      ],
                      [
                        GridButtonItem(title: "D10", value: 10),
                        GridButtonItem(title: "D12", value: 12),
                        GridButtonItem(title: "D20", value: 20),
                        GridButtonItem(title: "+", value: "+", color: Colors.grey[300]),
                      ],
                      [
                        GridButtonItem(title: "D100", value: 100),
                        GridButtonItem(title: "", flex: 2),
                        GridButtonItem(title: "roll", value: "=", color: Colors.grey[300]),
                      ],
                    ],
                  ),
                ),
              )
            ],
          )
        )
      ],
    )
    );
  }
}