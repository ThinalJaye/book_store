import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './book_widget.dart';
import './drawer_widget.dart';
import './controllers/navigation_controller.dart';
import './screens/profile_page.dart';
import './screens/settings_page.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/favorites', page: () => const FavoritesPage()),
        GetPage(name: '/cart', page: () => const CartPage()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.put(NavigationController());

    final List<Widget> pages = [
      _HomePageContent(),
      const ProfilePage(),
      const SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Store'),
      ),
      drawer: const AppDrawer(),
      body: Obx(() => pages[navigationController.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navigationController.selectedIndex.value,
          onTap: navigationController.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  @override
  State<_HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<_HomePageContent> {
  String searchQuery = '';
  
  final List<Map<String, String>> books = const [
    {
      'title': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'price': '2,999',
      'imageUrl': 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-4.0.3',
    },
    {
      'title': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'price': '3,200',
      'imageUrl': 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3',
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'price': '3,000',
      'imageUrl': 'https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3',
    },
    {
      'title': 'Pride and Prejudice',
      'author': 'Jane Austen',
      'price': '2,500',
      'imageUrl': 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?ixlib=rb-4.0.3',
    },
    {
      'title': 'The Hobbit',
      'author': 'J.R.R. Tolkien',
      'price': '3,400',
      'imageUrl': 'https://images.unsplash.com/photo-1621351183012-e2f9972dd9bf?ixlib=rb-4.0.3',
    },
    {
      'title': 'Brave New World',
      'author': 'Aldous Huxley',
      'price': '3,000',
      'imageUrl': 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?ixlib=rb-4.0.3',
    },
  ];

  List<Map<String, String>> get filteredBooks {
    if (searchQuery.isEmpty) return books;
    return books.where((book) {
      return book['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
             book['author']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search books or authors...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredBooks.length,
            itemBuilder: (context, index) {
              final book = filteredBooks[index];
              return BookWidget(
                title: book['title']!,
                author: book['author']!,
                price: book['price']!,
                imageUrl: book['imageUrl']!,
              );
            },
          ),
        ),
      ],
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Favorites Page'),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Cart Page'),
      ),
    );
  }
}
