import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final Duration duration;
  const CountdownTimer({super.key, required this.duration});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remaining = widget.duration;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (remaining.inSeconds > 0) {
            remaining -= const Duration(seconds: 1);
          } else {
            _timer?.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds % 60;
    return Text(
      "$minutes:${seconds.toString().padLeft(2, '0')}",
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
    );
  }
}
