import 'package:flutter/material.dart';
import '../utils/quote_data.dart';
import '../widgets/quote_card.dart';

class AllQuotesPage extends StatefulWidget {
  const AllQuotesPage({super.key});

  @override
  State<AllQuotesPage> createState() => _AllQuotesPageState();
}

class _AllQuotesPageState extends State<AllQuotesPage> {
  String selectedCategory = 'الكل';

  List<String> getCategories() {
    final categories = quotes.map((q) => q.category).toSet().toList();
    categories.sort();
    return ['الكل', ...categories];
  }

  @override
  Widget build(BuildContext context) {
    final filteredQuotes = selectedCategory == 'الكل'
        ? quotes
        : quotes.where((q) => q.category == selectedCategory).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('كل الاقتباسات'),
          backgroundColor: Colors.orange[400],
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () =>
                  Navigator.popUntil(context, ModalRoute.withName('/')),
              tooltip: 'العودة للرئيسية',
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Text(
                    'التصنيف:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedCategory,
                    items: getCategories()
                        .map((cat) =>
                            DropdownMenuItem(value: cat, child: Text(cat)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredQuotes.isEmpty
                  ? const Center(
                      child: Text('لا توجد اقتباسات في هذا التصنيف.'),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: filteredQuotes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 2,
                      ),
                      itemBuilder: (context, index) {
                        final quote = filteredQuotes[index];
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
          ],
        ),
      ),
    );
  }
}
