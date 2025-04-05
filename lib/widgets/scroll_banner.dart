import 'package:flutter/material.dart';

class ScrollBanner extends StatefulWidget {
  const ScrollBanner({super.key});

  @override
  State<ScrollBanner> createState() => _ScrollBannerState();
}

class _ScrollBannerState extends State<ScrollBanner>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // بداية التحريك
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final duration = const Duration(seconds: 15);

    if (maxScrollExtent > 0) {
      _scrollController
          .animateTo(
        maxScrollExtent,
        duration: duration,
        curve: Curves.linear,
      )
          .then((_) {
        _scrollController.jumpTo(0);
        _startScrolling(); // تكرار الحركة
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500), _startScrolling);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[200],
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        children: const [
          Center(
            child: Text(
              '🌟 مرحباً بك في إشراقة يومية! اقتباسات محفّزة ومتجددة يوميًا... ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
