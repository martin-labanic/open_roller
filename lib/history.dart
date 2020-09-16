
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:open_roller/history_bloc.dart";
import "package:open_roller/history_events_and_states.dart";
import 'package:persist_theme/data/models/theme_model.dart';
import 'package:provider/provider.dart';

enum UiOrientation {Left, Top, Right, Bottom}

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  double HISTORY_FONT_SIZE_DEFAULT = 14;
  double HISTORY_FONT_SIZE_FIRST_ROW = 30;
  var _rollResults = List<HistoryEntry>();
  ThemeModel _theme;

  void updateRollHistory(List<HistoryEntry> rolls) {
    _rollResults = rolls;
  }

  @override
  Widget build(BuildContext context) {
    _theme = Provider.of<ThemeModel>(context);
    final dashboard_bloc = BlocProvider.of<HistoryBloc>(context);
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HSUninitialized) {
          dashboard_bloc.add(HELoad());
          return Center(
            child: CircularProgressIndicator()
          );
        } else if (state is HSLoaded) {
          updateRollHistory(state.fullRollHistory);
          Widget result = _buildHistory();
          return result;
        } else if (state is HSHistoryUpdated) {
//          updateRollHistory(state.rolls);
          dashboard_bloc.add(HELoad());
          Widget result = _buildHistory();
          return result;
        } else {
          return Center(
            child: Text("TODO State `$state` not handled"),
          );
        }
      },
    );
  }

  ///
  Widget _buildHistory() {
    return ListView.builder(
      reverse: true,
      itemCount: _rollResults.length,
      itemBuilder: (context, i) {
        return _buildRow(_rollResults[i], i == 0 ? HISTORY_FONT_SIZE_FIRST_ROW : HISTORY_FONT_SIZE_DEFAULT);
      },
    );
  }

  ///
  Widget _buildRow(HistoryEntry roll, double fontSize) {
    return Container(
        child:
        ListTile(
            dense: true,
            title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container (
                    constraints: BoxConstraints(maxWidth: 150),
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      roll.diceRolled,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: fontSize, color: _theme.textColor),
                    ),
                  ),
                  _buildRollDetails(roll, fontSize)
                ]
            )
        )
    );
  }


  ///
  Widget _buildRollDetails(HistoryEntry roll, double fontSize) {
    Widget result;
    if (roll.rollResultDetails != null && roll.rollResultDetails.isNotEmpty) { // Number of dice is already handled, but a non-zero modifier deserves a
      result = RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined, child text spans will inherit styles from parents
          style: TextStyle(color: _theme.theme.accentColor, fontSize: fontSize),
          children: <TextSpan>[
            TextSpan(text: "${roll.rollResult}\n",),
            TextSpan(text: roll.rollResultDetails, style: TextStyle(color: _theme.theme.hintColor),),
          ],
        ),
      );
    } else {
      result = Text(roll.rollResult,
        textAlign: TextAlign.start,
        style: TextStyle(color: _theme.theme.accentColor, fontSize: fontSize),
      );
    }

    result = Expanded(
      child: Container(
          padding: EdgeInsets.only(left: 8.0),
          child: result
      ),
    );

    return result;
  }

}
