
import "package:auto_size_text/auto_size_text.dart";
import "package:dice_tower/dice_tower.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:open_roller/preferences_state.dart";
import "package:open_roller/ui_components/calculator_bloc.dart";
import "package:open_roller/ui_components/calculator_events_and_states.dart";
import "package:provider/provider.dart";

//class DndCalculator extends StatefulWidget {
//  DndCalculator(this.onRollPressed(RollResult result), {Key key, this.title}) : super(key: key);
//
//  final String title;
//  final ValueSetter<RollResult> onRollPressed;
//
//  @override
//  _DndCalculatorState createState() => _DndCalculatorState(this);
//}

class DndCalculator extends StatelessWidget {
  final _calculatorTextStyle = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    final CalculatorBloc _calculatorBloc = BlocProvider.of<CalculatorBloc>(context);

    return BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          if (state is CSUninitialized) {
            _calculatorBloc.add(CELoad());
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CSLoaded) {
            return Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        constraints: BoxConstraints.expand(),
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0, bottom: 1.0),
                        child: AutoSizeText(
                          state.uiData[UI_DATA_CALCULATOR_DISPLAY].toString(),
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
                                calculatorButton("+", 1, () {
                                  _calculatorBloc.add(CEButtonPressed(value: "+n"));
                                }),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    constraints: BoxConstraints.expand(),
                                    alignment: Alignment(0.0, 0.0),
                                    padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0, bottom: 1.0),
                                    child: AutoSizeText(
                                      state.uiData[UI_DATA_NUMBER_OF_DICE].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 24.0),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                calculatorButton("-", 1, () {
                                  _calculatorBloc.add(CEButtonPressed(value: "-n"));
                                }),
                                calculatorButton("+", 1, () {
                                  _calculatorBloc.add(CEButtonPressed(value: "+m"));
                                }),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    constraints: BoxConstraints.expand(),
                                    alignment: Alignment(0.0, 0.0),
                                    padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0, bottom: 1.0),
                                    child: AutoSizeText(
                                      state.uiData[UI_DATA_MODIFIER].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 24.0),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                calculatorButton("-", 1, () {
                                  _calculatorBloc.add(CEButtonPressed(value: "-m"));
                                }),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        calculatorButton("D4", 1, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 4));
                                        }),
                                        calculatorButton("D6", 1, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 6));
                                        }),
                                        calculatorButton("D8", 1, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 8));
                                        }),
                                        Expanded(
                                          flex: 1,
                                          child: FlatButton(
                                            color: Theme.of(context).primaryColor,
                                            onPressed: () {
                                              _calculatorBloc.add(CEButtonPressed(value: "-"));
                                            },
                                            child: Center(child: Icon(Icons.backspace)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        calculatorButton("D10", 1, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 10));
                                        }),
                                        calculatorButton("D12", 1, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 12));
                                        }),
                                        calculatorButton("D20", 1, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 20));
                                        }),
                                        calculatorButton("+", 1, () {
                                          _calculatorBloc.add(CEButtonPressed(value: "+"));
                                        }),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        calculatorButton("D100", 1, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 100));
                                        }),
                                        Expanded(
                                          flex: 2,
                                          child: Container (
//                                            color: preferences.primaryColor.withOpacity(0.9),
                                            child: Center(child: Text("", style: _calculatorTextStyle)),
                                          ),
                                        ),
                                        calculatorButton("roll", 1, () {
                                          _calculatorBloc.add(CEButtonPressed(value: "="));
                                        })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            );
          }  else {
            return Center(
              child: Text("TODO State `$state` not handled"),
            );
          }
        });
  }

  Widget calculatorButton(String text, int flex, VoidCallback onPressed) {
    return Expanded(
      flex: flex,
      child: FlatButton(
        child: Center(child: Text(text, style: _calculatorTextStyle)),
        onPressed: onPressed,
      ),
    );
  }

}