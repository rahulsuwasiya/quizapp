import 'package:flutter/material.dart';
import 'package:quizapp/constants.dart';
import '../models/question_model.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/result_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Question> _questions = [
    Question(
      id: '10',
      title: '\nSCD, TEF, UGH, ____, WK',
      options: {'CMN': false, 'UJI': false, 'VIJ': true, 'IJT': false},
    ),
    Question(
      id: '11',
      title:
          '\nWhich of the following term is used for a function defined inside a class?',
      options: {
        'Member Variable': false,
        'Member function': true,
        'Class function': false,
        'Classic function': false
      },
    ),
    Question(
      id: '12',
      title:
          '\nIf A is the brother of B; B is the sister of C; and C is the father of D, how D is related to A?',
      options: {
        'Brother': false,
        'Sister': false,
        'Nephew/Niece': true,
        'Cannot be determined': false
      },
    ),
    Question(
      id: '13',
      title: '\nPeacock : India :: Bear : ?',
      options: {
        'Australia': false,
        'Russia': true,
        'America': false,
        'England': false
      },
    ),
    Question(
      id: '14',
      title: '\nSynonym of COMMENSURATE',
      options: {
        'Measurable': false,
        'Begining': false,
        'Proportionate': true,
        'Appropriate': false
      },
    ),
    Question(
      id: '15',
      title: '\nGod is ......',
      options: {
        'Graceful': false,
        'Gracious': true,
        'Grateful': false,
        'Greatful': false
      },
    ),
    Question(
      id: '16',
      title: '\nFind the correctly spelt word.',
      options: {
        'Exterminatte': false,
        'Inexpliccable': false,
        'Offspring': true,
        'Reffere': false
      },
    ),
    Question(
      id: '17',
      title: '\nAntonym of MINOR',
      options: {'Big': false, 'Major': true, 'Tall': false, 'Heavy': false},
    ),
    Question(
      id: '18',
      title: '\nOne word substitution for: That which cannot be believed',
      options: {
        'Unreliable': false,
        'Implausible': false,
        'Incredible': true,
        'Incredulous': false
      },
    ),
    Question(
      id: '19',
      title:
          '\nChoose the correct meaning of proverb/idiom: To hit the nail right on the head',
      options: {
        'To announce one\'s fixed views': false,
        'To do the right thing': true,
        'To destroy one\'s reputation': false,
        'To teach someone a lesson': false
      },
    )
  ];

  int index = 0;
  bool isPressed = false;
  int score = 0;
  bool isAlreadySelected = false;

  void nextQuestion() {
    if (index == _questions.length - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: _questions.length,
                onPressed: startOver,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select an option!'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        foregroundColor: const Color(0xFFE7E7E7),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Questionwidget(
                indexAction: index,
                question: _questions[index].title,
                totalQuestions: _questions.length),
            const Divider(color: neutral),
            const SizedBox(height: 25.0),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () => checkAnswerAndUpdate(
                    _questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
