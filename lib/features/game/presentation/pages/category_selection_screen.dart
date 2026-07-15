import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'import 'dart:math';

// ماسٹر پلان ڈیٹا ماڈل
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
  // دنیا بھر کا مکمل ڈیٹا سیٹ (ماسٹرا پلان کے عین مطابق)
  final Map<String, List<LearningItem>> globalMasterData = {
    'Alphabets': [
      LearningItem(name: 'A for Apple', emoji: '🍎'),
      LearningItem(name: 'B for Banana', emoji: '🍌'),
      LearningItem(name: 'C for Cat', emoji: '🐱'),
      LearningItem(name: 'D for Dog', emoji: '🐶'),
      LearningItem(name: 'E for Elephant', emoji: '🐘'),
      LearningItem(name: 'F for Fish', emoji: '🐟'),
      LearningItem(name: 'G for Grapes', emoji: '🍇'),
      LearningItem(name: 'H for Horse', emoji: '🐴'),
      LearningItem(name: 'I for Ice Cream', emoji: '🍦'),
      LearningItem(name: 'J for Joker', emoji: '🤡'),
      LearningItem(name: 'K for Kite', emoji: '🪁'),
      LearningItem(name: 'L for Lion', emoji: '🦁'),
      LearningItem(name: 'M for Monkey', emoji: '🐒'),
      LearningItem(name: 'N for Nest', emoji: '🪹'),
      LearningItem(name: 'O for Orange', emoji: '🍊'),
      LearningItem(name: 'P for Parrot', emoji: '🦜'),
      LearningItem(name: 'Q for Queen', emoji: '👸'),
      LearningItem(name: 'R for Rabbit', emoji: '🐇'),
      LearningItem(name: 'S for Sun', emoji: '☀️'),
      LearningItem(name: 'T for Train', emoji: '🚂'),
      LearningItem(name: 'U for Umbrella', emoji: '⛱️'),
      LearningItem(name: 'V for Violin', emoji: '🎻'),
      LearningItem(name: 'W for Watch', emoji: '⌚'),
      LearningItem(name: 'X for Xylophone', emoji: '🪘'),
      LearningItem(name: 'Y for Yacht', emoji: '⛵'),
      LearningItem(name: 'Z for Zebra', emoji: '🦓'),
    ],
    'Fruits': [
      LearningItem(name: 'Apple', emoji: '🍎'),
      LearningItem(name: 'Banana', emoji: '🍌'),
      LearningItem(name: 'Orange', emoji: '🍊'),
      LearningItem(name: 'Strawberry', emoji: '🍓'),
      LearningItem(name: 'Grapes', emoji: '🍇'),
      LearningItem(name: 'Watermelon', emoji: '🍉'),
      LearningItem(name: 'Mango', emoji: '🥭'),
      LearningItem(name: 'Pineapple', emoji: '🍍'),
      LearningItem(name: 'Cherry', emoji: '🍒'),
      LearningItem(name: 'Peach', emoji: '🍑'),
      LearningItem(name: 'Pear', emoji: '🍐'),
      LearningItem(name: 'Kiwi', emoji: '🥝'),
      LearningItem(name: 'Pomegranate', emoji: '🥭'),
      LearningItem(name: 'Coconut', emoji: '🥥'),
      LearningItem(name: 'Lemon', emoji: '🍋'),
    ],
    'Vegetables': [
      LearningItem(name: 'Tomato', emoji: '🍅'),
      LearningItem(name: 'Potato', emoji: '🥔'),
      LearningItem(name: 'Carrot', emoji: '🥕'),
      LearningItem(name: 'Broccoli', emoji: '🥦'),
      LearningItem(name: 'Corn', emoji: '🌽'),
      LearningItem(name: 'Onion', emoji: '🧅'),
      LearningItem(name: 'Cucumber', emoji: '🥒'),
      LearningItem(name: 'Eggplant', emoji: '🍆'),
      LearningItem(name: 'Pumpkin', emoji: '🎃'),
      LearningItem(name: 'Mushroom', emoji: '🍄'),
      LearningItem(name: 'Garlic', emoji: '🧄'),
      LearningItem(name: 'Peanuts', emoji: '🥜'),
    ],
    'Relations': [
      LearningItem(name: 'Father', emoji: '👨'),
      LearningItem(name: 'Mother', emoji: '👩'),
      LearningItem(name: 'Brother', emoji: '👦'),
      LearningItem(name: 'Sister', emoji: '👧'),
      LearningItem(name: 'Baby', emoji: '👶'),
      LearningItem(name: 'Grandfather', emoji: '👴'),
      LearningItem(name: 'Grandmother', emoji: '👵'),
    ],
    'Animals': [
      LearningItem(name: 'Lion', emoji: '🦁'),
      LearningItem(name: 'Tiger', emoji: '🐅'),
      LearningItem(name: 'Elephant', emoji: '🐘'),
      LearningItem(name: 'Monkey', emoji: '🐒'),
      LearningItem(name: 'Zebra', emoji: '🦓'),
      LearningItem(name: 'Giraffe', emoji: '🦒'),
      LearningItem(name: 'Panda', emoji: '🐼'),
      LearningItem(name: 'Rabbit', emoji: '🐇'),
      LearningItem(name: 'Bear', emoji: '🐻'),
      LearningItem(name: 'Fox', emoji: '🦊'),
    ],
  };

  final List<Map<String, dynamic>> categories = [
    {'name': 'Alphabets', 'icon': '🔤', 'color': Colors.redAccent},
    {'name': 'Fruits', 'icon': '🍎', 'color': Colors.orangeAccent},
    {'name': 'Vegetables', 'icon': '🥕', 'color': Colors.green},
    {'name': 'Relations', 'icon': '👪', 'color': Colors.pinkAccent},
    {'name': 'Animals', 'icon': '🦁', 'color': Colors.blueAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFFFF3E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Kids Learning Academy',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return GestureDetector(
                      onTap: () {
                        _showModeSelectionDialog(cat['name'], cat['color']);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: cat['color'].withOpacity(0.4), width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: cat['color'].withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(cat['icon'], style: const TextStyle(fontSize: 55)),
                            const SizedBox(height: 12),
                            Text(
                              cat['name'],
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                          ],
                        ),
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

  void _showModeSelectionDialog(String categoryName, Color themeColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Center(child: Text('Choose Mode for $categoryName', style: const TextStyle(fontWeight: FontWeight.bold))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MasterLearningScreen(
                      categoryName: categoryName,
                      items: globalMasterData[categoryName] ?? [],
                      themeColor: themeColor,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.menu_book, color: Colors.white),
              label: const Text('Learning Mode', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MasterQuizScreen(
                      categoryName: categoryName,
                      items: globalMasterData[categoryName] ?? [],
                      themeColor: themeColor,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.videogame_asset, color: Colors.white),
              label: const Text('Play Quiz Game', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// 📖 موڈ 1: مکمل لرننگ اسکرین (امیج + ٹیکسٹ سنک فکسڈ)
class MasterLearningScreen extends StatefulWidget {
  final String categoryName;
  final List<LearningItem> items;
  final Color themeColor;

  const MasterLearningScreen({
    Key? key,
    required this.categoryName,
    required this.items,
    required this.themeColor,
  }) : super(key: key);

  @override
  State<MasterLearningScreen> createState() => _MasterLearningScreenState();
}

class _MasterLearningScreenState extends State<MasterLearningScreen> {
  int currentIndex = 0;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.2);
    await flutterTts.setSpeechRate(0.38);
    _speak();
  }

  void _speak() async {
    if (widget.items.isNotEmpty) {
      await flutterTts.speak(widget.items[currentIndex].name);
    }
  }

  void _next() {
    if (currentIndex < widget.items.length - 1) {
      setState(() {
        currentIndex++;
      });
      _speak();
    } else {
      _showCompletionCheers();
    }
  }

  void _back() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
      _speak();
    }
  }

  void _showCompletionCheers() async {
    await flutterTts.speak("Wow! Fantastic! You completed the whole category! Cheers!");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Center(child: Text('🏆 Superb! 🏆', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold))),
        content: const Text('🎉 Hurrah! You unlocked all cards! 👏✨', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: widget.themeColor),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Awesome!', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = widget.items[currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: widget.themeColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentIndex + 1) / widget.items.length,
              backgroundColor: Colors.black12,
              color: widget.themeColor,
              minHeight: 8,
            ),
            const Spacer(),
            // تصویر اور لفظ بالکل ایک ساتھ سنک ہیں
            GestureDetector(
              onTap: _speak,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [BoxShadow(color: widget.themeColor.withOpacity(0.2), blurRadius: 20)],
                  border: Border.all(color: widget.themeColor, width: 3),
                ),
                child: Column(
                  children: [
                    Text(currentItem.emoji, style: const TextStyle(fontSize: 130)),
                    const SizedBox(height: 20),
                    Text(
                      currentItem.name,
                      style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: widget.themeColor),
                    ),
                    const SizedBox(height: 10),
                    const Icon(Icons.volume_up, size: 30, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: BorderSide(color: widget.themeColor)),
                  onPressed: currentIndex > 0 ? _back : null,
                  child: Text('Back', style: TextStyle(color: widget.themeColor, fontSize: 18)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: widget.themeColor),
                  onPressed: _next,
                  child: Text(currentIndex == widget.items.length - 1 ? 'Finish' : 'Next', style: const TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          ],
        ),
        padding: const EdgeInsets.all(24.0),
      ),
    );
  }
}

