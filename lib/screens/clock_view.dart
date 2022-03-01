import 'dart:async';
import 'dart:math';

import 'package:clock_app/constants/colors.dart';
import 'package:clock_app/provider/changeTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
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
    return Container(
      width: 70.w,
      height: 70.w,
      child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(context: context),
          )),
    );
  }
}

class ClockPainter extends CustomPainter {
  ClockPainter({required this.context});
  BuildContext context;

  final dateTime = DateTime.now();
  //* 60 sec->360 deg, 1 sec ->6deg
  //* 12 hours ->360 deg , 1 hour -> 30 deg , 1 min ->0.5 deg
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY); //! size.width / 2;
    var fillBrush = Paint()
      ..color = Provider.of<ChangeTheme>(context, listen: false).isDark
          ? DarkColors.CLOCK_COLOR
          : LightColors.CLOCK_COLOR;
    var centerFillBrush = Paint()
      ..color = Provider.of<ChangeTheme>(context, listen: false).isDark
          ? DarkColors.CLOCK_OUTLINECOLOR
          : LightColors.CLOCK_OUTLINECOLOR;
    var outlineBrush = Paint()
      ..color = Provider.of<ChangeTheme>(context, listen: false).isDark
          ? DarkColors.CLOCK_OUTLINECOLOR
          : LightColors.CLOCK_OUTLINECOLOR
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var secondHandBrush = Paint()
      ..color = Provider.of<ChangeTheme>(context, listen: false).isDark
          ? DarkColors.SEC_COLOR
          : LightColors.SEC_COLOR
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;
    var minuteHandBrush = Paint()
      ..shader = Provider.of<ChangeTheme>(context, listen: false).isDark
          ? DarkColors.MIN_GRADIANT
              .createShader(Rect.fromCircle(center: center, radius: radius))
          : LightColors.MIN_GRADIANT
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;
    var hourHandBrush = Paint()
      ..shader = Provider.of<ChangeTheme>(context, listen: false).isDark
          ? DarkColors.HOUR_GRADIANT
              .createShader(Rect.fromCircle(center: center, radius: radius))
          : LightColors.HOUR_GRADIANT
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;

    // var dashBrush = Paint()
    //   ..color = Provider.of<ChangeTheme>(context, listen: false).isDark
    //       ? DarkColors.DASHBRUSH_COLOR
    //       : LightColors.DASHBRUSH_COLOR
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2
    //   ..strokeCap = StrokeCap.round;

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerY + 80 * sin(dateTime.second * 6 * pi / 180);
    //---------------------------------------
    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerY + 80 * sin(dateTime.minute * 6 * pi / 180);
    //---------------------------------------
    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerY +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);
    canvas.drawLine(center, Offset(minHandX, minHandY), minuteHandBrush);
    canvas.drawLine(center, Offset(secHandX, secHandY), secondHandBrush);
    canvas.drawCircle(center, 10, centerFillBrush);

    // var outerCircleRadius = radius;
    // var innerCircleRadius = radius - 15;
    // for (double i = 0; i < 360; i += 90) {
    //   var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
    //   var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

    //   var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
    //   var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
    //   canvas.drawLine(Offset(x1, y1), Offset(x2, y2),
    //       dashBrush); //surely test canvas.drawLine(Offset(x1, y1), Offset(x2/2, y2/2), dashBrush);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
