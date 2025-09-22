import 'package:hive/hive.dart';

class LocalStorageService {
  final Box _box = Hive.box('suggestions');

  void saveSuggestion(String suggestion) {
    _box.add({"text": suggestion, "time": DateTime.now().toString()});
  }

  List<Map> getSuggestions() {
    return _box.values.cast<Map>().toList();
  }
}
