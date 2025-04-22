import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'video.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _score = 0;
  int _questionIndex = 0;
  int _timeLeft = 120;
  late Timer _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _selectedAnswer;
  String? _correctAnswer;
  bool _isDarkMode = false; // متغير لإدارة الوضع الداكن

  final List<Map<String, dynamic>> _questions = [
 {
      'question': 'What is the main goal of sustainability?',
      'options': ['Increasing consumption', 'Protecting the environment', 'Reducing efficiency'],
      'answer': 'Protecting the environment'
    },
    {
      'question': 'Which of these is a sustainable energy source?',
      'options': ['Fossil fuels', 'Nuclear energy', 'Solar energy'],
      'answer': 'Solar energy'
    },
    {
      'question': 'Which gas is the biggest contributor to global warming?',
      'options': ['Oxygen', 'Carbon dioxide', 'Hydrogen'],
      'answer': 'Carbon dioxide'
    },
    {
      'question': 'Which of the following helps reduce waste?',
      'options': ['Burning trash', 'Recycling', 'Throwing plastic in rivers'],
      'answer': 'Recycling'
    },
    {
      'question': 'What is the best way to save water at home?',
      'options': ['Leaving the tap running', 'Fixing leaks', 'Using bottled water'],
      'answer': 'Fixing leaks'
    },
    {
      'question': 'Which of these is biodegradable?',
      'options': ['Plastic bottle', 'Banana peel', 'Glass jar'],
      'answer': 'Banana peel'
    },
    {
      'question': 'Which action reduces carbon footprint?',
      'options': ['Driving alone', 'Using public transport', 'Leaving lights on'],
      'answer': 'Using public transport'
    },
    {
      'question': 'What is the 3R principle in sustainability?',
      'options': ['React, Remove, Replace', 'Reduce, Reuse, Recycle', 'Rebuild, Restore, Reconnect'],
      'answer': 'Reduce, Reuse, Recycle'
    },
    {
      'question': 'What type of shopping bag is more eco-friendly?',
      'options': ['Plastic bag', 'Paper bag', 'Reusable fabric bag'],
      'answer': 'Reusable fabric bag'
    },
    {
      'question': 'Which practice helps protect forests?',
      'options': ['Cutting trees', 'Planting trees', 'Using more paper'],
      'answer': 'Planting trees'
    },
  ];



  @override
  void initState() {
    super.initState();
    _questions.shuffle();
    shuffleAnswers();
    startTimer();
  }

  void shuffleAnswers() {
    setState(() {
      _correctAnswer = _questions[_questionIndex]['answer'];
      _questions[_questionIndex]['options'].shuffle();
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _timer.cancel();
        goToVideoPage();
      }
    });
  }

  void checkAnswer(String selectedAnswer) {
    setState(() {
      _selectedAnswer = selectedAnswer;
    });

    if (selectedAnswer == _correctAnswer) {
      setState(() {
        _score++;
      });
      _audioPlayer.play(AssetSource('clap.mp3'));
    }

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (_questionIndex < _questions.length - 1) {
          _questionIndex++;
          _selectedAnswer = null;
          shuffleAnswers();
        } else {
          _timer.cancel();
          goToVideoPage();
        }
      });
    });
  }

  void goToVideoPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => VideoPage()),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  // دالة للتبديل بين الوضع الداكن والوضع الفاتح
  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    var questionData = _questions[_questionIndex];
    List<String> options = questionData['options'];

    // تحديد الألوان بناءً على الوضع الداكن
    final backgroundColor = _isDarkMode ? Colors.grey[900] : Colors.lightGreen[100];
    final textColor = _isDarkMode ? Colors.white : Colors.black;
    final appBarColor = _isDarkMode ? Colors.grey[800] : Colors.green;
    final buttonColor = _isDarkMode ? Colors.grey[700] : Colors.lightGreenAccent;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleDarkMode, // تبديل الوضع الداكن
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "⏳ Time left: $_timeLeft seconds",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 20),
            Text(
              questionData['question'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 20),
            Text(
              "🔢 Score: $_score",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: _selectedAnswer == null ? () => checkAnswer(option) : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 16, color: textColor),
                      backgroundColor: _selectedAnswer == null
                          ? buttonColor
                          : (option == _correctAnswer
                              ? Colors.green
                              : (option == _selectedAnswer ? buttonColor : Colors.red)),
                      foregroundColor: textColor,
                    ),
                    child: Text(option),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}