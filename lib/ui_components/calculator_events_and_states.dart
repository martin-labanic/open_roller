
import "package:dice_tower/dice_tower.dart";
import "package:equatable/equatable.dart";

/// Events.
abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class CELoad extends CalculatorEvent {}

class CEButtonPressed extends CalculatorEvent {
  final dynamic value;

  CEButtonPressed({this.value});

  @override
  List<Object> get props => [value];
}

/// States.
abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CSUninitialized extends CalculatorState {}

class CSLoaded extends CalculatorState {
  final Map<String, dynamic> uiData;

  const CSLoaded({
    this.uiData
  });

  @override
  List<Object> get props => [uiData];
}

class CSNewRoll extends CalculatorState {
  final RollResult value;

  CSNewRoll({this.value});

  @override
  List<Object> get props => [value];
}
