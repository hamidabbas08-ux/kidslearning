import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class LearningItem {
  final String name;
  final String emoji;
  LearningItem({required this.name, required this.emoji});
}

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({Key? key}) : super(key: key);
  @override
  State<CategorySelectionScreen> createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final Map<String, List<LearningItem>> globalMasterData = {
    'Alphabets': [LearningItem(name: 'A for Apple', emoji: '🍎'), LearningItem(name: 'B for Banana', emoji: '🍌')],
    'Fruits': [LearningItem(name: 'Apple', emoji: '🍎'), LearningItem(name: 'Banana', emoji: '🍌')],
  };

  final List<Map<String, dynamic>> categories = [
    {'name': 'Alphabets', 'icon': '🔤', 'color': Colors.redAccent},
    {'name': 'Fruits', 'icon': '🍎', 'color': Colors.orangeAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFE0F7FA), Color(0xFFFFF3E0)])),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 20.0), child: Text('Kids Learning Academy', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple))),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return GestureDetector(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (_) => MasterLearningScreen(categoryName: cat['name'], items: globalMasterData[cat['name']] ?? [], themeColor: cat['color'])));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          // یہاں فکس کیا ہے: black10 کی جگہ 0.1 opacity استعمال کی ہے
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(cat['icon'], style: const TextStyle(fontSize: 55)), Text(cat['name'])]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MasterLearningScreen extends StatelessWidget {
  final String categoryName;
  final List<LearningItem> items;
  final Color themeColor;
  const MasterLearningScreen({Key? key, required this.categoryName, required this.items, required this.themeColor}) : super(key: key);
  @override
  Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text(categoryName)), body: Center(child: Text('Learning Mode Active'))); }
}
