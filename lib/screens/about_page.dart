import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _showError('تعذّر فتح الرابط');
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (!await launchUrl(emailLaunchUri)) {
      _showError('تعذّر فتح تطبيق البريد');
    }
  }

  void _showError(String message) {
    // يمكن تعديل هذا لاحقًا لعرض SnackBar أو Dialog
    debugPrint(message);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('عن التطبيق'),
          backgroundColor: Colors.orange[400],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Icon(Icons.lightbulb_outline,
                  size: 80, color: Colors.orange),
              const SizedBox(height: 16),
              const Text(
                'تطبيق إشراقة يومية هو منصة بسيطة لعرض اقتباسات محفزة ومفيدة في مجالات مختلفة مثل التكنولوجيا، الإعلام، والذكاء الاصطناعي.\n\nنطمح إلى إلهام المستخدمين وإثراء تجربتهم اليومية بكلمات مؤثرة.',
                style: TextStyle(fontSize: 16, height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Divider(),
              const Text(
                'تواصل معنا',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                    iconSize: 30,
                    tooltip: 'Facebook',
                    onPressed: () =>
                        _launchUrl('https://www.facebook.com/taeziz21'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.business, color: Colors.blueAccent),
                    iconSize: 30,
                    tooltip: 'LinkedIn',
                    onPressed: () =>
                        _launchUrl('https://www.linkedin.com/company/taeziz21'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.music_note, color: Colors.black),
                    iconSize: 30,
                    tooltip: 'TikTok',
                    onPressed: () => _launchUrl('http://tiktok.com/@taeziz21'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.email, color: Colors.red),
                    iconSize: 30,
                    tooltip: 'Email',
                    onPressed: () => _sendEmail('contact@taeziz21.com'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'الإصدار 1.0.0',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
