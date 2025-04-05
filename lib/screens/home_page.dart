import 'package:flutter/material.dart';
import '../utils/quote_data.dart';
import '../widgets/quote_card.dart';
import '../widgets/top_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List randomQuotes;

  @override
  void initState() {
    super.initState();
    randomQuotes =
        (quotes.toList()..shuffle()).take(6).toList(); // خذ 6 اقتباسات أو أكثر
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: TopAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.orange[100],
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: const Text(
              '🌟 إشراقة اليوم - اقتباسات حسب اهتماماتك',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 8),

          // ✅ GridView لعرض الاقتباسات
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.builder(
                itemCount: randomQuotes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد البطاقات في كل صف
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  final quote = randomQuotes[index];
                  return QuoteCard(
                    quote: quote,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/quoteDetails',
                        arguments: quote,
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // زر عرض المزيد
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/allQuotes');
              },
              icon: const Icon(Icons.format_quote),
              label: const Text('عرض المزيد من الاقتباسات'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
