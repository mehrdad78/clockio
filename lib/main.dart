import 'package:clock_app/provider/changeTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'screens/homepage.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ChangeTheme(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Clock',
        theme: ThemeData(
            textTheme: TextTheme(
                headline2: TextStyle(color:  Provider.of<ChangeTheme>(context).isDark? Colors.white:Color(0xff1d1f4f)),
                bodyText2: TextStyle(color:  Provider.of<ChangeTheme>(context).isDark? Colors.white:Color(0xff1d1f4f))),
            iconTheme: IconThemeData(color:  Provider.of<ChangeTheme>(context).isDark? Colors.white:Color(0xff1d1f4f))),
        home: HomePage(),
      );
    });
  }
}
