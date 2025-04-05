import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoriesPage({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final categories = {
      'الكل': Icons.all_inclusive,
      'الذكاء الاصطناعي': Icons.memory,
      'الإعلام': Icons.mic,
      'التحفيز': Icons.bolt,
      'التكنولوجيا': Icons.devices,
    };

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اختر تصنيف الاقتباسات'),
          backgroundColor: Colors.orange[400],
        ),
        body: ListView.separated(
          itemCount: categories.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final title = categories.keys.elementAt(index);
            final icon = categories.values.elementAt(index);

            return ListTile(
              leading: Icon(icon, color: Colors.orange[700]),
              title: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                onCategorySelected(title);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
