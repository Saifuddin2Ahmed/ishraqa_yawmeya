import 'package:flutter/material.dart';
import 'models/quote_model.dart';
import 'screens/home_page.dart';
import 'screens/favorites_page.dart';
import 'screens/about_page.dart';
import 'screens/categories_page.dart';
import 'screens/all_quotes_page.dart';
import 'screens/quote_details.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إشراقة يومية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IshraqaApp(),
        '/quoteDetails': (context) {
          final quote =
              ModalRoute.of(context)!.settings.arguments as QuoteModel;
          return QuoteDetailsPage(quote: quote);
        },
        '/allQuotes': (context) => const AllQuotesPage(),
      },
    );
  }
}

class IshraqaApp extends StatefulWidget {
  const IshraqaApp({super.key});

  @override
  State<IshraqaApp> createState() => _IshraqaAppState();
}

class _IshraqaAppState extends State<IshraqaApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    FavoritesPage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoriesPage(
            onCategorySelected: (category) {
              // لا شيء حالياً لأننا ما بنستخدم التصنيفات الآن
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'عن التطبيق'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'المواضيع'),
        ],
      ),
    );
  }
}
