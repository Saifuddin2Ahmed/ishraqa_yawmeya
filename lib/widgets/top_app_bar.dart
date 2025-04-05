import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/logo.png', // تأكد من وجود صورة في مجلد assets
            width: 36,
            height: 36,
          ),
          Row(
            children: [
              IconButton(
                icon:
                    const Icon(Icons.notifications_none, color: Colors.orange),
                onPressed: () {
                  // مستقبلاً نضيف شاشة تنبيهات
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('لا توجد إشعارات حالياً')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.orange),
                onPressed: () {
                  // ممكن لاحقاً نضيف البحث
                  showSearch(
                    context: context,
                    delegate: QuoteSearchDelegate(),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class QuoteSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('نتيجة البحث: $query'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('ابحث عن اقتباس...'));
  }
}
