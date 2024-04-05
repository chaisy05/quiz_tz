import 'dart:async';
import 'package:flutter/material.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<String> questions = [
    "Who is known for the theory of relativity?",
    "Who discovered penicillin?",
    "Who proposed the heliocentric model of the solar system?",
    "Who is considered the father of modern physics?",
    "Who developed the theory of evolution by natural selection?",
    "Who is known for the laws of planetary motion?",
    "Who discovered the electron?",
    "Who formulated the laws of motion and universal gravitation?",
    "Who proposed the double helix structure of DNA?",
    "Who invented the telephone?",
    "Who discovered the X-ray?",
    "Who is known for the theory of electromagnetism?",
    "Who is known for the uncertainty principle?",
    "Who developed the first successful polio vaccine?",
    "Who discovered the neutron?",
    "Who proposed the Big Bang theory?",
    "Who discovered radioactivity?",
    "Who developed the first programmable digital computer?",
    "Who is considered the founder of modern chemistry?",
    "Who discovered the circulation of blood in the human body?",
  ];

  List<String> answers = [
    "Albert Einstein",
    "Alexander Fleming",
    "Nicolaus Copernicus",
    "Isaac Newton",
    "Charles Darwin",
    "Johannes Kepler",
    "J.J. Thomson",
    "Isaac Newton",
    "James Watson and Francis Crick",
    "Alexander Graham Bell",
    "Wilhelm Conrad Röntgen",
    "James Clerk Maxwell",
    "Werner Heisenberg",
    "Jonas Salk",
    "James Chadwick",
    "Georges Lemaître",
    "Marie Curie",
    "John Atanasoff",
    "Antoine Lavoisier",
    "William Harvey",
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  int secondsRemaining = 30;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          _nextQuestion();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              questions[currentQuestionIndex],
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Time remaining: $secondsRemaining seconds',
              style: TextStyle(fontSize: 16.0),
            ),
            ElevatedButton(
              onPressed: () {
                _checkAnswer("Albert Einstein");
              },
              child: Text('Albert Einstein'),
            ),
            ElevatedButton(
              onPressed: () {
                _checkAnswer("Alexander Fleming");
              },
              child: Text('Alexander Fleming'),
            ),
            ElevatedButton(
              onPressed: () {
                _checkAnswer("Nicolaus Copernicus");
              },
              child: Text('Nicolaus Copernicus'),
            ),
            ElevatedButton(
              onPressed: () {
                _checkAnswer("Isaac Newton");
              },
              child: Text('Isaac Newton'),
            ),
          ],
        ),
      ),
    );
  }

  void _checkAnswer(String selectedAnswer) {
    if (selectedAnswer == answers[currentQuestionIndex]) {
      score++;
    }
    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        secondsRemaining = 30; // Reset the timer for the new question
      } else {
        timer.cancel(); // Turn off the timer
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(score: score)),
        );
      }
    });
  }
}
