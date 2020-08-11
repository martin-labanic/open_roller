
import "package:auto_size_text/auto_size_text.dart";
import "package:dice_tower/dice_tower.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:open_roller/preferences_state.dart";
import "package:open_roller/ui_components/calculator_bloc.dart";
import "package:open_roller/ui_components/calculator_events_and_states.dart";
import 'package:persist_theme/data/models/theme_model.dart';
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

  @override
  Widget build(BuildContext context) {
    final CalculatorBloc _calculatorBloc = BlocProvider.of<CalculatorBloc>(context);
    final _theme = Provider.of<ThemeModel>(context);
    TextStyle textStyle = TextStyle(fontSize: 18, color: _theme.textColor);

    return BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          if (state is CSUninitialized) {
            _calculatorBloc.add(CELoad());
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CSLoaded) {
            return Container(
              color: _theme.theme.focusColor,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: _theme.theme.focusColor.withAlpha(15),
                        constraints: BoxConstraints.expand(),
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0, bottom: 1.0),
                        child: AutoSizeText(
                          state.uiData[UI_DATA_CALCULATOR_DISPLAY].toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 34.0, color: _theme.textColor),
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
                                  flex:1,
                                  child: FlatButton(
                                    onPressed: () {
                                      _calculatorBloc.add(CEButtonPressed(value: "+n"));
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Icon(Icons.arrow_drop_up, color: _theme.textColor)),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    constraints: BoxConstraints.expand(),
                                    alignment: Alignment(0.0, 0.0),
                                    padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0, bottom: 1.0),
                                    child: AutoSizeText(
                                      state.uiData[UI_DATA_NUMBER_OF_DICE].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 24.0, color: _theme.textColor),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FlatButton(
                                    onPressed: () {
                                      _calculatorBloc.add(CEButtonPressed(value: "-n"));
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Icon(Icons.arrow_drop_down, color: _theme.textColor)
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FlatButton(
                                    onPressed: () {
                                      _calculatorBloc.add(CEButtonPressed(value: "+m"));
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Icon(Icons.arrow_drop_up, color: _theme.textColor)
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    constraints: BoxConstraints.expand(),
                                    alignment: Alignment(0.0, 0.0),
                                    padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0, bottom: 1.0),
                                    child: AutoSizeText(
                                      state.uiData[UI_DATA_MODIFIER].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 24.0, color: _theme.textColor),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FlatButton(
                                    onPressed: () {
                                      _calculatorBloc.add(CEButtonPressed(value: "-m"));
                                    },
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Icon(Icons.arrow_drop_down, color: _theme.textColor)
                                    ),
                                  ),
                                ),
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
                                        calculatorButton("D4", 1, textStyle, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 4));
                                        }),
                                        calculatorButton("D6", 1, textStyle, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 6));
                                        }),
                                        calculatorButton("D8", 1, textStyle, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 8));
                                        }),
                                        Expanded(
                                          flex: 1,
                                          child: FlatButton(
                                            onPressed: () {
                                              _calculatorBloc.add(CEButtonPressed(value: "-"));
                                            },
                                            child: Center(child: Icon(Icons.backspace, color: _theme.textColor)),
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
                                        calculatorButton("D10", 1, textStyle, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 10));
                                        }),
                                        calculatorButton("D12", 1, textStyle, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 12));
                                        }),
                                        calculatorButton("D20", 1, textStyle, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 20));
                                        }),
                                        Expanded(
                                          flex: 1,
                                          child: FlatButton(
                                            onPressed: () {
                                              _calculatorBloc.add(CEButtonPressed(value: "+"));
                                            },
                                            child: Center(child: Icon(Icons.add_circle, color: _theme.textColor)),
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
                                        calculatorButton("D100", 1, textStyle, () {
                                          _calculatorBloc.add(CEButtonPressed(value: 100));
                                        }),
                                        Expanded(
                                          flex: 2,
                                          child: Container (
//                                            color: preferences.primaryColor.withOpacity(0.9),
                                            child: Center(child: Text("", style: textStyle)),
                                          ),
                                        ),
                                        calculatorButton("roll", 1, textStyle, () {
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

  Widget calculatorButton(String text, int flex, TextStyle textStyle, VoidCallback onPressed) {
    return Expanded(
      flex: flex,
      child: FlatButton(
        child: Center(child: Text(text, style: textStyle)),
        onPressed: onPressed,
      ),
    );
  }

}