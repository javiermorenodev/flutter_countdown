import 'package:flutter_countdown/widgets/select_duration.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _selectDuration = 1;

  @override
  void initState() {
    super.initState();
  }

  String get timerString {
    switch (_selectDuration) {
      case 1:
        return '00:05';
      case 2:
        return '00:30';
      default:
        return '01:00';
    }
  }

  _resetTimer(Duration duration, int select) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelectDuration(
                  onPressed: () => _resetTimer(const Duration(seconds: 5), 1),
                  label: '00:05',
                  select: _selectDuration == 1,
                ),
                SelectDuration(
                  onPressed: () => _resetTimer(const Duration(seconds: 30), 2),
                  label: '00:30',
                  select: _selectDuration == 2,
                ),
                SelectDuration(
                  onPressed: () => _resetTimer(const Duration(seconds: 60), 3),
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
            FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text("Play"),
            ),
          ],
        ),
      ),
    );
  }
}
