import "package:flutter/material.dart";
import "package:dice_tower/dice_tower.dart";
import "package:flutter/services.dart";
import "package:open_roller/settings.dart";
import "package:open_roller/ui_components/dnd_calculator.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
//import "package:material_design_icons_flutter/material_design_icons_flutter.dart";

void main() {
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

enum UiOrientation {Left, Top, Right, Bottom}

const double HISTORY_FONT_SIZE_DEFAULT = 12;
const double HISTORY_FONT_SIZE_FIRST_ROW = 24;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: OpenRollerState(title: "Flutter Demo Home Page"),

    );
  }
}

class OpenRollerState extends StatefulWidget {
  OpenRollerState({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _OpenRollerStateState createState() => _OpenRollerStateState();
}

class _OpenRollerStateState extends State<OpenRollerState> {
  var _history = List<RollResult>();
  UiOrientation uiOrientation = UiOrientation.Bottom;
  Orientation _orientation;

  void _updateHistory(RollResult roll) {
    setState(() {
      _history.insert(0, roll);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]); // Disable the status bar.

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
//      appBar: AppBar( // TODO Keep this or remove it once you implement user preferences.
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
////        title: Text(widget.title),
//
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.settings),
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => SettingsRoute()),
//              );
//            },
//          ),
//        ],
//      ),
      body: OrientationBuilder (
          builder: (context, orientation) {
            return _buildBody(orientation);
          }
        ),
    );
  }

  Widget _buildBody(Orientation orientation) {
    if (orientation == Orientation.portrait) {
      return Container (
          child: Column(
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
          )
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
        color: Color.fromARGB(0, 0, 0, 0),
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
                    style: TextStyle(fontSize: !firstRow ? HISTORY_FONT_SIZE_DEFAULT : HISTORY_FONT_SIZE_FIRST_ROW, color: Colors.lightBlue),
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
                style: TextStyle(color: Colors.black, fontSize: !firstRow ? HISTORY_FONT_SIZE_DEFAULT : HISTORY_FONT_SIZE_FIRST_ROW),
                children: <TextSpan>[
                  TextSpan(text: "${Dnd5eRuleset.prettyPrintSum(roll)}\n",),
                  TextSpan(text: Dnd5eRuleset.prettyPrintResultDetails(roll), style: TextStyle(color: Colors.black.withOpacity(0.5)),),
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
              Dnd5eRuleset.prettyPrintSum(roll),
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: !firstRow ? HISTORY_FONT_SIZE_DEFAULT : HISTORY_FONT_SIZE_FIRST_ROW),
            ),
          ),
        ],
      );

    }
    return result;
  }
}
