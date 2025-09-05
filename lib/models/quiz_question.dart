class QuizQuestion{

  const QuizQuestion(this.question,this.answers);

  final String question;
  final List<String> answers;

  List<String> getShuffledAnswers(){
    final storedList = List.of(answers);
    storedList.shuffle();

    return storedList;
  }

}