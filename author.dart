import 'dart:math';
import 'book.dart';

class Author {
  String id;
  String name;
  DateTime dateOfBirth;
  List<Book> booksWritten;

  Author({
   
    required this.name,
    required this.dateOfBirth,
    this.booksWritten = const [],
  }) 
  : id = generateUniqueID();
  void addBook(Book book) {
    if (booksWritten.contains(book)) {
      booksWritten.add(book);
      print('Book added to author\'s list.');
    } else {
      print('Book is already listed for this author.');
    }
  }

  void removeBook(Book book) {
    if (booksWritten.contains(book)) {
      booksWritten.remove(book);
      print('Book removed from author\'s list.');
    } else {
      print('Book not found in author\'s list.');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'authour id': id,
      'name': name,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'booksWritten': booksWritten.map((b) => b.toJson()).toList(),
    };
  }

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      booksWritten: (json['booksWritten'] as List)
          .map((bookJson) => Book.fromJson(bookJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return '$name (DOB: ${dateOfBirth.toLocal()}) [Athor ID: $id]';
  }
}

String generateUniqueID() {
  var timestamp = DateTime.now().millisecondsSinceEpoch;
  var random = Random().nextInt(50);
  return '$timestamp$random';
}


