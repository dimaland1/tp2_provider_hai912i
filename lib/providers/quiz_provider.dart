import 'package:flutter/foundation.dart';
import '../models/question.dart';

class QuizProvider with ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLastQuestionResponded = false;

  final List<Question> _questions = [
    Question(
        questionText: "La France a dû céder l'Alsace et la Moselle (une région de la Lorraine) à l'Allemagne après la guerre de 1870-1871.",
        isCorrect: true,
        link: "https://plus.unsplash.com/premium_photo-1726721290693-12f2db0efa4d?q=80&w=1925&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    ),
    Question(
        questionText: "Paris est la capitale de la France.",
        isCorrect: true, link: "https://plus.unsplash.com/premium_photo-1661919210043-fd847a58522d?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    ),
    Question(
        questionText: "La Tour Eiffel a été construite au 20ème siècle.",
        isCorrect: false,
        link: "https://images.unsplash.com/photo-1549271456-0c1e6f59ab66?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    ),
  ];

  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  List<Question> get questions => _questions;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;
  bool get isLastQuestionResponded => _isLastQuestionResponded;

  void checkAnswer(bool userChoice) {
    if (_questions[_currentQuestionIndex].isCorrect == userChoice) {
      _score++;
    }

    if (isLastQuestion) {
      _isLastQuestionResponded = true;
    } else {
      _currentQuestionIndex++;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _isLastQuestionResponded = false;
    notifyListeners();
  }
}