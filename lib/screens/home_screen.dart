// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:ilibrary_app/models/book.dart';
// import 'package:ilibrary_app/screens/auth_screen.dart';
// import 'package:ilibrary_app/widgets/book_card.dart';
// // 1. استيراد الويدجت المتحرك الجديد
// import 'package:ilibrary_app/widgets/animated_welcome_header.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   final String getBooksQuery = """
//     query GetBooks {
//       libaray_Book(limit: 10, order_by: { publicationDate: desc }) {
//         id
//         title
//         coverImage
//         Book_Author {
//           name
//         }
//       }
//     }
//   """;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('iLibrary الرئيسية'),
//         actions: [
//           IconButton(icon: const Icon(Icons.search), onPressed: () {}),
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               final prefs = await SharedPreferences.getInstance();
//               await prefs.remove('token');

//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (ctx) => const AuthScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Query(
//         options: QueryOptions(document: gql(getBooksQuery)),
//         builder:
//             (
//               QueryResult result, {
//               VoidCallback? refetch,
//               FetchMore? fetchMore,
//             }) {
//               if (result.hasException) {
//                 return Center(
//                   child: Text('حدث خطأ: ${result.exception.toString()}'),
//                 );
//               }

//               if (result.isLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               final List<dynamic> bookListJson =
//                   result.data?['libaray_Book'] ?? [];
//               final List<Book> books = bookListJson
//                   .map((json) => Book.fromJson(json))
//                   .where((book) => book != null)
//                   .cast<Book>()
//                   .toList();

//               if (books.isEmpty) {
//                 return const Center(child: Text('لا توجد كتب لعرضها حاليًا.'));
//               }

//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // 2. إضافة الويدجت المتحرك هنا في الأعلى
//                       const AnimatedWelcomeHeader(),
//                       const SizedBox(height: 24), // مسافة فاصلة

//                       _buildSectionTitle('وصل حديثًا', context),
//                       _buildHorizontalBookList(books),
//                       const SizedBox(height: 24),
//                       _buildSectionTitle('الأكثر قراءة', context),
//                       _buildHorizontalBookList(books.reversed.toList()),
//                     ],
//                   ),
//                 ),
//               );
//             },
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
//     );
//   }

//   Widget _buildHorizontalBookList(List<Book> books) {
//     return SizedBox(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: books.length,
//         itemBuilder: (context, index) {
//           return BookCard(book: books[index]);
//         },
//       ),
//     );
//   }
// }
