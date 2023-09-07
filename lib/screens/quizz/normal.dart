import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ecodim_app/screens/quizz/felicitationnormal_page.dart';

class Question {
  final String question;
  final bool answer;

  Question(this.question, this.answer);
}

class NormalLevel extends StatefulWidget {
  @override
  _NormalLevelState createState() => _NormalLevelState();
}

class _NormalLevelState extends State<NormalLevel> {
  final List<Question> _questions = [
    Question("Jésus est né à Bethléem.", true),
    Question(
        "Marie et Joseph étaient mariés avant la naissance de Jésus.", false),
    Question("Les Rois Mages étaient au nombre de quatre.", false),
    Question("Moïse a mené les Israélites à travers la mer Rouge.", true),
    Question("L'Arche de l'Alliance a été construite par Noé.", false),
    Question(
        "Le Nouveau Testament compte plus de livres que l'Ancien Testament.",
        false),
    Question("L'apôtre Paul était originellement appelé Saul.", true),
    Question("La dernière Cène était un repas de Pâques.", true),
    // ... Ajoutez d'autres questions ici ...
  ];

  late List<Question> _shuffledQuestions;
  int _questionIndex = 0;
  bool _showResult = false;
  bool _userAnswered = false;
  bool _isCorrect = false;
  int _secondsLeft = 10;
  final audioPlayer = AudioPlayer();

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _shuffledQuestions = _questions.toList()..shuffle();
    _startTimer();
  }

  // void jouemusic() {
  //   audioPlayer.play(AssetSource('audio/rire.mp3'));
  // }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _timer.cancel();
          if (!_showResult) {
            _checkAnswer(null); // Pas de réponse à la fin des 10 secondes
          }
        }
      });
    });
  }

  void _showNextQuestion() {
    if (_questionIndex < _shuffledQuestions.length - 1) {
      _questionIndex++;
      _secondsLeft = 10;
      _userAnswered = false;
      _isCorrect = false;
      _startTimer();
    } else {
      _timer.cancel();
      setState(() {
        _showResult = true;
      });
    }
  }

  String goodAnswerSound = 'audio/good_answer.mp3';
  String badAnswerSound = 'audio/rire.mp3';

  void _checkAnswer(bool? userAnswer) async {
    if (!_userAnswered) {
      _userAnswered = true;
      _timer.cancel();

      if (userAnswer != null) {
        _isCorrect = _shuffledQuestions[_questionIndex].answer == userAnswer;
        if (_isCorrect) {
          // Jouer le son de la bonne réponse
          await audioPlayer.play(AssetSource(goodAnswerSound));
        } else {
          // Jouer le son de la mauvaise réponse
          await audioPlayer.play(AssetSource(badAnswerSound));
        }
      } else {
        _isCorrect = false;
      }

      setState(() {
        _secondsLeft = 5;
      });

      Timer(const Duration(seconds: 5), () {
        audioPlayer.stop;
        _showNextQuestion();
      });
    }
  }

  // void _checkAnswer(bool? userAnswer) {
  //   if (!_userAnswered) {
  //     _userAnswered = true;
  //     _timer.cancel();

  //     if (userAnswer != null) {
  //       _isCorrect = _shuffledQuestions[_questionIndex].answer == userAnswer;
  //     } else {
  //       _isCorrect = false;
  //     }

  //     setState(() {
  //       _secondsLeft = 5;
  //     });

  //     Timer(const Duration(seconds: 2), () {
  //       _showNextQuestion();
  //     });
  //   }
  // }

  // @override
  Widget build(BuildContext context) {
    Color customColor = Color(0xFF00695C);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Quiz pour Enfants')),
        body: Container(
          decoration: BoxDecoration(color: customColor),
          child: Center(
            child: _showResult
                ? _isCorrect
                    ? CongratulationsPage()
                    : const Text("Quiz terminé!")
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _shuffledQuestions[_questionIndex].question,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'Alegreya1',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Image.asset(
                        'assets/normal.png',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(height: 20),
                      _userAnswered
                          ? _isCorrect
                              ? Image.asset(
                                  'assets/correctnormal.gif',
                                  width: 100,
                                  height: 100,
                                )
                              : Image.asset(
                                  'assets/incorrectnormal.png',
                                  width: 100,
                                  height: 100,
                                )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () => _checkAnswer(true),
                                  child: Image.asset(
                                    'assets/vrai.png',
                                    width: 100,
                                    height: 60,
                                  ),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () => _checkAnswer(false),
                                  child: Image.asset(
                                    'assets/faux.png',
                                    width: 100,
                                    height: 60,
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 20),
                      Text("Temps restant: $_secondsLeft s",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz pour Enfants',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NormalLevel(),
    );
  }
}
