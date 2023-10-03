import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/collapsible_navigation_drawer/provider/navigation_provider.dart';
import 'package:lya_encuestas/screens/main_screen.dart';
import 'package:lya_encuestas/widgets/pickers/category_picker/category_picker_provider.dart';
import 'package:lya_encuestas/widgets/pickers/channel_picker/channel_picker_provider.dart';
import 'package:lya_encuestas/widgets/pickers/district_picker/district_picker_provider.dart';
import 'package:lya_encuestas/widgets/pickers/period_picker/period_picker_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //all widgets are rendered here
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Navigation Drawer';

  @override
  Widget build(BuildContext context) {
    Map<int, Color> colorCodes = {
      50: Constants.COLOR_PRIMARY,
      100: Constants.COLOR_PRIMARY,
      200: Constants.COLOR_PRIMARY,
      300: Constants.COLOR_PRIMARY,
      400: Constants.COLOR_PRIMARY,
      500: Constants.COLOR_PRIMARY,
      600: Constants.COLOR_PRIMARY,
      700: Constants.COLOR_PRIMARY,
      800: Constants.COLOR_PRIMARY,
      900: Constants.COLOR_PRIMARY,
    };
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => DistrictPickerProvider()),
        ChangeNotifierProvider(create: (context) => CategoryPickerProvider(null)),
        ChangeNotifierProvider(create: (context) => ChannelPickerProvider()),
        ChangeNotifierProvider(create: (context) => PeriodPickerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
            primarySwatch:
                MaterialColor(Constants.COLOR_PRIMARY.value, colorCodes),
            primaryTextTheme: const TextTheme(
              headline6: TextStyle(color: Colors.black),
            ),
            textTheme:
                const TextTheme(headline6: TextStyle(color: Colors.black)),
            primaryColor: Colors.black,
            backgroundColor: Colors.white),
        home: const MainScreen(),
      ),
    );
  }
}
