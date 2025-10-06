import 'package:flutter/material.dart';

class PageControlTask extends StatefulWidget {
  const PageControlTask({super.key});

  @override
  State<PageControlTask> createState() => _PageControlTaskState();
}

class _PageControlTaskState extends State<PageControlTask> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Krallığın Haberi",
      "subtitle": "Bugün büyük bir festival var!",
      "image": "https://picsum.photos/400/200?1",
    },
    {
      "title": "Teknoloji Mucizesi",
      "subtitle": "Prens Alexander yeni icat yaptı.",
      "image": "https://picsum.photos/400/200?2",
    },
    {
      "title": "Kraliyet Duyurusu",
      "subtitle": "Yeni yasalar yürürlüğe girdi.",
      "image": "https://picsum.photos/400/200?3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.withOpacity(0.4 + currentPage * 0.2),
              Colors.blue.withOpacity(0.6 - currentPage * 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 🔑 shrink-wrap
          children: [
            const Text(
              "📜 Royal Page Control",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Expanded yerine Flexible (loose) ya da SizedBox
            SizedBox(
              height: 220, // 🔑 sabit yükseklik verdik
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        page["title"]!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        page["subtitle"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          page["image"]!,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
