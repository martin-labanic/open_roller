import "package:flutter/material.dart";
import "package:dice_tower/dice_tower.dart";
import "package:flutter/services.dart";
import 'package:open_roller/preferences_state.dart';
import "package:open_roller/settings.dart";
import "package:open_roller/ui_components/dnd_calculator.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import 'package:provider/provider.dart';
//import "package:material_design_icons_flutter/material_design_icons_flutter.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  await PreferencesState().init();
  runApp(MyApp());
}

enum UiOrientation {Left, Top, Right, Bottom}

const double HISTORY_FONT_SIZE_DEFAULT = 14;
const double HISTORY_FONT_SIZE_FIRST_ROW = 30;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider (
      create: (context) => PreferencesState(),
      child: MaterialApp(
        home: OpenRoller(title: ""),

      ),
    );
  }
}

class OpenRoller extends StatefulWidget {
  OpenRoller({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OpenRollerState createState() => _OpenRollerState();
}

class _OpenRollerState extends State<OpenRoller> {
  var _history = List<RollResult>();
  UiOrientation uiOrientation = UiOrientation.Bottom;
  Orientation _orientation;
  PreferencesState preferences;

  void _updateHistory(RollResult roll) {
    setState(() {
      _history.insert(0, roll);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]); // Disable the status bar.
    preferences = Provider.of<PreferencesState>(context);

    return Scaffold(
      body: OrientationBuilder (
          builder: (context, orientation) {
            return _buildBody(orientation, preferences);
          }
        ),
    );
  }

  Widget _buildBody(Orientation orientation, PreferencesState preferences) {
    if (orientation == Orientation.portrait) {
      return Stack (
          children: <Widget>[
            Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: _buildHistory()
              ),
              Expanded(
                flex: 6,
                child: _buildUi(),
              )
            ],
          ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsRoute()),
                  );
                },
              ),
            ),
          ]
      );
    } else {
      return Container (
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: _buildHistory(),
          ),
          Expanded(
            flex: 5,
            child: _buildUi(),
          ),
        ],
        )
      );
    }
  }

  Widget _buildUi() {
    return DndCalculator((RollResult roll) {
      _updateHistory(roll);
    });
  }

  Widget _buildHistory() {
    return ListView.builder(
      reverse: true,
      itemCount: _history.length,
      itemBuilder: (context, i) {
        return _buildRow(_history[i], i == 0);
      },
    );
  }

  Widget _buildRow(RollResult roll, bool firstRow) {
    return Container(
        color: preferences.secondaryColor,
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
                    roll.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: !firstRow ? HISTORY_FONT_SIZE_DEFAULT : HISTORY_FONT_SIZE_FIRST_ROW, color: preferences.diceRolledTextColor),
                  ),
                ),
                 _buildRollDetails(roll, firstRow)
            ]
          )
      )
    );
  }
//
  Widget _buildRollDetails(RollResult roll, bool firstRow) {
    Widget result;
    if (roll.rolls.length > 1
        || roll.rolls[0].length > 1
        || (roll.rolls[0].length == 1 && roll.dicePool[0].modifier != 0)) { // Number of dice is already handled, but a non-zero modifier deserves a
      result = Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined, child text spans will inherit styles from parents
                style: TextStyle(color: preferences.resultTextColor, fontSize: !firstRow ? HISTORY_FONT_SIZE_DEFAULT : HISTORY_FONT_SIZE_FIRST_ROW),
                children: <TextSpan>[
                  TextSpan(text: "${Dnd5eRuleset.prettyPrintResult(roll)}\n",),
                  TextSpan(text: Dnd5eRuleset.prettyPrintResultDetails(roll), style: TextStyle(color: preferences.resultDetailsTextColor),),
                ],
              ),
            )
          ),
      );
    } else {
      result = Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              Dnd5eRuleset.prettyPrintResult(roll),
              textAlign: TextAlign.start,
              style: TextStyle(color: preferences.resultTextColor, fontSize: !firstRow ? HISTORY_FONT_SIZE_DEFAULT : HISTORY_FONT_SIZE_FIRST_ROW),
            ),
          ),
        ],
      );

    }
    return result;
  }
}
