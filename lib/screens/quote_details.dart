import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote_model.dart';

class QuoteDetailsPage extends StatefulWidget {
  final QuoteModel quote;

  const QuoteDetailsPage({super.key, required this.quote});

  @override
  State<QuoteDetailsPage> createState() => _QuoteDetailsPageState();
}

class _QuoteDetailsPageState extends State<QuoteDetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('favorites') ?? [];

    final exists = stored.any((item) {
      final decoded = jsonDecode(item);
      return decoded['quote'] == widget.quote.quote;
    });

    setState(() {
      isFavorite = exists;
    });
  }

  Future<void> _saveToFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('favorites') ?? [];

    stored.add(jsonEncode(widget.quote.toMap()));
    await prefs.setStringList('favorites', stored);

    setState(() => isFavorite = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ تم الحفظ في المفضلة')),
    );
  }

  Future<void> _removeFromFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList('favorites') ?? [];

    stored.removeWhere((item) {
      final decoded = jsonDecode(item);
      return decoded['quote'] == widget.quote.quote;
    });

    await prefs.setStringList('favorites', stored);

    setState(() => isFavorite = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🗑️ تم الحذف من المفضلة')),
    );
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(
        text: '"${widget.quote.quote}"\n- ${widget.quote.author}'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📋 تم نسخ الاقتباس')),
    );
  }

  void _shareQuote() {
    final text = '"${widget.quote.quote}"\n- ${widget.quote.author}';
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل الاقتباس'),
          backgroundColor: Colors.orange[400],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.format_quote, size: 60, color: Colors.orange),
              const SizedBox(height: 20),
              Text(
                '"${widget.quote.quote}"',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(height: 1.6),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.orange[200], thickness: 1, height: 20),
              Text(
                '- ${widget.quote.author}',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
              const Spacer(),

              // الأزرار
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: _copyToClipboard,
                    icon: const Icon(Icons.copy),
                    label: const Text('نسخ'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[50],
                      foregroundColor: Colors.black87,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _shareQuote,
                    icon: const Icon(Icons.share),
                    label: const Text('مشاركة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[100],
                      foregroundColor: Colors.black,
                    ),
                  ),
                  isFavorite
                      ? ElevatedButton.icon(
                          onPressed: _removeFromFavorites,
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('إزالة'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[100],
                            foregroundColor: Colors.black,
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: _saveToFavorites,
                          icon: const Icon(Icons.favorite_border),
                          label: const Text('حفظ'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[300],
                            foregroundColor: Colors.black,
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
