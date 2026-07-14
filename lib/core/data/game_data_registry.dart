import '../models/learning_models.dart';

class GameDataRegistry {
  static List<LearningCategory> getCategories() {
    return [
      LearningCategory(
        id: 'alphabet',
        name: 'Alphabet',
        icon: '🔤',
        items: List.generate(26, (index) {
          String char = String.fromCharCode(65 + index);
          return LearningItem(id: 'alpha_$index', word: char, categoryId: 'alphabet', sentence: 'This is the letter $char.');
        }),
      ),
      LearningCategory(
        id: 'fruits',
        name: 'Fruits',
        icon: '🍎',
        items: [
          LearningItem(id: 'fr_1', word: 'APPLE', categoryId: 'fruits', sentence: 'This is an Apple.'),
          LearningItem(id: 'fr_2', word: 'BANANA', categoryId: 'fruits', sentence: 'This is a Banana.'),
          LearningItem(id: 'fr_3', word: 'ORANGE', categoryId: 'fruits', sentence: 'This is an Orange.'),
        ],
      ),
      LearningCategory(
        id: 'animals',
        name: 'Animals',
        icon: '🦁',
        items: [
          LearningItem(id: 'an_1', word: 'LION', categoryId: 'animals', sentence: 'This is a Lion.'),
          LearningItem(id: 'an_2', word: 'TIGER', categoryId: 'animals', sentence: 'This is a Tiger.'),
        ],
      ),
      LearningCategory(
        id: 'birds',
        name: 'Birds',
        icon: '🦜',
        items: [
          LearningItem(id: 'bd_1', word: 'PARROT', categoryId: 'birds', sentence: 'This is a Parrot.'),
          LearningItem(id: 'bd_2', word: 'DUCK', categoryId: 'birds', sentence: 'This is a Duck.'),
        ],
      ),
      LearningCategory(
        id: 'sea_animals',
        name: 'Sea Animals',
        icon: '🐬',
        items: [
          LearningItem(id: 'sa_1', word: 'FISH', categoryId: 'sea_animals', sentence: 'This is a Fish.'),
        ],
      ),
      LearningCategory(
        id: 'insects',
        name: 'Insects',
        icon: '🦋',
        items: [
          LearningItem(id: 'ins_1', word: 'BEE', categoryId: 'insects', sentence: 'This is a Bee.'),
        ],
      ),
      LearningCategory(
        id: 'vegetables',
        name: 'Vegetables',
        icon: '🥕',
        items: [
          LearningItem(id: 'vg_1', word: 'CARROT', categoryId: 'vegetables', sentence: 'This is a Carrot.'),
        ],
      ),
      LearningCategory(
        id: 'colors',
        name: 'Colors',
        icon: '🎨',
        items: [
          LearningItem(id: 'cl_1', word: 'RED', categoryId: 'colors', sentence: 'This is Red color.'),
        ],
      ),
      LearningCategory(
        id: 'shapes',
        name: 'Shapes',
        icon: '📐',
        items: [
          LearningItem(id: 'sh_1', word: 'CIRCLE', categoryId: 'shapes', sentence: 'This is a Circle.'),
        ],
      ),
      LearningCategory(
        id: 'numbers',
        name: 'Numbers',
        icon: '🔢',
        items: [
          LearningItem(id: 'num_1', word: 'ONE', categoryId: 'numbers', sentence: 'This is number One.'),
        ],
      ),
      LearningCategory(
        id: 'family',
        name: 'Family',
        icon: '👨‍👩‍👦',
        items: [
          LearningItem(id: 'fa_1', word: 'MOTHER', categoryId: 'family', sentence: 'She is a Mother.'),
        ],
      ),
      LearningCategory(
        id: 'body_parts',
        name: 'Body Parts',
        icon: '👁️',
        items: [
          LearningItem(id: 'bp_1', word: 'EYE', categoryId: 'body_parts', sentence: 'This is your Eye.'),
        ],
      ),
      LearningCategory(
        id: 'school',
        name: 'School',
        icon: '🎒',
        items: [
          LearningItem(id: 'sc_1', word: 'BOOK', categoryId: 'school', sentence: 'This is a Book.'),
        ],
      ),
      LearningCategory(
        id: 'vehicles',
        name: 'Vehicles',
        icon: '🚗',
        items: [
          LearningItem(id: 'vh_1', word: 'CAR', categoryId: 'vehicles', sentence: 'This is a Car.'),
        ],
      ),
      LearningCategory(
        id: 'nature',
        name: 'Nature',
        icon: '🌳',
        items: [
          LearningItem(id: 'nt_1', word: 'SUN', categoryId: 'nature', sentence: 'The Sun is bright.'),
        ],
      ),
      LearningCategory(
        id: 'food',
        name: 'Food',
        icon: '🍔',
        items: [
          LearningItem(id: 'fd_1', word: 'BREAD', categoryId: 'food', sentence: 'This is delicious Bread.'),
        ],
      ),
    ];
  }
}
