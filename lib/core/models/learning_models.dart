enum GameMode { learn, practice, challenge }

class LearningItem {
  final String id;
  final String word;
  final String categoryId;
  final String sentence;

  LearningItem({required this.id, required this.word, required this.categoryId, required this.sentence});
}

class LearningCategory {
  final String id;
  final String name;
  final String icon;
  final List<LearningItem> items;

  LearningCategory({required this.id, required this.name, required this.icon, required this.items});
}
