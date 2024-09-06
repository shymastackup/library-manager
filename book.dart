class Book {
  String title;
  String author;
  int publicationYear;
  String genre;
  String isbn;
  bool isLent;
  DateTime? dueDate;

  Book({
    required this.title,
    required this.author,
    required this.publicationYear,
    required this.genre,
    required this.isbn,
    this.isLent = false,
    this.dueDate,
  });

  void lendBook(DateTime dueDate) {
    if (isLent) {
      this.isLent = true;
      this.dueDate = dueDate;
      print('Book lent successfully. Due date is $dueDate.');
    } else {
      print('Book is already lent out.');
    }
  }

  void returnBook() {
    if (isLent) {
      isLent = false;
      dueDate = null;
      print('Book returned successfully.');
    } else {
      print('This book was not lent out.');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'publicationYear': publicationYear,
      'genre': genre,
      'isbn': isbn,
      'isLent': isLent,
      'dueDate': dueDate?.toString(),
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      publicationYear: json['publicationYear'],
      genre: json['genre'],
      isbn: json['isbn'],
      isLent: json['isLent'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    );
  }

  @override
  String toString() {
    return '$title by $author (ISBN: $isbn)';
  }
}

