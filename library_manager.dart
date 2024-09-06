// import 'book.dart';
// import 'author.dart';
// import 'member.dart';
// import 'data_persistence.dart';

// class LibraryManager {
//   List<Book> books = [];
//   List<Author> authors = [];
//   List<Member> members = [];
//   final DataPersistence dataPersistence;

//   LibraryManager(String filePath) : dataPersistence = DataPersistence(filePath);

//   void addBook(Book book) {
//     if (books.any((b) => b.isbn == book.isbn)) {
//       print('A book with this ISBN already exists.');
//       return;
//     }
//     books.add(book);
//     print('Book added successfully.');
//   }
  
//   void deleteBook(String isbn) {
//     books.removeWhere((book) => book.isbn == isbn);
//     print('Book deleted successfully.');
//   }

//   void viewBooks() {
//     if (books.isEmpty) {
//       print('No books available.');
//     } else {
//       books.forEach(print);
//     }
//   }

 

//   // void lendBook(String isbn, String memberId) {
    
   
//   // }
//   void lendBook(String isbn, String memberId) {
//   // Check if the book exists in the library
//   Book? book = findBookByISBN(isbn);
//   if (book == null) {
//     print('Error: Book with ISBN $isbn does not exist in the library.');
//     return;
//   }

//   // Check if the book is already lent out
//   if (bookLoans.containsKey(isbn)) {
//     print('Error: Book with ISBN $isbn is already lent to member ID ${bookLoans[isbn]}.');
//     return;
//   }

//   // Check if the member exists in the system
//   Member? member = findMemberById(memberId);
//   if (member == null) {
//     print('Error: Member with ID $memberId does not exist.');
//     return;
//   }

//   // Lend the book to the member
//   bookLoans[isbn] = memberId;
//   print('Success: Book with ISBN $isbn has been lent to member ID $memberId.');
// }


//   void returnBook(String isbn, String memberId) {
   
//   }



//   void addAuthor(Author author) {
//     if (authors.any((a) => a.name == author.name)) {
//       print('An author with this name already exists.');
//       return;
//     }
//     authors.add(author);
//    print('Author added successfully.');
//   }


// void deleteAuthor(String id) {
//   authors.removeWhere((author) => author.id == id);
//   print('Author deleted successfully.');
// }

//   void viewAuthors() {
//     if (authors.isEmpty) {
//       print('No authors available.');
//     } else {
//       authors.forEach(print);
//     }
//   }

//   void addMember(Member member) {
//     if (members.any((m) => m.memberId == member.memberId)) {
//       print('A member with this ID already exists.');
//       return;
//     }
//     members.add(member);
//     print('Member added successfully.');
//   }

//   void deleteMember(String memberId) {
//     members.removeWhere((member) => member.memberId == memberId);
//     print('Member deleted successfully.');
//   }

//   void viewMembers() {
//     if (members.isEmpty) {
//       print('No members available.');
//     } else {
//       members.forEach(print);
//     }
//   }


//   Future<void> saveLibraryData() async {
//     await dataPersistence.saveLibraryData(books, authors, members);
//   }

//   Future<void> loadLibraryData() async {
//     var data = await dataPersistence.loadLibraryData();
//     if (data.isNotEmpty) {
//       books = (data['books'] as List).map((b) => Book.fromJson(b)).toList();
//       authors =
//           (data['authors'] as List).map((a) => Author.fromJson(a)).toList();
//       members =
//           (data['members'] as List).map((m) => Member.fromJson(m)).toList();
//     }
//   }

// }
import 'book.dart';
import 'author.dart';
import 'member.dart';
import 'data_persistence.dart';

class LibraryManager {
  List<Book> books = [];
  List<Author> authors = [];
  List<Member> members = [];
  final DataPersistence dataPersistence;

  // This map keeps track of which books are lent to which members.
  Map<String, String> bookLoans = {}; // isbn -> memberId

  LibraryManager(String filePath) : dataPersistence = DataPersistence(filePath);

