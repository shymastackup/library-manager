import 'book.dart';

class Member {
  String name;
  String memberId;
  List<Book> borrowedBooks;

  Member({
    required this.name,
    required this.memberId,
    this.borrowedBooks = const [],
  });

  void borrowBook(Book book, DateTime dueDate) {
    if (book.isLent) {
      book.lendBook(dueDate);
      borrowedBooks.add(book);
      print('Book borrowed successfully.');
    } else {
      print('Book is currently lent out.');
    }
  }

  void returnBook(Book book) {
    if (borrowedBooks.contains(book)) {
      book.returnBook();
      borrowedBooks.remove(book);
      print('Book returned successfully.');
    } else {
      print('This member did not borrow this book.');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'memberId': memberId,
      'borrowedBooks': borrowedBooks.map((b) => b.toJson()).toList(),
    };
  }

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      memberId: json['memberId'],
      borrowedBooks: (json['borrowedBooks'] as List)
          .map((bookJson) => Book.fromJson(bookJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return '$name (Member ID: $memberId)';
  }
}
