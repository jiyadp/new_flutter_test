class FaqModel {
  FaqModel(
      {required this.question, required this.answer, required this.isExpanded});
  String question;
  String answer;
  bool isExpanded = false;
}
