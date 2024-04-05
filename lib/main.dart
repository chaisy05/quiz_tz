import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuizScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Famous Scientists'),
      ),
    );
  }
}

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

  List<List<String>> answers = [
    ["Albert Einstein", "Isaac Newton", "Galileo Galilei", "Nikola Tesla"],
    ["Alexander Fleming", "Louis Pasteur", "Marie Curie", "Robert Koch"],
    ["Nicolaus Copernicus", "Galileo Galilei", "Johannes Kepler", "Isaac Newton"],
    ["Isaac Newton", "Galileo Galilei", "Albert Einstein", "Niels Bohr"],
    ["Charles Darwin", "Gregor Mendel", "Alfred Russel Wallace", "James Watson and Francis Crick"],
    ["Johannes Kepler", "Nicolaus Copernicus", "Galileo Galilei", "Isaac Newton"],
    ["J.J. Thomson", "Ernest Rutherford", "Niels Bohr", "Robert Millikan"],
    ["Isaac Newton", "Galileo Galilei", "Albert Einstein", "Niels Bohr"],
    ["James Watson and Francis Crick", "Linus Pauling", "Rosalind Franklin", "Francis Crick"],
    ["Alexander Graham Bell", "Thomas Edison", "Nikola Tesla", "Guglielmo Marconi"],
    ["Wilhelm Conrad Röntgen", "Antoine Henri Becquerel", "Marie Curie", "Max Planck"],
    ["James Clerk Maxwell", "Michael Faraday", "Isaac Newton", "Niels Bohr"],
    ["Werner Heisenberg", "Erwin Schrödinger", "Max Planck", "Albert Einstein"],
    ["Jonas Salk", "Albert Sabin", "Edward Jenner", "Louis Pasteur"],
    ["James Chadwick", "Ernest Rutherford", "Niels Bohr", "J.J. Thomson"],
    ["Georges Lemaître", "Albert Einstein", "Edwin Hubble", "Stephen Hawking"],
    ["Marie Curie", "Ernest Rutherford", "Antoine Henri Becquerel", "Niels Bohr"],
    ["John Atanasoff", "Alan Turing", "Charles Babbage", "John von Neumann"],
    ["Antoine Lavoisier", "Robert Boyle", "John Dalton", "Dmitri Mendeleev"],
    ["William Harvey", "Andreas Vesalius", "Claudius Galenus", "Herophilos"],
  ];

  List<int> correctAnswers = [
    0,  // Index of correct answer for the first question
    0,  // Index of correct answer for the second question
    0,  // Nicolaus Copernicus
    0,  // Isaac Newton
    0,  // Charles Darwin
    0,  // Johannes Kepler
    0,  // J.J. Thomson
    0,  // Isaac Newton
    0,  // James Watson and Francis Crick
    0,  // Alexander Graham Bell
    0,  // Wilhelm Conrad Röntgen
    0,  // James Clerk Maxwell
    0,  // Werner Heisenberg
    0,  // Jonas Salk
    0,  // James Chadwick
    0,  // Georges Lemaître
    0,  // Marie Curie
    0,  // John Atanasoff
    0,  // Antoine Lavoisier
    0,  // William Harvey
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  int timerValue = 30;
  late Timer timer;
  int correctAnswersCount = 0;
  int incorrectAnswersCount = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerValue > 0) {
        setState(() {
          timerValue--;
        });
      } else {
        timer.cancel();
        _nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentAnswers = answers[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                questions[currentQuestionIndex],
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Time left: $timerValue seconds',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 20.0),
            ...currentAnswers.map((answer) {
              return ElevatedButton(
                onPressed: () {
                  _checkAnswer(answer, currentAnswers.indexOf(answer));
                },
                child: Text(answer),
              );
            }).toList(),
            if (timerValue == 0) Text('Time is up!'),
          ],
        ),
      ),
    );
  }

  void _checkAnswer(String selectedAnswer, int index) {
    if (selectedAnswer == answers[currentQuestionIndex][correctAnswers[currentQuestionIndex]]) {
      score++;
      correctAnswersCount++;
      // Show correct answer
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correct!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      incorrectAnswersCount++;
      // Show incorrect answer
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect. Correct answer: ${answers[currentQuestionIndex][correctAnswers[currentQuestionIndex]]}'),
          backgroundColor: Colors.red,
        ),
      );
    }
    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      timer.cancel();
      timerValue = 30;
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        startTimer();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(score: score, correctAnswersCount: correctAnswersCount, incorrectAnswersCount: incorrectAnswersCount)),
        );
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int correctAnswersCount;
  final int incorrectAnswersCount;

  ResultScreen({required this.score, required this.correctAnswersCount, required this.incorrectAnswersCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your score: $score'),
            Text('Correct answers: $correctAnswersCount'),
            Text('Incorrect answers: $incorrectAnswersCount'),
          ],
        ),
      ),
    );
  }
}
