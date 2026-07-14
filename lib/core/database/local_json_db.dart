import '../data/game_data_registry.dart';
import '../models/learning_models.dart';
import '../utils/app_logger.dart';

class LocalJsonDb {
  Future<List<LearningCategory>> fetchAllCategories() async {
    AppLogger.info("Database calling and converting static Registry to Dynamic Future Models...");
    // مستقبل میں یہاں کلاؤڈ ڈیٹا بیس یا کسٹم لوکل JSON پارسر بغیر کوڈ تبدیل کیے فٹ ہوگا
    return GameDataRegistry.getCategories();
  }
}
