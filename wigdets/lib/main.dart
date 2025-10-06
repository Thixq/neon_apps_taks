import 'package:flutter/material.dart';
import 'package:wigdets/widgets/alert_task.dart';
import 'package:wigdets/widgets/button_demo.dart';
import 'package:wigdets/widgets/grid_demo.dart';
import 'package:wigdets/widgets/linner_demo.dart';
import 'package:wigdets/widgets/news_feed_demo.dart';
import 'package:wigdets/widgets/page_controller_task.dart';
import 'package:wigdets/widgets/pasanger.dart';
import 'package:wigdets/widgets/passenger_query.dart';
import 'package:wigdets/widgets/progcess.dart';
import 'package:wigdets/widgets/scroll_demo.dart';
import 'package:wigdets/widgets/segmented_control_task.dart';
import 'package:wigdets/widgets/slider_demo.dart';
import 'package:wigdets/widgets/stack_demo.dart';
import 'package:wigdets/widgets/stepper_task.dart';
import 'package:wigdets/widgets/switch_task.dart';
import 'package:wigdets/widgets/tabbar_demo.dart';
import 'package:wigdets/widgets/text_field_demo.dart';
import 'package:wigdets/widgets/user_profile.dart';
import 'widgets/widget_card.dart';
import 'widgets/container_demo.dart';

void main() {
  runApp(const WidgetShowcaseApp());
}

class WidgetShowcaseApp extends StatelessWidget {
  const WidgetShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Widget Showcase",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const WidgetShowcaseHome(),
    );
  }
}

class WidgetShowcaseHome extends StatelessWidget {
  const WidgetShowcaseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Widget Showcase")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          WidgetCard(
            title: "Container Demo",
            description:
                "Container, Flutter'ın en çok kullanılan widget'larından biridir. "
                "Boyut, hizalama ve stil özellikleri ile temel yapı taşıdır.",
            child: ContainerDemo(),
          ),
          WidgetCard(
            title: "Button Demo",
            description:
                "Saloon sahibinin görevi: özel tasarımlı bir buton. "
                "Arka plan resmi, gradient, border ve gölge ile süslenmiş. "
                "Tıklandığında günün spesiyallerini gösteriyor.",
            child: ButtonDemo(),
          ),
          WidgetCard(
            title: "TextField Demo",
            description:
                "Kraliçenin görevi: 3 farklı TextField. "
                "Ad-Soyad kırmızı bold, Email mavi italic (format kontrolü), "
                "Telefon yeşil underline (10 karakter sınırı).",
            child: TextFieldDemo(),
          ),
          WidgetCard(
            title: "Slider Demo - Dragon Slayer",
            description:
                "Ejderhayı yenmek için sihirli slider: "
                "Min'de yeşil ejderha, Max'de kırmızı ejderha. "
                "Track gradient (yeşilden kırmızıya), Thumb mavi. "
                "Değerler 1'er artıyor.",
            child: SliderDemo(),
          ),
          WidgetCard(
            title: 'Switch Demo',
            description:
                'Masalsı bir diyarda devler (Switch widget’ı inşa edenler) ve cüceler (işlevlerini programlayanlar) birlikte sihirli bir “on-off” anahtar yaparlar. Bu anahtar açıldığında ekran yeşil olur, Switch kırmızı görünür; kapatıldığında ekran kırmızı, Switch yeşil görünür. Ayrıca Switch’in thumb kısmı siyah yapılır ki her zaman öne çıksın.',
            child: SwitchTask(),
          ),
          WidgetCard(
            title: 'Stepper Demo',
            description: '',
            child: StepperTask(),
          ),
          WidgetCard(
            title: 'Page Controller Demo',
            description: '',
            child: PageControlTask(),
          ),
          WidgetCard(
            title: 'Segment Controller Demo',
            description: '',
            child: SegmentedControlTask(),
          ),
          WidgetCard(title: 'Alert Demo', description: '', child: AlertTask()),
          WidgetCard(
            title: "Indicator & Counter",
            description:
                "Bir butona tıklandığında ekranda indicator belirecek, 0'dan 100'e kadar sayacak ve her 10'da bir rengi değişecek.",
            child: Task10Widget(),
          ),
          WidgetCard(
            title: "Progress View",
            description:
                "Aladdin’in Flutter öğrenme yolculuğunu gösteren progress indicator. "
                "0’dan 10’a kadar ilerler, 10’a gelince tekrar sıfırlanır.",
            child: Task11Widget(),
          ),
          WidgetCard(
            title: "Stack View (Harry Potter)",
            description:
                "Harry’nin Voldemort’u yenmek için kullandığı 4 büyüyü gösteren stack view. "
                "Ekran döndürüldüğünde bozulmadan uyum sağlar.",
            child: Task12Widget(),
          ),
          WidgetCard(
            title: "ScrollView (Iron Man)",
            description:
                "Tony Stark’ın 2 ekran yüksekliğinde, 8 label’dan oluşan ScrollView aracı. "
                "İlk 4 label ekranda görünür, diğer 4’ü scroll ile açılır. "
                "Sonuna gelindiğinde alert çıkar.",
            child: Task13Widget(),
          ),
          WidgetCard(
            title: "Custom TabBar (Hulk)",
            description:
                "Hulk’un bombayı durdurmak için yaptığı özel TabBar. "
                "4 item, her biri farklı ikon ve title. "
                "Seçili/Seçili değil renk farkı, köşe radius, renk ve opacity özelleştirmeleri.",
            child: Task14Widget(),
          ),
          WidgetCard(
            title: 'Picker',
            description:
                'Arka plan rengi, yaş ve fotografı değiştrimek için sola kaydır.',
            child: UserProfileTask(),
          ),
          WidgetCard(
            title: 'Data Table',
            description: '',
            child: DataTableTask(),
          ),
          WidgetCard(
            title: 'Data Table Search',
            description: '',
            child: DataTableSearchTask(),
          ),
          WidgetCard(
            title: 'Grid Demo',
            description: '',
            child: SizedBox(
              // Grid View'in görüntüleneceği yüksekliği burada belirliyoruz.
              // Örneğin 400.0 piksel yapalım.
              height: 400.0,
              child: MarinaAppGridInListView(),
            ),
          ),
          WidgetCard(
            title: 'Feed News',
            description:
                'ListView.builder ile oluşturulmuş, yüksekliği sınırlandırılmış haber akışı.',
            child: SizedBox(
              // NewsFeedListView'un yüksekliğini Grid ile benzer, örneğin 450 piksel yapalım.
              height: 450.0,
              child: NewsFeedListView(),
            ),
          ),
        ],
      ),
    );
  }
}
