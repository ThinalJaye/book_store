import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './book_widget.dart';
import './drawer_widget.dart';
import './controllers/navigation_controller.dart';
import './controllers/favorites_controller.dart';
import './controllers/cart_controller.dart';  // Add this import
import './screens/cart_page.dart';  // Add this import
import './screens/profile_page.dart';
import './screens/settings_page.dart';

void main() {
  Get.put(CartController()); // Add this line
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize FavoritesController
    Get.put(FavoritesController());
    
    return GetMaterialApp(
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto', // Adding default sans-serif font
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
          displayMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
          displaySmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
          headlineLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
          titleSmall: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontFamily: 'Roboto'),
          bodyMedium: TextStyle(fontFamily: 'Roboto'),
          bodySmall: TextStyle(fontFamily: 'Roboto'),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 227, 227, 238),
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/favorites', page: () => const FavoritesPage()),
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
      const CartPage(),
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
          selectedItemColor: Colors.blue[700], // Custom color for selected items
          unselectedItemColor: Colors.grey[600], // Custom color for unselected items
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books_rounded),
              activeIcon: Icon(Icons.auto_stories_rounded),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_mall_outlined),
              activeIcon: Icon(Icons.local_mall_rounded),
              label: 'Cart',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tune_outlined),
              activeIcon: Icon(Icons.tune_rounded),
              label: 'Settings',
              backgroundColor: Colors.white,
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
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Programming', 'Fiction', 'Business', 'Self-Help'];
  
  final List<Map<String, String>> books = const [
    {
      'title': 'Your Heart is the Sea',
      'author': 'Nikita Gill',
      'price': '2,999',
      'imageUrl': 'https://images.unsplash.com/photo-1544736779-08492534e887?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'description': 'The Great Gatsby explores the themes of wealth, love, and the American Dream. Set in the 1920s, it tells the story of Jay Gatsby\'s obsession with Daisy Buchanan, narrated by Nick Carraway, who becomes entangled in Gatsby\'s tragic quest for love and success.',
    },
    {
      'title': 'Advanced Android Application Development',
      'author': 'Joseph Annuzzi Jr., Lauren Darcey, Shane Conder',
      'price': '2,450',
      'imageUrl': 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3',
      'description': 'This book covers advanced Android app development techniques and tools. Ideal for developers looking to extend their skills, it offers in-depth explanations on building robust, high-performance apps.',
    },
    {
      'title': 'Your Soul is a River',
      'author': ' Nikita Gill',
      'price': '2,100',
      'imageUrl': 'https://images.unsplash.com/photo-1511108690759-009324a90311?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGJvb2slMjBjb3ZlcnxlbnwwfHwwfHx8MA%3D%3D',
      'description': 'Your Soul is a River is a collection of poetry and prose that delves into themes of healing, self-discovery, and emotional growth. Nikita Gill uses celestial and natural imagery to explore the depths of human experience, touching on love, loss, resilience, and hope. The book encourages readers to embrace their inner strength and find beauty in their journey of transformation.',

    },
    {
      'title': 'JavaScript for Web Designers',
      'author': 'Mat Marquis',
      'price': '3,999',
      'imageUrl': 'https://miro.medium.com/v2/resize:fit:1400/format:webp/0*uvOqEjfXrbXqaaQB',
      'description': '"JavaScript for Web Designers" by Mat Marquis simplifies JavaScript for designers, focusing on key concepts to enhance web user experiences.',
    },
    {
      'title': 'The Two Towers',
      'author': 'James L. Weaver',
      'price': '3,500',
      'imageUrl': 'https://images.unsplash.com/photo-1621351183012-e2f9972dd9bf?ixlib=rb-4.0.3',
      'description': 'The Two Towers is the second book in J.R.R. Tolkiens epic fantasy trilogy, The Lord of the Rings. It continues the journey of the Fellowship of the Ring as they face challenges in their quest to destroy the One Ring. The story is filled with adventure, battles, and the struggle between good and evil, with memorable characters and richly imagined settings.',
    },
    {
      'title': ' How Innovation Works',
      'author': 'Matt Ridley',
      'price': '3 708',
      'imageUrl': 'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?ixlib=rb-4.0.3',
      'description': 'How Innovation Works by Matt Ridley reveals how innovation thrives through collaboration and freedom, transforming ideas into impactful solutions through incremental progress and human exchange.',
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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: const InputDecoration(
                    hintText: 'Search books...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),

              // Categories
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: categories[index] == selectedCategory,
                        label: Text(categories[index]),
                        onSelected: (bool selected) {
                          setState(() => selectedCategory = categories[index]);
                        },
                      ),
                    );
                  },
                ),
              ),

              // Featured Section
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Featured Books',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Books Grid
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final book = filteredBooks[index];
                return BookWidget(
                  title: book['title']!,
                  author: book['author']!,
                  price: book['price']!,
                  imageUrl: book['imageUrl']!,
                  description: book['description']!,
                );
              },
              childCount: filteredBooks.length,
            ),
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
    final FavoritesController favoritesController = Get.find<FavoritesController>();
    final List<Map<String, String>> allBooks = _HomePageContentState().books;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      drawer: const AppDrawer(),
      body: Obx(() {
        final favoriteBooks = allBooks.where(
          (book) => favoritesController.favorites.contains(book['title'])
        ).toList();

        if (favoriteBooks.isEmpty) {
          return const Center(
            child: Text('No favorite books yet'),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: favoriteBooks.length,
          itemBuilder: (context, index) {
            final book = favoriteBooks[index];
            return BookWidget(
              title: book['title']!,
              author: book['author']!,
              price: book['price']!,
              imageUrl: book['imageUrl']!,
              description: book['description']!,
            );
          },
        );
      }),
    );
  }
}
