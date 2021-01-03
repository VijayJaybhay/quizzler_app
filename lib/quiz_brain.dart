import 'question.dart';
class QuizBrain{
  int _currentQuestionIndex = 0;
  List<Question> _questions = [
   Question(text:'Question 1', answer: false),
   Question(text: 'Question 2', answer: true),
   Question(text: 'Question 3', answer: true),
   Question(text: 'Question 4', answer: false),
  ];

  void goToNextQuestion(){
    if(_currentQuestionIndex < getQuestionCount()- 1){
      _currentQuestionIndex++;
    }
  }
  String getQuestionText(){
    return _questions[_currentQuestionIndex].text;
  }

  bool getQuestionAns(){
    return _questions[_currentQuestionIndex].answer;
  }

  int getQuestionCount(){
    return _questions.length;
  }

  bool isLastQuestion(){
     return _currentQuestionIndex==getQuestionCount()-1;
  }

  void reset(){
    _currentQuestionIndex = 0;
  }
 
}