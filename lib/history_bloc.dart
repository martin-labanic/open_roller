import "dart:async";

import "package:dice_tower/dice_tower.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:open_roller/history_events_and_states.dart";
import "package:open_roller/ui_components/calculator_bloc.dart";
import "package:open_roller/ui_components/calculator_events_and_states.dart";

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  var _history = List<RollResult>();
  var _formattedHistory = List<HistoryEntry>();

  CalculatorBloc _calculatorBloc;
  StreamSubscription _calculatorSubscription;

  HistoryBloc(this._calculatorBloc) {
    _calculatorBloc?.listen((state) {
      if (state is CSNewRoll) {
        add(HENewRollResult(state.value));
      }
    });
  }

  @override
  HistoryState get initialState => HSUninitialized();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is HELoad) {
      yield HSLoaded(fullRollHistory: _formattedHistory);
    } else if (event is HENewRollResult) {
      _history.insert(0, event.result);
      _formattedHistory.insert(0, _formatRoll(event.result));
      yield HSNewRoll(roll: _formattedHistory.first);
    } else {
      print("history_bloc: mapEventToState: Unhandled event: ${event.toString()}");
    }
  }

  ///
  /// [r]
  HistoryEntry _formatRoll(RollResult r) {
    var result = HistoryEntry(r.title, Dnd5eRuleset.prettyPrintResult(r));

    if (r.rolls.length > 1 || // Handles having more than one di type.
        r.rolls[0].length > 1 || // Handles have more than one of the same di.
        (r.rolls[0].length == 1 && r.dicePool[0].modifier != 0)) { // Handles a non-zero modifier.
      result.rollResultDetails = Dnd5eRuleset.prettyPrintResultDetails(r);
    }

    return result;
  }

  ///
  @override
  Future<void> close() {
    _calculatorSubscription?.cancel();
    return super.close();
  }

}
