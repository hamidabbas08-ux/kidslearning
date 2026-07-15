import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  // مکمل ماسٹر ڈیٹا سیٹ
  final Map<String, List<LearningItem>> masterData = {
    'Alphabets': [
      LearningItem(name: 'A for Apple', emoji: '🍎'), LearningItem(name: 'B for Banana', emoji: '🍌'),
      LearningItem(name: 'C for Cat', emoji: '🐱'), LearningItem(name: 'D for Dog', emoji: '🐶'),
    ],
    'Fruits': [
      LearningItem(name: 'Apple', emoji: '🍎'), LearningItem(name: 'Banana', emoji: '🍌'),
      LearningItem(name: 'Mango', emoji: '🥭'), LearningItem(name: 'Grapes', emoji: '🍇'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kids Learning Academy')),
      body: GridView.count(
        crossAxisCount: 2,
        children: masterData.keys.map((catName) {
          return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (_) => MasterLearningScreen(categoryName: catName, items: masterData[catName]!),
            )),
            child: Card(child: Column(children: [Text(catName, style: const TextStyle(fontSize: 20))])),
          );
        }).toList(),
      ),
    );
  }
}

class MasterLearningScreen extends StatefulWidget {
  final String categoryName;
  final List<LearningItem> items;
  const MasterLearningScreen({Key? key, required this.categoryName, required this.items}) : super(key: key);
  @override
  State<MasterLearningScreen> createState() => _MasterLearningScreenState();
}

class _MasterLearningScreenState extends State<MasterLearningScreen> {
  int index = 0;
  FlutterTts tts = FlutterTts();

  void speak() => tts.speak(widget.items[index].name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: Column(
        children: [
          Expanded(child: Center(child: Text(widget.items[index].emoji, style: const TextStyle(fontSize: 100)))),
          Text(widget.items[index].name, style: const TextStyle(fontSize: 40)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(onPressed: () { if(index>0) setState(()=>index--); speak(); }, child: const Text('Back')),
            ElevatedButton(onPressed: () { if(index < widget.items.length-1) setState(()=>index++); speak(); }, child: const Text('Next')),
          ])
        ],
      ),
    );
  }
}
