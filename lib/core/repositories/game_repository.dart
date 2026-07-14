import '../database/local_json_db.dart';
import '../models/learning_models.dart';

class GameRepository {
  final LocalJsonDb _localDb;

  GameRepository({required LocalJsonDb localDb}) : _localDb = localDb;

  Future<List<LearningCategory>> loadGameData() async {
    return await _localDb.fetchAllCategories();
  }
}
