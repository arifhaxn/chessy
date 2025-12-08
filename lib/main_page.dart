import 'package:flutter/material.dart';
import 'dart:async';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.duration});

  final String duration;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  late int _player1Seconds;
  late int _player2Seconds;
  bool _isPlayer1Turn = true;
  late Timer _timer;
  bool _isPaused = true;

  void initState() {
    super.initState();

    final initialMinutes = int.parse(widget.duration);
    final initialSeconds = initialMinutes * 60;

    _player1Seconds = initialSeconds;
    _player2Seconds = initialSeconds;
    _isPlayer1Turn = true; // Player 1 starts with the first move
    _isPaused = true;
    _timer = Timer(Duration.zero, () {}); // Placeholder timer
  }

  // Inside _MainPageState:
  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer.cancel(); // Stop the timer when leaving the page
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/chess.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 400,
                    child: Card(
                      child: Transform.rotate(
                        angle: 3.1416,
                        child: const Center(child: Text('one side')),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 90,
                  child: Card(
                    child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.home)),
                          IconButton(
                            icon: const Icon(Icons.pause),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {},
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.refresh)),
                        ])),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const SizedBox(
                    height: 400,
                    child: Card(
                      child: Center(child: Text('other side')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
