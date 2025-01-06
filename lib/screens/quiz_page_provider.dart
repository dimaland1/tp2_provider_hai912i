import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class QuizPageProvider extends StatelessWidget {
  final String title;

  const QuizPageProvider({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: NetworkImage(quizProvider.currentQuestion.link),
                  height: 150,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    quizProvider.currentQuestion.questionText,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final quizProvider = context.read<QuizProvider>();
                        quizProvider.checkAnswer(true);
                        if (quizProvider.isLastQuestionResponded) {
                          _showResultDialog(context, quizProvider);
                        }
                      },
                      child: const Text('VRAI'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final quizProvider = context.read<QuizProvider>();
                        quizProvider.checkAnswer(false);
                        if (quizProvider.isLastQuestionResponded) {
                          _showResultDialog(context, quizProvider);
                        }
                      },
                      child: const Text('FAUX'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showResultDialog(BuildContext context, QuizProvider quizProvider) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Quiz terminé!'),
            content: Text(
                'Score final: ${quizProvider.score}/${quizProvider.questions
                    .length}'),
            actions: [
              TextButton(
                child: Text(
                    quizProvider.score == 3 ? 'Terminer' : 'Recommencer'),
                onPressed: () {
                  if (quizProvider.score == 3) {
                    Navigator.of(context).pushReplacementNamed('/');
                  } else {
                    Navigator.of(context).pop();
                  }
                  quizProvider.resetQuiz();
                },
              ),
            ],
          ),
    );
  }
}