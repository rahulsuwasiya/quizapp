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
      title: ' What is 2 + 2 ?',
      options: {'5': false, '30': false, '4': true, '10': false},
    ),
    Question(
      id: '11',
      title: ' What is 10 + 20 ?',
      options: {'50': false, '30': true, '40': false, '10': false},
    ),
     Question(
      id: '12',
      title: ' What is 2 + 2 ?',
      options: {'5': false, '30': false, '4': true, '10': false},
    ),
    Question(
      id: '13',
      title: ' What is 10 + 20 ?',
      options: {'50': false, '30': true, '40': false, '10': false},
    ),
     Question(
      id: '14',
      title: ' What is 2 + 2 ?',
      options: {'5': false, '30': false, '4': true, '10': false},
    ),
    Question(
      id: '15',
      title: ' What is 10 + 20 ?',
      options: {'50': false, '30': true, '40': false, '10': false},
    ),
     Question(
      id: '16',
      title: ' What is 2 + 2 ?',
      options: {'5': false, '30': false, '4': true, '10': false},
    ),
    Question(
      id: '17',
      title: ' What is 10 + 20 ?',
      options: {'50': false, '30': true, '40': false, '10': false},
    ),
     Question(
      id: '18',
      title: ' What is 2 + 2 ?',
      options: {'5': false, '30': false, '4': true, '10': false},
    ),
    Question(
      id: '19',
      title: ' What is 10 + 20 ?',
      options: {'50': false, '30': true, '40': false, '10': false},
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
