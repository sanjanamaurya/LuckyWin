import 'package:flutter/material.dart';
import 'package:theluckywin/res/aap_colors.dart';
import 'dart:async';

import 'package:theluckywin/res/components/text_widget.dart';


class DragonTigerTimer extends StatefulWidget {
  final Function(int) onTimerTick;

  const DragonTigerTimer({
    Key? key,
    required this.onTimerTick,
  }) : super(key: key);

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<DragonTigerTimer> {
  late Stream<DateTime> _clockStream;

  @override
  void initState() {
    super.initState();
    _clockStream = clockStream();
  }

  Stream<DateTime> clockStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _clockStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(height: 26);
        } else {
          DateTime currentTime = snapshot.data!;
          int seconds = 30 - (currentTime.second % 30);
          String showdownSeconds = seconds.toString().padLeft(2, '0');
          String betTimeSeconds = (seconds - 10).toString().padLeft(2, '0');
          widget.onTimerTick(seconds);
          return textWidget(
              text: seconds <= 10
                  ? 'Showdown... $showdownSeconds'
                  : 'Bet time... $betTimeSeconds',
              color: AppColors.goldColor,
              fontSize: 18,
              fontWeight: FontWeight.w900);
        }
      },
    );
  }
}
