
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:open_roller/history_bloc.dart";
import "package:open_roller/history_events_and_states.dart";

enum UiOrientation {Left, Top, Right, Bottom}

class History extends StatelessWidget {
//  @override
//  State<StatefulWidget> createState() => _HistoryState();
//}
//
//class _HistoryState extends State<History> {
  double HISTORY_FONT_SIZE_DEFAULT = 14;
  double HISTORY_FONT_SIZE_FIRST_ROW = 30;

  @override
  Widget build(BuildContext context) {
    final dashboard_bloc = BlocProvider.of<HistoryBloc>(context);
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HSUninitialized) {
          dashboard_bloc.add(HELoad());
          return Center(
            child: CircularProgressIndicator()
          );
        } else if (state is HSLoaded) {
          Widget result = _buildHistory(state);
          return result;
        } else if (state is HSNewRoll) {
          dashboard_bloc.add(HELoad());
          return Center(
              child: CircularProgressIndicator()
          );
        } else {
          return Center(
            child: Text("TODO State `$state` not handled"),
          );
        }
      },
    );
  }

  ///
  Widget _buildHistory(HSLoaded state) {
    return ListView.builder(
      reverse: true,
      itemCount: state.rollHistory.length,// _rollResults.length, //
      itemBuilder: (context, i) {
        return _buildRow(state.rollHistory[i], i == 0 ? HISTORY_FONT_SIZE_FIRST_ROW : HISTORY_FONT_SIZE_DEFAULT);
//        return _buildRow(_rollResults[i], i == 0 ? HISTORY_FONT_SIZE_FIRST_ROW : HISTORY_FONT_SIZE_DEFAULT);
      },
    );
  }

  ///
  Widget _buildRow(HistoryEntry roll, double fontSize) {
    return Container(
        color: Colors.white70,
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
                      style: TextStyle(fontSize: fontSize),
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
          style: TextStyle(color: ThemeData.dark().secondaryHeaderColor, fontSize: fontSize),
          children: <TextSpan>[
            TextSpan(text: "${roll.rollResult}\n",),
            TextSpan(text: roll.rollResultDetails, style: TextStyle(color: ThemeData.dark().secondaryHeaderColor),),
          ],
        ),
      );
    } else {
      result = Text(roll.rollResult,
        textAlign: TextAlign.start,
        style: TextStyle(color: ThemeData.dark().secondaryHeaderColor, fontSize: fontSize),
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
