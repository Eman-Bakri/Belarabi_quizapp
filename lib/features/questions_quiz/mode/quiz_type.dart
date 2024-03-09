enum QuizTypes {
  quizZone,
}

QuizTypes getQuizTypeEnumFromTitle(String? title) {
  if (title == "quizZone") {
    return QuizTypes.quizZone;
  }

  return QuizTypes.quizZone;
}

class QuizType {
  late final String title, image;
  late bool active;
  late QuizTypes quizTypeEnum;
  late String description;

  QuizType({
    required this.title,
    required this.image,
    required this.active,
    required this.description,
  }) {
    image = "assets/images/$image";
    quizTypeEnum = getQuizTypeEnumFromTitle(title);
  }

/*
  static QuizType fromJson(Map<String, dynamic> parsedJson) {
    return new QuizType(
      title: parsedJson["TITLE"],
      image: parsedJson["IMAGE"],
      active: true,
    );
  }
  */
}