// 🎮 موڈ 2: انٹرایکٹو کوئز گیم (Cheers & "You can do it" موٹیویشن فکسڈ)
class MasterQuizScreen extends StatefulWidget {
  final String categoryName;
  final List<LearningItem> items;
  final Color themeColor;

  const MasterQuizScreen({
    Key? key,
    required this.categoryName,
    required this.items,
    required this.themeColor,
  }) : super(key: key);

  @override
  State<MasterQuizScreen> createState() => _MasterQuizScreenState();
}

class _MasterQuizScreenState extends State<MasterQuizScreen> {
  late LearningItem currentQuestionItem;
  List<String> options = [];
  final FlutterTts flutterTts = FlutterTts();
  String feedbackText = "";
  Color feedbackColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.2);
    _generateQuestion();
  }

  void _generateQuestion() {
    if (widget.items.isEmpty) return;
    final random = Random();
    
    setState(() {
      feedbackText = "";
      currentQuestionItem = widget.items[random.nextInt(widget.items.length)];
      
      // آپشنز تیار کرنا
      Set<String> uniqueOptions = {currentQuestionItem.emoji};
      while (uniqueOptions.length < 4 && uniqueOptions.length < widget.items.length) {
        uniqueOptions.add(widget.items[random.nextInt(widget.items.length)].emoji);
      }
      options = uniqueOptions.toList();
      options.shuffle();
    });

    flutterTts.speak("Where is ${currentQuestionItem.name}?");
  }

  void _checkAnswer(String selectedEmoji) async {
    if (selectedEmoji == currentQuestionItem.emoji) {
      // 🎉 تالیاں اور چیئرز کا پکا انتظام
      setState(() {
        feedbackText = "Excellent! 👏✨";
        feedbackColor = Colors.green;
      });
      await flutterTts.speak("Excellent! You are a genius!");
      Future.delayed(const Duration(milliseconds: 1500), _generateQuestion);
    } else {
      // 💪 حوصلہ افزائی کا پکا علاج
      setState(() {
        feedbackText = "You can do it! 💪";
        feedbackColor = Colors.orange;
      });
      await flutterTts.speak("Oops! You can do it! Try again!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName} Quiz Game', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('Listen carefully and tap the right image!', style: TextStyle(fontSize: 18, color: Colors.black54)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black10, blurRadius: 10)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.volume_up, size: 36, color: Colors.deepPurple),
                  const SizedBox(width: 12),
                  Text(currentQuestionItem.name, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // فیڈ بیک پینل
            Text(feedbackText, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: feedbackColor)),
            const Spacer(),
            // 4 تصاویر کے آپشنز کا گرڈ
            Expanded(
              flex: 3,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final opt = options[index];
                  return GestureDetector(
                    onTap: () => _checkAnswer(opt),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.deepPurple.withOpacity(0.2), width: 3),
                      ),
                      child: Center(child: Text(opt, style: const TextStyle(fontSize: 70))),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, minimumSize: const Size(150, 45)),
              onPressed: _generateQuestion,
              child: const Text('Skip', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
