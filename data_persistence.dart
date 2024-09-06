import 'dart:convert';
import 'dart:io';
import 'book.dart';
import 'author.dart';
import 'member.dart';
import 'library_manager.dart';

class DataPersistence {
  final String filePath;

  DataPersistence(this.filePath);


Future<void> saveLibraryData(List<Book> books, List<Author> authors, List<Member> members) async {
  try {
    var data = {
      'books': books.map((b) => b.toJson()).toList(),
      'authors': authors.map((a) => a.toJson()).toList(),
      'members': members.map((m) => m.toJson()).toList(),
    };
    var jsonString = jsonEncode(data);
    await File(filePath).writeAsString(jsonString);
    print('Library data saved successfully.');
  } catch (e) {
    print('Failed to save library data: $e');
  }
}

  Future<Map<String, dynamic>> loadLibraryData() async {
    try {
      var jsonString = await File(filePath).readAsString();
      var data = jsonDecode(jsonString);
      print('Library data loaded successfully.');
      return data;
    } catch (e) {
      print('Failed to load library data: $e');
      return {};
    }
  }


}
