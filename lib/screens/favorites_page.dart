import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<QuoteModel> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('favorites') ?? [];

    setState(() {
      favorites =
          stored.map((item) => QuoteModel.fromMap(jsonDecode(item))).toList();
    });
  }

  Future<void> _removeFavorite(QuoteModel quote) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stored = prefs.getStringList('favorites') ?? [];

    stored.removeWhere((item) {
      final decoded = jsonDecode(item);
      return decoded['quote'] == quote.quote;
    });

    await prefs.setStringList('favorites', stored);
    await _loadFavorites();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🗑️ تم إزالة الاقتباس من المفضلة')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المفضلة')),
        body: favorites.isEmpty
            ? const Center(
                child: Text(
                  'لا توجد اقتباسات محفوظة بعد.',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.separated(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                itemCount: favorites.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final quote = favorites[index];
                  return Card(
                    color: Colors.orange[50],
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      leading: const Icon(Icons.format_quote,
                          color: Colors.deepOrange),
                      title: Text(
                        quote.quote,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15),
                      ),
                      subtitle: Text(
                        '- ${quote.author}',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _removeFavorite(quote),
                        tooltip: 'حذف من المفضلة',
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
