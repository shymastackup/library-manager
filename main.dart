import 'dart:io';
import 'book.dart';
import 'author.dart';
import 'member.dart';
import 'library_manager.dart';

void main() async {
  final libraryManager = LibraryManager('library_data.json');

  try {
    await libraryManager.loadLibraryData();
  } catch (e) {
    print('Error loading library data: $e');
  }

  while (true) {
    print('\nLibrary Management System');
    print('1. Add Book');
    print('2. Delete Book');
    print('3. View Books');
    print('4. Add Author');
    print('5. Delete Author');
    print('6. View Authors');
    print('7. Add Member');
    print('8. Delete Member');
    print('9. View Members');
    print('10. Save & Exit');

    print('Please choose an option: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        _addBook(libraryManager);
        break;
      case '2':
        _deleteBook(libraryManager);
        break;
      case '3':
        libraryManager.viewBooks();
        break;
      case '4':
        _addAuthor(libraryManager);
        break;
      case '5':
        _deleteAuthor(libraryManager);
        break;
      case '6':
        libraryManager.viewAuthors();
        break;
      case '7':
        _addMember(libraryManager);
        break;
      case '8':
        _deleteMember(libraryManager);
        break;
      case '9':
        libraryManager.viewMembers();
        break;

      case '10':
        await libraryManager.saveLibraryData();

        print('bye bye friend!......');
        exit(0);
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void _addBook(LibraryManager libraryManager) {
  String? title;
  String? author;
  int? year;
  String? genre;
  String? isbn;

  while (title == null || title.isEmpty) {
    print('Enter book title: ');
    title = stdin.readLineSync()?.trim();
    if (title == null || title.isEmpty) {
      print('Invalid title. Please try again.');
    }
  }

  while (author == null ||
      author.isEmpty ||
      !RegExp(r'^[a-zA-Z\s.]+$').hasMatch(author)) {
    print('Enter book author (only letters,space  and dotes are allowed): ');
    author = stdin.readLineSync()?.trim();
    if (author == null ||
        author.isEmpty ||
        !RegExp(r'^[a-zA-Z\s.]+$').hasMatch(author)) {
      print(
          'Invalid name. Please enter a valid name with only letters, spaces and dotes.');
    }
  }

  while (year == null || year < 1000 || year > 2024) {
    print('Enter publication year (4-digit number): ');
    year = int.tryParse(stdin.readLineSync()?.trim() ?? '');
    if (year == null || year < 1000 || year > 2024) {
      print(
          'Invalid publication year. Please enter a 4-digit number between 1000 and 2024.');
    }
  }

  while (genre == null ||
      genre.isEmpty ||
      RegExp(r'^[a-zA-Z\s.]+$').hasMatch(genre)) {
    print('Enter author name (only letters,space  and dotes are allowed): ');
    genre = stdin.readLineSync()?.trim();
    if (genre == null ||
        genre.isEmpty ||
        !RegExp(r'^[a-zA-Z\s.]+$').hasMatch(genre)) {
      print(
          'Invalid name. Please enter a valid name with only letters, spaces and dotes.');
    }
  }

  while (isbn == null || isbn.isEmpty) {
    print('Enter ISBN: ');
    isbn = stdin.readLineSync()?.trim();
    if (isbn == null || isbn.isEmpty) {
      print('Invalid ISBN. Please try again.');
    }
  }

  Book book = Book(
    title: title,
    author: author,
    publicationYear: year,
    genre: genre,
    isbn: isbn,
  );
  libraryManager.addBook(book);
}

void _deleteBook(LibraryManager libraryManager) {
  print('Enter ISBN of the book to delete: ');
  String? isbn = stdin.readLineSync();

  if (isbn != null) {
    print('Are you sure you want to delete this book? (yes/no)');
    String? confirmation = stdin.readLineSync();
    if (confirmation?.toLowerCase() == 'yes') {
      libraryManager.deleteBook(isbn);
    } else {
      print('Deletion cancelled.');
    }
  } else {
    print('Invalid input. Please try again.');
  }
}

void _addAuthor(LibraryManager libraryManager) {
  String? name;
  DateTime? dob;

  while (name == null ||
      name.isEmpty ||
      !RegExp(r'^[a-zA-Z\s.]+$').hasMatch(name)) {
    print('Enter author name (only letters, spaces, and dotes available): ');
    name = stdin.readLineSync()?.trim();
    if (name == null ||
        name.isEmpty ||
        !RegExp(r'^[a-zA-Z\s.]+$').hasMatch(name)) {
      print(
          'Invalid name. Please enter a valid name with only letter,space and dotes are avilable.');
    }
  }

  while (dob == null) {
    print('Enter author date of birth (yyyy-mm-dd): ');
    String? dobString = stdin.readLineSync()?.trim();
    dob = DateTime.tryParse(dobString ?? '');
    if (dob == null) {
      print('Invalid date of birth. Please use the format yyyy-mm-dd.');
    }
  }

  Author author = Author(
    name: name,
    dateOfBirth: dob,
  );
  libraryManager.addAuthor(author);
}

void _deleteAuthor(LibraryManager libraryManager) {
  print('Enter author name to delete: ');
  String? name = stdin.readLineSync()?.trim();

  if (name != null && name.isNotEmpty) {
    print('Are you sure you want to delete this author? (yes/no)');
    String? confirmation = stdin.readLineSync()?.trim().toLowerCase();

    while (confirmation != 'yes' && confirmation != 'no') {
      print('Invalid input. Please enter "yes" or "no": ');
      confirmation = stdin.readLineSync()?.trim().toLowerCase();
    }

    if (confirmation == 'yes') {
      libraryManager.deleteAuthor(name);
      print('Author deleted successfully.');
    } else {
      print('Deletion cancelled.');
    }
  } else {
    print('Invalid input. Please enter a valid author name.');
  }
}

void _addMember(LibraryManager libraryManager) {
  print('Enter member name: ');
  String? name = stdin.readLineSync();

  print('Enter member ID: ');
  String? memberId = stdin.readLineSync();

  if (name != null && memberId != null) {
    Member member = Member(
      name: name,
      memberId: memberId,
    );
    libraryManager.addMember(member);
  } else {
    print('Invalid input. Please try again.');
  }
}

void _deleteMember(LibraryManager libraryManager) {
  print('Enter member ID to delete: ');
  String? memberId = stdin.readLineSync();

  if (memberId != null) {
    print('Are you sure you want to delete this member? (yes/no)');
    String? confirmation = stdin.readLineSync();
    if (confirmation?.toLowerCase() == 'yes') {
      libraryManager.deleteMember(memberId);
    } else {
      print('Deletion cancelled.');
    }
  } else {
    print('Invalid input. Please try again.');
  }
}
