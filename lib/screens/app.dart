import 'package:flutter_countdown/painters/timer.dart';
import 'package:flutter_countdown/widgets/select_duration.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController animationController;

  late int _selectDuration = 1;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    super.initState();
  }

  String get timerString {
    if (animationController.value == 0.0) {
      switch (_selectDuration) {
        case 1:
          return '00:05';
        case 2:
          return '00:30';
        default:
          return '01:00';
      }
    }
    Duration duration =
        animationController.duration! * animationController.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  _resetTimer(Duration duration, int select) {
    animationController.value = 0.0;
    animationController.duration = duration;
    _selectDuration = select;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Animation'),
      ),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SelectDuration(
                      onPressed: () =>
                          _resetTimer(const Duration(seconds: 5), 1),
                      label: '00:05',
                      select: _selectDuration == 1,
                    ),
                    SelectDuration(
                      onPressed: () =>
                          _resetTimer(const Duration(seconds: 30), 2),
                      label: '00:30',
                      select: _selectDuration == 2,
                    ),
                    SelectDuration(
                      onPressed: () =>
                          _resetTimer(const Duration(seconds: 60), 3),
                      label: '01:00',
                      select: _selectDuration == 3,
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.green.withOpacity(.4),
                          ),
                          child: CustomPaint(
                            painter: TimerPainter(
                              animation: animationController,
                              backgrounColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          timerString,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            if (animationController.isAnimating) {
                              animationController.stop();
                            } else {
                              animationController.reverse(
                                  from: animationController.value == 0.0
                                      ? 1
                                      : animationController.value);
                            }
                          },
                          icon: Icon(animationController.isAnimating
                              ? Icons.pause
                              : Icons.play_arrow_rounded),
                          label: Text(animationController.isAnimating
                              ? "Pause"
                              : "Play"),
                        ),
                        if (animationController.isAnimating)
                          Row(
                            children: [
                              const SizedBox(width: 20.0),
                              FloatingActionButton.extended(
                                backgroundColor: Colors.red,
                                onPressed: () {
                                  _resetTimer(animationController.duration!,
                                      _selectDuration);
                                },
                                icon: const Icon(Icons.restore),
                                label: const Text("Reset"),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