  // Adding a book
  void addBook(Book book) {
    if (books.any((b) => b.isbn == book.isbn)) {
      print('A book with this ISBN already exists.');
      return;
    }
    books.add(book);
    print('Book added successfully.');
  }

  // Deleting a book
  void deleteBook(String isbn) {
    books.removeWhere((book) => book.isbn == isbn);
    bookLoans.remove(isbn); // Remove loan record if book is deleted
    print('Book deleted successfully.');
  }

  // Viewing all books
  void viewBooks() {
    if (books.isEmpty) {
      print('No books available.');
    } else {
      books.forEach(print);
    }
  }

  // Lending a book
  void lendBook(String isbn, String memberId) {
    // Check if the book exists in the library
    Book? book = findBookByISBN(isbn);
    if (book == null) {
      print('Error: Book with ISBN $isbn does not exist in the library.');
      return;
    }

    // Check if the book is already lent out
    if (bookLoans.containsKey(isbn)) {
      print('Error: Book with ISBN $isbn is already lent to member ID ${bookLoans[isbn]}.');
      return;
    }

    // Check if the member exists in the system
    Member? member = findMemberById(memberId);
    if (member == null) {
      print('Error: Member with ID $memberId does not exist.');
      return;
    }

    // Lend the book to the member
    bookLoans[isbn] = memberId;
    print('Success: Book with ISBN $isbn has been lent to member ID $memberId.');
  }

  // Returning a book
  void returnBook(String isbn, String memberId) {
    // Check if the book is lent out to this member
    if (!bookLoans.containsKey(isbn)) {
      print('Error: Book with ISBN $isbn is not currently lent out.');
      return;
    }

    // Check if the book is lent to the given member
    if (bookLoans[isbn] != memberId) {
      print('Error: Book with ISBN $isbn is not lent to member ID $memberId.');
      return;
    }

    // Return the book
    bookLoans.remove(isbn);
    print('Success: Book with ISBN $isbn has been returned by member ID $memberId.');
  }

  // Helper method to find a book by ISBN
  Book? findBookByISBN(String isbn) {
    return books.firstWhere((book) => book.isbn == isbn);
  }

  // Helper method to find a member by ID
  Member? findMemberById(String memberId) {
    return members.firstWhere((member) => member.memberId == memberId );
  }

  // Adding an author
  void addAuthor(Author author) {
    if (authors.any((a) => a.name == author.name)) {
      print('An author with this name already exists.');
      return;
    }
    authors.add(author);
    print('Author added successfully.');
  }

  // Deleting an author
  void deleteAuthor(String id) {
    authors.removeWhere((author) => author.id == id);
    print('Author deleted successfully.');
  }

  // Viewing all authors
  void viewAuthors() {
    if (authors.isEmpty) {
      print('No authors available.');
    } else {
      authors.forEach(print);
    }
  }

  // Adding a member
  void addMember(Member member) {
    if (members.any((m) => m.memberId == member.memberId)) {
      print('A member with this ID already exists.');
      return;
    }
    members.add(member);
    print('Member added successfully.');
  }

  // Deleting a member
  void deleteMember(String memberId) {
    members.removeWhere((member) => member.memberId == memberId);
    print('Member deleted successfully.');
  }

  // Viewing all members
  void viewMembers() {
    if (members.isEmpty) {
      print('No members available.');
    } else {
      members.forEach(print);
    }
  }

  // Saving library data
  Future<void> saveLibraryData() async {
    await dataPersistence.saveLibraryData(books, authors, members);
  }

  // Loading library data
  Future<void> loadLibraryData() async {
    var data = await dataPersistence.loadLibraryData();
    if (data.isNotEmpty) {
      books = (data['books'] as List).map((b) => Book.fromJson(b)).toList();
      authors = (data['authors'] as List).map((a) => Author.fromJson(a)).toList();
      members = (data['members'] as List).map((m) => Member.fromJson(m)).toList();
    }
  }
}
