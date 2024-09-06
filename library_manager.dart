import 'book.dart';
import 'author.dart';
import 'member.dart';
import 'data_persistence.dart';

class LibraryManager {
  List<Book> books = [];
  List<Author> authors = [];
  List<Member> members = [];
  final DataPersistence dataPersistence;

  LibraryManager(String filePath) : dataPersistence = DataPersistence(filePath);

  void addBook(Book book) {
    if (books.any((b) => b.isbn == book.isbn)) {
      print('A book with this ISBN already exists.');
      return;
    }
    books.add(book);
    print('Book added successfully.');
  }
  
  void deleteBook(String isbn) {
    books.removeWhere((book) => book.isbn == isbn);
    print('Book deleted successfully.');
  }

  void viewBooks() {
    if (books.isEmpty) {
      print('No books available.');
    } else {
      books.forEach(print);
    }
  }

 

  void lendBook(String isbn, String memberId) {
   
  }

  void returnBook(String isbn, String memberId) {
   
  }



  void addAuthor(Author author) {
    if (authors.any((a) => a.name == author.name)) {
      print('An author with this name already exists.');
      return;
    }
    authors.add(author);
   print('Author added successfully.');
  }


void deleteAuthor(String id) {
  authors.removeWhere((author) => author.id == id);
  print('Author deleted successfully.');
}

  void viewAuthors() {
    if (authors.isEmpty) {
      print('No authors available.');
    } else {
      authors.forEach(print);
    }
  }

  void addMember(Member member) {
    if (members.any((m) => m.memberId == member.memberId)) {
      print('A member with this ID already exists.');
      return;
    }
    members.add(member);
    print('Member added successfully.');
  }

  void deleteMember(String memberId) {
    members.removeWhere((member) => member.memberId == memberId);
    print('Member deleted successfully.');
  }

  void viewMembers() {
    if (members.isEmpty) {
      print('No members available.');
    } else {
      members.forEach(print);
    }
  }


  Future<void> saveLibraryData() async {
    await dataPersistence.saveLibraryData(books, authors, members);
  }

  Future<void> loadLibraryData() async {
    var data = await dataPersistence.loadLibraryData();
    if (data.isNotEmpty) {
      books = (data['books'] as List).map((b) => Book.fromJson(b)).toList();
      authors =
          (data['authors'] as List).map((a) => Author.fromJson(a)).toList();
      members =
          (data['members'] as List).map((m) => Member.fromJson(m)).toList();
    }
  }

}