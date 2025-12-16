import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.duration});

  final String duration;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // --- STATE VARIABLES ---
  late int _player1Seconds;
  late int _player2Seconds;
  late Timer _timer;

  bool _isPlayer1Turn = true;
  bool _isPaused = true;
  final AudioPlayer _audioPlayer = AudioPlayer();

  int _activePointers = 0;


  @override
  void initState() {
    super.initState();

    final initialMinutes = int.parse(widget.duration);
    final initialSeconds = initialMinutes * 60;

    _player1Seconds = initialSeconds;
    _player2Seconds = initialSeconds;
    _timer = Timer(Duration.zero, () {});

    _audioPlayer.setSourceAsset('check.mp3');
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  // --- TIMER LOGIC FUNCTIONS ---

  void _startTimer() {
    _timer.cancel();
    setState(() {
      _isPaused = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_isPlayer1Turn) {
          _player1Seconds--;
          if (_player1Seconds == 0) _handleGameOver();
        } else {
          _player2Seconds--;
          if (_player2Seconds == 0) _handleGameOver();
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
      _timer.cancel();
    });
  }

  void _resetGame() {
    _pauseTimer();
    final initialMinutes = int.parse(widget.duration);
    final initialSeconds = initialMinutes * 60;

    setState(() {
      _player1Seconds = initialSeconds;
      _player2Seconds = initialSeconds;
      _isPlayer1Turn = true;
    });
  }

  void _handleGameOver() {
    _timer.cancel();
    print('Game Over! Time has run out.');
  }

  // --- AUDIO & GESTURE FUNCTIONS ---

  void _playCheckSound() async {
    if (!_isPaused) {
      await _audioPlayer.resume();
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play(AssetSource('check.mp3'));
    }
  }

  void _onTimerTap(int player) {
    if (_isPaused) {
      _startTimer();
      setState(() {
        _isPlayer1Turn = (player == 1) ? false : true;
      });
      return;
    }

    if ((player == 1 && _isPlayer1Turn) || (player == 2 && !_isPlayer1Turn)) {
      setState(() {
        _isPlayer1Turn = !_isPlayer1Turn;
      });
    }
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Player 1 (Top) ---
              Expanded(
                child: Listener(
                  //Track when a finger goes down
                  onPointerDown: (event) {
                    _activePointers++;
                    if (_activePointers >= 2) {
                      _playCheckSound();
                    }
                  },
                  //Track when a finger goes up (to reset count)
                  onPointerUp: (event) {
                    _activePointers--;
                  },
                  child: GestureDetector(
                    onTap: () => _onTimerTap(1),
                    child: Transform.rotate(
                      angle: 3.1416,
                      child: Card(
                        color: _isPlayer1Turn && !_isPaused
                            ? Colors.lightGreen.shade700
                            : Colors.grey.shade800,
                        margin: const EdgeInsets.all(0),
                        child: Center(
                          child: Text(
                            _formatTime(_player1Seconds),
                            style: const TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // --- Control Panel (Middle) ---
              Card(
                color: Colors.black54,
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: SizedBox(
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.home, color: Colors.white)),
                      IconButton(
                        icon: Icon(
                          _isPaused ? Icons.play_arrow : Icons.pause,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: _isPaused ? _startTimer : _pauseTimer,
                      ),
                      IconButton(
                          onPressed: _resetGame,
                          icon: const Icon(Icons.refresh, color: Colors.white)),
                    ],
                  ),
                ),
              ),

              // --- Player 2 (Bottom) ---
              Expanded(
                child: Listener(
                  //Track when a finger goes down
                  onPointerDown: (event) {
                    _activePointers++;
                    if (_activePointers == 2) {
                      _playCheckSound();
                    }
                  },
                  //Track when a finger goes up (to reset count)
                  onPointerUp: (event) {
                    _activePointers--;
                  },
                  child: GestureDetector(
                    onTap: () => _onTimerTap(2),
                    child: Card(
                      color: !_isPlayer1Turn && !_isPaused
                          ? Colors.lightGreen.shade700
                          : Colors.grey.shade800,
                      margin: const EdgeInsets.all(0),
                      child: Center(
                        child: Text(
                          _formatTime(_player2Seconds),
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
