import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:ecodim_app/screens/quizz/level_page.dart';

class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}

class FacileLevel extends StatefulWidget {
  @override
  _FacileLevelState createState() => _FacileLevelState();
}

class _FacileLevelState extends State<FacileLevel> with WidgetsBindingObserver {
  final List<Question> allQuestions = [
    Question(
      questionText:
          'Quel personnage biblique a construit l\'arche selon les instructions de Dieu ?',
      options: ['Abraham', 'Moïse', 'Noé', 'David'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Dans quelle ville Jésus est-il né ?',
      options: ['Nazareth', 'Béthanie', 'Jérusalem', 'Bethléem'],
      correctOptionIndex: 3,
    ),
    Question(
      questionText:
          'Combien de commandements Dieu a-t-il donnés à Moïse sur le mont Sinaï ?',
      options: [
        'Cinq commandements',
        'Sept commandements',
        'Dix commandements',
        'Douze commandements'
      ],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Quel roi a écrit de nombreux psaumes dans la Bible ?',
      options: ['Roi Salomon', 'Roi David', 'Roi Saül', 'Roi Josias'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText:
          'Qui a été jeté dans la fosse aux lions mais a été sauvé par Dieu ?',
      options: ['Samson', 'Élie', 'Jonas', 'Daniel'],
      correctOptionIndex: 3,
    ),
    Question(
      questionText:
          'Comment Jésus a-t-il multiplié les pains pour nourrir une grande foule ?',
      options: [
        'En transformant les pierres en pains',
        'En bénissant cinq pains et deux poissons',
        'En utilisant une recette secrète',
        'En faisant un miracle de l\'eau en vin'
      ],
      correctOptionIndex: 1,
    ),
    Question(
      questionText:
          'Quel prophète a défié les prophètes de Baal sur le mont Carmel ?',
      options: ['Ézéchiel', 'Élie', 'Ézra', 'Esaïe'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Quelle est la première phrase de la Bible ?',
      options: [
        'Au commencement était la Parole',
        'Au commencement, Dieu créa les cieux et la terre',
        'Dans le commencement, il y avait la lumière',
        'Dans le commencement, l\'homme fut créé'
      ],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Qui a trahi Jésus en échange de trente pièces d\'argent ?',
      options: ['Jean', 'Pierre', 'André', 'Judas Iscariote'],
      correctOptionIndex: 3,
    ),
    Question(
      questionText: 'Quel est le premier livre de la Bible ?',
      options: ['L\'Exode', 'Les Psaumes', 'La Genèse', 'Le Lévitique'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText:
          'Quel apôtre a renié Jésus trois fois avant le chant du coq ?',
      options: ['Paul', 'Pierre', 'Jean', 'André'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText:
          'Qui a été choisi pour remplacer Judas Iscariote parmi les apôtres ?',
      options: ['Matthias', 'Paul', 'Barnabas', 'Timothée'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Quel livre de la Bible contient les dix commandements ?',
      options: ['L\'Exode', 'Le Lévitique', 'Le Deutéronome', 'Les Nombres'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Quel est le dernier livre du Nouveau Testament ?',
      options: [
        'L\'Apocalypse',
        'Les Actes des Apôtres',
        'La Première Épître aux Corinthiens',
        'L\'Évangile de Jean'
      ],
      correctOptionIndex: 0,
    ),
    Question(
      questionText:
          'Qui a été jeté dans la fournaise ardente mais n\'a pas été brûlé ?',
      options: ['Moïse', 'Daniel', 'Élie', 'Abraham'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Quel roi biblique a construit le temple à Jérusalem ?',
      options: ['Roi Saül', 'Roi David', 'Roi Salomon', 'Roi Josias'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText:
          'Quelle femme biblique a dit : "Ton peuple sera mon peuple, et ton Dieu sera mon Dieu" ?',
      options: ['Rebecca', 'Marie', 'Sara', 'Ruth'],
      correctOptionIndex: 3,
    ),
    Question(
      questionText:
          'Qui a été choisi par Dieu pour guider les Israélites hors d\'Égypte ?',
      options: ['Aaron', 'Moïse', 'David', 'Samuel'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText:
          'Quel est le fruit interdit que Adam et Ève ont mangé dans le jardin d\'Éden ?',
      options: ['Pomme', 'Orange', 'Figue', 'Raisin'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Comment Jésus a-t-il décrit le plus grand commandement ?',
      options: [
        'Aimez-vous les uns les autres',
        'Tu ne tueras point',
        'Tu aimeras le Seigneur, ton Dieu, de tout ton cœur, de toute ton âme et de toute ta pensée',
        'Honore ton père et ta mère'
      ],
      correctOptionIndex: 2,
    ),
    // ... (votre liste de questions)
  ];

  final int numberOfQuestionsToAsk = 10;
  List<Question> selectedQuestions = [];
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  int correctAnswers = 0;
  int remainingAttempts = 2;
  bool showNextQuestionButton = false;
  List<bool> questionResults = List.filled(10, false);
  int score = 0; // La variable score ne doit pas être statique

  @override
  void initState() {
    super.initState();
    jouemusic();
    WidgetsBinding.instance.addObserver(this);

    selectedQuestions =
        List<Question>.generate(numberOfQuestionsToAsk, (index) {
      int randomIndex = Random().nextInt(allQuestions.length);
      return Question(
        questionText: allQuestions[randomIndex].questionText,
        options: allQuestions[randomIndex].options,
        correctOptionIndex: allQuestions[randomIndex].correctOptionIndex,
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.stop(); // Arrêtez la musique lorsque l'application se ferme
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // L'application passe en arrière-plan, arrêtez la musique
      player.pause();
    } else if (state == AppLifecycleState.resumed) {
      // L'application reprend, reprenez la musique si elle était en pause
      player.resume();
    }
  }

  void checkAnswer() {
    if (selectedOptionIndex ==
        selectedQuestions[currentQuestionIndex].correctOptionIndex) {
      score++; // Incrémentez le score ici
      setState(() {
        correctAnswers++;
        showNextQuestionButton = true;
        questionResults[currentQuestionIndex] = true;
      });
    } else {
      setState(() {
        remainingAttempts--;
        if (remainingAttempts == 0) {
          showNextQuestionButton = true;
          questionResults[currentQuestionIndex] = false;
        }
      });
    }
  }

  final player = AudioPlayer();
  void jouemusic() {
    player.play(AssetSource('audio/tiktok.mp3'));
  }

  void moveToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < numberOfQuestionsToAsk - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        remainingAttempts = 2;
        showNextQuestionButton = false;
      } else {
        // Toutes les questions ont été répondues
        if (correctAnswers >= 5) {
          player.stop();
          // Afficher la page de félicitations si l'utilisateur a répondu correctement à au moins 5 questions
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CongratulatiionsPage(score: score)),
          );
        } else {
          player.stop();
          // Afficher la page d'encouragement si l'utilisateur n'a pas répondu correctement à au moins 5 questions
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EncouragmentPage(score: score)),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FACILE'),
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  questionResults.length,
                  (index) {
                    return Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color:
                            questionResults[index] ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  selectedQuestions[currentQuestionIndex].questionText,
                  style: TextStyle(fontSize: 25, fontFamily: 'Alegreya'),
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/question.png',
                  width: 200,
                ),
              ),
              for (int i = 0;
                  i < selectedQuestions[currentQuestionIndex].options.length;
                  i++)
                OptionButton(
                  text: selectedQuestions[currentQuestionIndex].options[i],
                  isSelected: selectedOptionIndex == i,
                  onTap: () {
                    if (!showNextQuestionButton) {
                      setState(() {
                        selectedOptionIndex = i;
                        checkAnswer();
                      });
                    }
                  },
                  isCorrect: selectedQuestions[currentQuestionIndex]
                          .correctOptionIndex ==
                      i,
                ),
              if (showNextQuestionButton)
                ElevatedButton(
                  onPressed: () {
                    moveToNextQuestion();
                  },
                  child: Text('Question Suivante'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                  ),
                ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Tentatives restantes: $remainingAttempts',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isCorrect;

  OptionButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    Color customColor = Color(0xFF33691E);
    Color buttonColor = isSelected ? Colors.blue : customColor;
    if (!isCorrect && isSelected) {
      buttonColor = Colors.red;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class CongratulatiionsPage extends StatelessWidget {
  final int score;
  final player = AudioPlayer();

  CongratulatiionsPage({required this.score});

  @override
  Widget build(BuildContext context) {
    // Exécute automatiquement la musique lorsque la page est construite
    jouemusic();

    // Utilisez la variable "score" passée en argument pour afficher le score
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 1000,
          ),
          const Text(
            'FELICITATION !!!!!!!!!!!!',
            style: TextStyle(fontSize: 25),
          ),
          Container(
            child: Image.asset('assets/congratulations.png'),
          ),
          const Text(
            'Ton score',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: score / 10.0, // Utilisez le score passé en argument
                  color: Colors.green,
                  backgroundColor: Colors.white,
                ),
              ),
              Column(
                children: [
                  Text(
                    score.toString(), // Utilisez le score passé en argument
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${(score / 10 * 100).round()}%', // Calculez le pourcentage en fonction du score passé en argument
                    style: const TextStyle(fontSize: 25),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LevelPage()),
                        );
                        player.stop();
                      },
                      child: Text('Recommencer'))
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void jouemusic() {
    player.play(AssetSource('audio/acclamation1.mp3'));
  }
}

class EncouragmentPage extends StatelessWidget {
  final int score;
  final player = AudioPlayer();

  EncouragmentPage({required this.score});

  @override
  Widget build(BuildContext context) {
    // Exécute automatiquement la musique lorsque la page est construite
    jouemusic();

    // Utilisez la variable "score" passée en argument pour afficher le score
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 1000,
          ),
          const Text(
            'YAAKOOO !!!!!!!!!!!!',
            style: TextStyle(fontSize: 25),
          ),
          Container(
            child: Image.asset('assets/yako.png'),
          ),
          const Text(
            'Ton score',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: score / 10.0, // Utilisez le score passé en argument
                  color: Colors.green,
                  backgroundColor: Colors.white,
                ),
              ),
              Column(
                children: [
                  Text(
                    score.toString(), // Utilisez le score passé en argument
                    style: const TextStyle(fontSize: 80),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${(score / 10 * 100).round()}%', // Calculez le pourcentage en fonction du score passé en argument
                    style: const TextStyle(fontSize: 25),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LevelPage()),
                        );
                        player.stop();
                      },
                      child: Text('Recommencer'))
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void jouemusic() {
    player.play(AssetSource('audio/couille.mp3'));
  }
}
