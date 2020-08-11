import "package:flutter/material.dart";
import "package:dice_tower/dice_tower.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:open_roller/history.dart";
import "package:open_roller/history_bloc.dart";
import "package:open_roller/preferences_state.dart";
import "package:open_roller/settings.dart";
import "package:open_roller/ui_components/calculator_bloc.dart";
import 'package:open_roller/ui_components/calculator_events_and_states.dart';
import "package:open_roller/ui_components/dnd_calculator.dart";
import "package:persist_theme/data/models/theme_model.dart";
//import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  await PreferencesState().init();
  runApp(MyApp());
}

final _model = ThemeModel();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ThemeModel>(
      create: (_) => _model..init(),
      child: Consumer<ThemeModel>(
        builder: (context, model, child){
          return ChangeNotifierProvider (
              create: (context) => PreferencesState(),
              child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => CalculatorBloc(CSUninitialized()),
                    ),
                    BlocProvider(
                      create: (context) => HistoryBloc(BlocProvider.of<CalculatorBloc>(context)),
                    ),
                  ],
                  child: MaterialApp(
                      theme: model.theme,
                      home: OpenRoller()
                  )
              )
          );
        },
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
//  UiOrientation uiOrientation = UiOrientation.Bottom;
//  Orientation _orientation;
//  PreferencesState preferences;
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeModel>(context);
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]); // Disable the status bar.
//    preferences = Provider.of<PreferencesState>(context);

    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      body: OrientationBuilder (
        builder: (context, orientation) {
          return _buildBody(orientation);//, preferences
        }
      ),
    );
  }

  ///
  Widget _buildBody(Orientation orientation) {
    if (orientation == Orientation.portrait) {
      return Stack (
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                    flex: 5,
                    child: History()
                ),
                Expanded(
                  flex: 6,
                  child: DndCalculator(),
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
                child: History(),
              ),
              Expanded(
                flex: 5,
                child: DndCalculator(),
              ),
            ],
          )
      );
    }
  }
}
