import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: QaPage(),
        ),
      ),
    );
  }
}

class QaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QaPageState();
  }
}

class _QaPageState extends State<QaPage> {
  List<Widget> scoreKeeper = [];
  bool areMoreQ = true;

  void addIcon(Icon icon) {
    if (!areMoreQ) {
      showQuizEndDialog();
      return;
    }
    if (quizBrain.isLastQuestion()) {
      setState(() {
        scoreKeeper.add(icon);
        showQuizEndDialog();
      });
      areMoreQ = false;
    } else {
      setState(() {
        scoreKeeper.add(icon);
        quizBrain.goToNextQuestion();
      });
    }
  }

  void keepScore(bool givenAnswer) {
    bool currentQAns = quizBrain.getQuestionAns();
    if (currentQAns == givenAnswer) {
      //answer is correct
      addIcon(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      //answer is wrong
      addIcon(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  void showQuizEndDialog() {
    Alert(
      context: this.context,
      type: AlertType.info,
      title: "Quiz Ended",
      desc: "Do you want to reset quiz?",
      buttons: [
        DialogButton(
          child: Text(
            "CLOSE",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()=>Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "RESET",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            resetQuiz();
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  void resetQuiz() {
    setState(() {
      areMoreQ = true;
      scoreKeeper.clear();
      quizBrain.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: FlatButton(
                child: Text(
                  'TRUE',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Colors.green,
                onPressed: () {
                  keepScore(true);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: FlatButton(
                child: Text(
                  'FALSE',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Colors.red,
                onPressed: () {
                  keepScore(false);
                },
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      ),
    );
  }
}
