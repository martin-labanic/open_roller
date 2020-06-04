
import "package:dice_tower/dice_tower.dart";
import "package:equatable/equatable.dart";

class HistoryEntry {
  final String diceRolled;
  final String rollResult;
  String rollResultDetails;
  HistoryEntry(this.diceRolled, this.rollResult, {this.rollResultDetails}) {}
}

/// Events.
abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HELoad extends HistoryEvent {}

class HENewRollResult extends HistoryEvent {
  final RollResult result;

  HENewRollResult(this.result);

  @override
  List<Object> get props => [result];
}

/// States.
abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HSUninitialized extends HistoryState {}


class HSLoaded extends HistoryState {
  final List<HistoryEntry> fullRollHistory;

  const HSLoaded({
    this.fullRollHistory,
  });

  @override
  List<Object> get props => [fullRollHistory];
}

class HSNewRoll extends HistoryState {
  final HistoryEntry roll;

  const HSNewRoll({
    this.roll,
  });

  @override
  List<Object> get props => [roll];
}
