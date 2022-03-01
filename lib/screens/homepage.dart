import 'dart:async';
import 'package:clock_app/provider/changeTheme.dart';
import 'package:clock_app/screens/clock_view.dart';
import 'package:clock_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    ClockPage(),
    Center(
      child: Text("Second"),
    )
  ];

  Widget iconWatch({String? name, String? title}) {
    return Column(
      children: [
        Image.asset(
          "images/$name.png",
          width: 15.w,
        ),
        SizedBox(
          height: 5.sp,
        ),
        Text("$title"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Clockio"),
          centerTitle: true,
          backgroundColor:
              Provider.of<ChangeTheme>(context, listen: false).isDark
                  ? DarkColors.HOMEPAGE_COLOR
                  : Colors.orange.shade300,

        ),
        backgroundColor: Provider.of<ChangeTheme>(context, listen: false).isDark
            ? DarkColors.HOMEPAGE_COLOR
            : LightColors.HOMEPAGE_COLOR,
        body: Row(
          children: [
            SizedBox(
              width: 25.w,
              child: Padding(
                padding: EdgeInsets.only(left: 5.sp, top: 10.h, bottom: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    iconWatch(name: "clock_icon", title: "Clock"),
                    iconWatch(name: "alarm_icon", title: "Alarm"),
                    iconWatch(name: "stopwatch_icon", title: "StopWatch"),
                    iconWatch(name: "timer_icon", title: "Timer"),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.white,
            ),
            Expanded(child: pages[_selectedIndex])
          ],
        ),
      ),
    );
  }
}

class ClockPage extends StatefulWidget {
  ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (time) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer!.isActive) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateTimeofNow = DateTime.now();
    var foramttedTime = DateFormat("HH:mm").format(dateTimeofNow);
    var formattedDate = DateFormat('EEE, d MMM').format(dateTimeofNow);
    return Container(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Clock",
            style: TextStyle(fontSize: 24.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            "$foramttedTime",
            style: TextStyle(fontSize: 45.sp),
          ),
          Text(
            "$formattedDate",
            style: TextStyle(fontSize: 12.sp),
          ),
          SizedBox(
            height: 2.h,
          ),
          ClockView(),
          Text(
            "Timezone",
            style: TextStyle(fontSize: 15.sp),
          ),
          SizedBox(
            height: 1.2.h,
          ),
          Row(
            children: [
              Icon(Icons.language),
              SizedBox(
                width: 16,
              ),
              Text("UTC")
            ],
          )
        ],
      ),
    );
  }
}
