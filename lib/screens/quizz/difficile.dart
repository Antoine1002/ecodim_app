import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class Question {
  final String question;
  final String answer;

  Question(this.question, this.answer);
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase());
  }
}

class DifficileLevel extends StatefulWidget {
  @override
  _DifficileLevelState createState() => _DifficileLevelState();
}

class _DifficileLevelState extends State<DifficileLevel>
    with TickerProviderStateMixin {
  late AnimationController _controller1 =
      AnimationController(vsync: this, duration: Duration(seconds: 4))
        ..repeat();
  late Animation<Offset> _animation1 = Tween<Offset>(
          begin: Offset(0, 0), end: Offset(1.5, 0))
      .animate(CurvedAnimation(parent: _controller1, curve: Curves.elasticIn));
  late AnimationController _fadeController1;
  final List<Question> questions = [
    Question('Qui a construit l\'arche ?', 'Noé'),
    Question('Combien de jours et de nuits a duré le déluge ?', '40'),
    Question(
        'Qui a été vendu par ses frères comme esclave en Égypte ?', 'JOSEPH'),
    Question(
        'Quel était le nom du berger qui est devenu roi d\'Israël ?', 'DAVID'),
    Question('Qui a été englouti par une baleine et a survécu ?', 'JONAS'),
    Question(
        'Quel prophète a été appelé pour libérer les Israélites de l\'esclavage en Égypte ?',
        'MOISE'),
    Question(
        'Qui a écrit la majorité des livres du Nouveau Testament de la Bible ?',
        'PAUL'),
    Question('Qui était la mère de Jésus ?', 'MARIE'),
    Question('Combien d\'apôtres Jésus avait-il ?', '12'),
    // Ajoutez d'autres questions ici
  ];

  late Question currentQuestion;
  List<TextEditingController> textControllers = [];
  bool completed = false;
  bool correctAnswer = false;
  int remainingTime = 30;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startGame();
    // _controller1.forward();
    _fadeController1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    timer.cancel();
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();

    _controller1.dispose();
  }

  // Future jouemusic() async {
  //   int result = await audioPlayer.play(assets/audio/time.mp3, isLocal: true);
  // }

  void startGame() {
    textControllers.clear();
    currentQuestion = questions[Random().nextInt(questions.length)];
    completed = false;
    correctAnswer = false;
    remainingTime = 30;
    startTimer();

    for (int i = 0; i < currentQuestion.answer.length; i++) {
      textControllers.add(TextEditingController());
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          checkAnswer();
        }
      });
    });
  }

  void checkAnswer() {
    String enteredWord = textControllers.map((controller) {
      return controller.text.toUpperCase();
    }).join('');

    if (enteredWord == currentQuestion.answer) {
      correctAnswer = true;
      if (completed) {}
    }

    setState(() {
      completed = true;
    });
  }

  void submitAnswer() {
    timer.cancel();
    checkAnswer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Difficile Level'),
        ),
        body: Column(
          children: [
            Text(
              'TEMPS RESTANTS: $remainingTime s',
              style: const TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _fadeController1,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeController1,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/tom.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SlideTransition(
                  child: Image.asset(
                    'assets/jerry.png',
                    width: 100,
                    height: 100,
                  ),
                  position: _animation1,
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 5),
                  Text(
                    completed
                        ? (correctAnswer ? 'Congratulations!' : 'Try again')
                        : currentQuestion.question,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  if (!completed)
                    FractionallySizedBox(
                      widthFactor: 0.25, // Définit la largeur à 25 % de l'écran
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: currentQuestion.answer.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 30,
                              height:
                                  30, // Ajustez cette valeur pour réduire l'espace vertical
                              child: TextField(
                                controller: textControllers[index],
                                maxLength: 1,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                ],
                                decoration: InputDecoration(
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 18),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (!completed)
                    ElevatedButton(
                      onPressed: submitAnswer,
                      child: const Text('Valider'),
                    ),
                  if (completed)
                    Column(
                      children: [Image.asset('name')],
                    ),
                  if (completed)
                    Text(
                      correctAnswer
                          ? 'Well done!'
                          : 'LA BONNE REPONSE ETAIT : ${currentQuestion.answer}',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  if (completed)
                    ElevatedButton(
                      onPressed: startGame,
                      child: const Text('RECOMMENCER'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
