
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PetNutritionApp());
}

class PetNutritionApp extends StatefulWidget {
  const PetNutritionApp({super.key});
  @override
  State<PetNutritionApp> createState() => _PetNutritionAppState();
}

class _PetNutritionAppState extends State<PetNutritionApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    final baseText = GoogleFonts.inter();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Nutrition',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF29A36A),
        brightness: Brightness.light,
        textTheme: TextTheme(bodyMedium: baseText),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF29A36A),
        brightness: Brightness.dark,
        textTheme: TextTheme(bodyMedium: baseText.copyWith(color: Colors.white)),
      ),
      locale: _locale,
      home: HomeScreen(
        onThemeChanged: (m) => setState(() => _themeMode = m),
        onLocaleChanged: (l) => setState(() => _locale = l),
        locale: _locale,
      ),
    );
  }
}

class I18n {
  final Locale locale;
  I18n(this.locale);
  static Map<String, Map<String, String>> t = {
    "en": {"app_title":"Pet Nutrition","pets":"Pets","nutrition":"Nutrition","settings":"Settings","add_pet":"Add Pet","edit_pet":"Edit Pet","delete":"Delete","save":"Save","name":"Name","type":"Type","dog":"Dog","cat":"Cat","rabbit":"Rabbit","breed":"Breed","age":"Age Group","puppy":"Puppy","adult":"Adult","senior":"Senior","weight":"Weight (kg)","notes":"Notes","no_pets":"No pets yet. Tap + to add.","load_demo":"Load Demo Pets","language":"Language","theme":"Theme","light":"Light","dark":"Dark","system":"System"},
    "hi": {"app_title":"पेट न्यूट्रिशन","pets":"पालतू","nutrition":"डाइट","settings":"सेटिंग्स","add_pet":"पालतू जोड़ें","edit_pet":"पालतू संपादित","delete":"हटाएं","save":"सेव","name":"नाम","type":"प्रकार","dog":"कुत्ता","cat":"बिल्ली","rabbit":"खरगोश","breed":"नस्ल","age":"उम्र समूह","puppy":"पप्पी","adult":"एडल्ट","senior":"सीनियर","weight":"वज़न (किलो)","notes":"नोट्स","no_pets":"अभी कोई पालतू नहीं। जोड़ने के लिए + दबाएं।","load_demo":"डेमो पालतू लोड करें","language":"भाषा","theme":"थीम","light":"लाइट","dark":"डार्क","system":"सिस्टम"},
    "mr": {"app_title":"पेट न्यूट्रिशन","pets":"पाळीव प्राणी","nutrition":"आहार","settings":"सेटिंग्स","add_pet":"प्राणी जोडा","edit_pet":"प्राणी संपादित करा","delete":"काढून टाका","save":"सेव्ह","name":"नाव","type":"प्रकार","dog":"कुत्रा","cat":"मांजर","rabbit":"ससा","breed":"वंश","age":"वय गट","puppy":"पिल्लू","adult":"प्रौढ","senior":"ज्येष्ठ","weight":"वजन (कि.ग्रॅ.)","notes":"नोट्स","no_pets":"अजून पाळीव नाहीत. जोडण्यासाठी + दाबा.","load_demo":"डेमो पाळीव लोड करा","language":"भाषा","theme":"थीम","light":"लाइट","dark":"डार्क","system":"सिस्टम"},
    "kn": {"app_title":"ಪೆಟ್ ನ್ಯೂಟ್ರಿಷನ್","pets":"ಪೆಟ್ಸ್","nutrition":"ಆಹಾರ","settings":"ಸೆಟ್ಟಿಂಗ್ಗಳು","add_pet":"ಪೆಟ್ ಸೇರಿಸಿ","edit_pet":"ಪೆಟ್ ಎಡಿಟ್","delete":"ಅಳಿಸಿ","save":"ಸೇವ್","name":"ಹೆಸರು","type":"ಪ್ರಕಾರ","dog":"ನಾಯಿ","cat":"ಬೆಕ್ಕು","rabbit":"ಮೊಲ","breed":"ಜಾತಿ","age":"ವಯೋವರ್ಗ","puppy":"ಕುಣಿಯ","adult":"ಪ್ರೌಢ","senior":"ಹಿರಿಯ","weight":"ತೂಕ (ಕೆ.ಜಿ)","notes":"ಸೂಚನೆಗಳು","no_pets":"ಇನ್ನೂ ಪೆಟ್ಸ್ ಇಲ್ಲ. ಸೇರಿಸಲು + ಒತ್ತಿ.","load_demo":"ಡೆಮೋ ಪೆಟ್ಸ್ ಲೋಡ್ ಮಾಡಿ","language":"ಭಾಷೆ","theme":"ಥೀಮ್","light":"ಲೈಟ್","dark":"ಡಾರ್ಕ್","system":"ಸಿಸ್ಟಮ್"},
    "ta": {"app_title":"பெட் நியூட்ரிஷன்","pets":"செல்லப்பிராணிகள்","nutrition":"ஆஹாரம்","settings":"அமைப்புகள்","add_pet":"செல்லம் சேர்க்க","edit_pet":"செல்லம் திருத்த","delete":"நீக்கு","save":"சேமிக்க","name":"பெயர்","type":"வகை","dog":"நாய்","cat":"பூனை","rabbit":"முயல்","breed":"இனம்","age":"வயது குழு","puppy":"குட்டி","adult":"வயோதிகம்","senior":"மூத்தவர்","weight":"எடை (கிலோ)","notes":"குறிப்புகள்","no_pets":"இன்னும் செல்லங்கள் இல்லை. சேர்க்க + தட்டவும்.","load_demo":"டெமோ செல்லங்கள் ஏற்று","language":"மொழி","theme":"தீம்","light":"லைட்","dark":"டார்க்","system":"சிஸ்டம்"},
  };
  String tr(String key) {
    final code = t.containsKey(locale.languageCode) ? locale.languageCode : "en";
    return t[code]?[key] ?? t["en"]![key] ?? key;
  }
}

class HomeScreen extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;
  final void Function(Locale) onLocaleChanged;
  final Locale locale;
  const HomeScreen({super.key, required this.onThemeChanged, required this.onLocaleChanged, required this.locale});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    final i = I18n(widget.locale);
    final screens = [
      PetsScreen(i18n: i),
      NutritionScreen(i18n: i),
      SettingsScreen(i18n: i, onThemeChanged: widget.onThemeChanged, onLocaleChanged: widget.onLocaleChanged, locale: widget.locale),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const CircleAvatar(backgroundImage: AssetImage('assets/images/icon.png'), radius: 14),
          const SizedBox(width: 8),
          Text(i.tr("app_title")),
        ]),
      ),
      body: screens[idx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (v)=> setState(()=> idx=v),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.pets_outlined), selectedIcon: const Icon(Icons.pets), label: i.tr("pets")),
          NavigationDestination(icon: const Icon(Icons.restaurant_outlined), selectedIcon: const Icon(Icons.restaurant), label: i.tr("nutrition")),
          NavigationDestination(icon: const Icon(Icons.settings_outlined), selectedIcon: const Icon(Icons.settings), label: i.tr("settings")),
        ],
      ),
    );
  }
}

class Pet {
  String id;
  String name;
  String type;
  String breed;
  String age;
  double weight;
  String notes;
  Pet({required this.id, required this.name, required this.type, required this.breed, required this.age, required this.weight, required this.notes});
  Map<String, dynamic> toJson() => {"id":id,"name":name,"type":type,"breed":breed,"age":age,"weight":weight,"notes":notes};
  static Pet fromJson(Map<String, dynamic> j) => Pet(id:j["id"], name:j["name"], type:j["type"], breed:j["breed"], age:j["age"], weight:(j["weight"] as num).toDouble(), notes:j["notes"] ?? "");
}

class PetsStore {
  static const key = "pets_store_v1";
  static Future<List<Pet>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(key);
    if (s == null) return [];
    final list = (jsonDecode(s) as List).map((e)=> Pet.fromJson(e)).toList();
    return list;
  }
  static Future<void> save(List<Pet> pets) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(pets.map((e)=>e.toJson()).toList()));
  }
  static Future<void> loadDemoIfEmpty(BuildContext context) async {
    final pets = await load();
    if (pets.isEmpty) {
      final demoJson = await DefaultAssetBundle.of(context).loadString("assets/demo_pets.json");
      final list = (jsonDecode(demoJson) as List).map((e)=> Pet.fromJson(e)).toList();
      await save(list);
    }
  }
}

class PetsScreen extends StatefulWidget {
  final I18n i18n;
  const PetsScreen({super.key, required this.i18n});
  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  List<Pet> pets = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await PetsStore.loadDemoIfEmpty(context);
    pets = await PetsStore.load();
    setState(() => loading = false);
  }

  Future<void> _addOrEdit([Pet? existing]) async {
    final result = await showDialog<Pet>(context: context, builder: (_)=> PetDialog(i18n: widget.i18n, pet: existing));
    if (result != null) {
      if (existing == null) {
        pets.add(result);
      } else {
        final idx = pets.indexWhere((p)=> p.id == existing.id);
        if (idx != -1) pets[idx] = result;
      }
      await PetsStore.save(pets);
      setState((){});
    }
  }

  Future<void> _delete(Pet p) async {
    pets.removeWhere((e)=> e.id == p.id);
    await PetsStore.save(pets);
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    final i = widget.i18n;
    if (loading) return const Center(child: CircularProgressIndicator());
    return Stack(
      children: [
        if (pets.isEmpty)
          Center(child: Text(i.tr("no_pets")))
        else
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pets.length,
            itemBuilder: (_, idx){
              final p = pets[idx];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: CircleAvatar(child: Text(p.name.isNotEmpty ? p.name[0] : '?')),
                  title: Text("${p.name} • ${p.type} (${p.breed})"),
                  subtitle: Text("${p.age} • ${p.weight.toStringAsFixed(1)} kg\n${p.notes}"),
                  isThreeLine: true,
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(icon: const Icon(Icons.edit), onPressed: ()=> _addOrEdit(p)),
                    IconButton(icon: const Icon(Icons.delete), onPressed: ()=> _delete(p)),
                  ]),
                ),
              );
            },
          ),
        Positioned(
          bottom: 24, right: 24,
          child: FloatingActionButton.extended(onPressed: ()=> _addOrEdit(), icon: const Icon(Icons.add), label: Text(i.tr("add_pet"))),
        ),
      ],
    );
  }
}

class PetDialog extends StatefulWidget {
  final I18n i18n;
  final Pet? pet;
  const PetDialog({super.key, required this.i18n, this.pet});
  @override
  State<PetDialog> createState() => _PetDialogState();
}

class _PetDialogState extends State<PetDialog> {
  late TextEditingController name;
  late TextEditingController breed;
  late TextEditingController weight;
  late TextEditingController notes;
  String type = "Dog";
  String age = "Adult";

  @override
  void initState() {
    super.initState();
    final p = widget.pet;
    name = TextEditingController(text: p?.name ?? "");
    breed = TextEditingController(text: p?.breed ?? "");
    weight = TextEditingController(text: p?.weight.toString() ?? "5.0");
    notes = TextEditingController(text: p?.notes ?? "");
    type = p?.type ?? "Dog";
    age = p?.age ?? "Adult";
  }

  @override
  Widget build(BuildContext context) {
    final i = widget.i18n;
    return AlertDialog(
      title: Text(widget.pet == null ? i.tr("add_pet") : i.tr("edit_pet")),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: name, decoration: InputDecoration(labelText: i.tr("name"))),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(value: type, items: ["Dog","Cat","Rabbit"].map((e)=>DropdownMenuItem(value:e, child: Text(i.tr(e.toLowerCase())))).toList(), onChanged: (v)=> setState(()=> type = v!), decoration: InputDecoration(labelText: i.tr("type"))),
          const SizedBox(height: 8),
          TextField(controller: breed, decoration: InputDecoration(labelText: i.tr("breed"))),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(value: age, items: ["Puppy","Adult","Senior"].map((e)=>DropdownMenuItem(value:e, child: Text(i.tr(e.toLowerCase())))).toList(), onChanged: (v)=> setState(()=> age = v!), decoration: InputDecoration(labelText: i.tr("age"))),
          const SizedBox(height: 8),
          TextField(controller: weight, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: i.tr("weight"))),
          const SizedBox(height: 8),
          TextField(controller: notes, decoration: InputDecoration(labelText: i.tr("notes"))),
        ]),
      ),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context), child: const Text("Cancel")),
        FilledButton(onPressed: (){
          final w = double.tryParse(weight.text) ?? 0.0;
          final p = Pet(id: widget.pet?.id ?? DateTime.now().millisecondsSinceEpoch.toString(), name: name.text.trim(), type: type, breed: breed.text.trim(), age: age, weight: w, notes: notes.text.trim());
          Navigator.pop(context, p);
        }, child: Text(i.tr("save"))),
      ],
    );
  }
}

class NutritionScreen extends StatelessWidget {
  final I18n i18n;
  const NutritionScreen({super.key, required this.i18n});

  String guideFor(String type, String age, double weight) {
    if (type=="Dog") {
      if (age=="Puppy") return "3–4 meals/day • Puppy formula • ~10% body weight in food (wet) adjusted by vet.";
      if (age=="Senior") return "2 small meals/day • Softer food • Joint support.";
      return "2 meals/day • Balanced adult kibble • Fresh water at all times.";
    } else if (type=="Cat") {
      if (age=="Puppy") return "Kittens: 3–4 meals/day • Kitten formula • Frequent hydration.";
      if (age=="Senior") return "2–3 small meals/day • Easy-to-digest wet food.";
      return "2 meals/day • High-protein wet/dry mix • Plenty of water.";
    } else {
      return "Unlimited hay • Leafy greens daily • Small pellets • Avoid grains & sugary treats.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final chips = ["Dog","Cat","Rabbit"];
    final ages = ["Puppy","Adult","Senior"];
    String type = "Dog";
    String age = "Adult";
    double weight = 10.0;
    return StatefulBuilder(builder: (context, setState){
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 8, children: chips.map((c)=> ChoiceChip(label: Text(i18n.tr(c.toLowerCase())), selected: type==c, onSelected: (_)=> setState(()=> type=c))).toList()),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: ages.map((a)=> ChoiceChip(label: Text(i18n.tr(a.toLowerCase())), selected: age==a, onSelected: (_)=> setState(()=> age=a))).toList()),
          const SizedBox(height: 12),
          Text(i18n.tr("weight")),
          Slider(min:0.5, max:60, divisions:119, value: weight, label: "${weight.toStringAsFixed(1)} kg", onChanged:(v)=> setState(()=> weight=v)),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(guideFor(type, age, weight)),
            ),
          ),
        ]),
      );
    });
  }
}

class SettingsScreen extends StatelessWidget {
  final I18n i18n;
  final void Function(ThemeMode) onThemeChanged;
  final void Function(Locale) onLocaleChanged;
  final Locale locale;
  const SettingsScreen({super.key, required this.i18n, required this.onThemeChanged, required this.onLocaleChanged, required this.locale});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      Card(child: ListTile(
        leading: const Icon(Icons.language),
        title: Text(i18n.tr("language")),
        trailing: DropdownButton<Locale>(
          value: locale,
          items: const [
            DropdownMenuItem(value: Locale('en'), child: Text("English")),
            DropdownMenuItem(value: Locale('hi'), child: Text("हिंदी")),
            DropdownMenuItem(value: Locale('mr'), child: Text("मराठी")),
            DropdownMenuItem(value: Locale('kn'), child: Text("ಕನ್ನಡ")),
            DropdownMenuItem(value: Locale('ta'), child: Text("தமிழ்")),
          ],
          onChanged: (v){ if(v!=null) onLocaleChanged(v); },
        ),
      )),
      const SizedBox(height: 12),
      Card(child: ListTile(
        leading: const Icon(Icons.color_lens_outlined),
        title: Text(i18n.tr("theme")),
        trailing: DropdownButton<ThemeMode>(
          value: ThemeMode.system,
          items: [
            DropdownMenuItem(value: ThemeMode.light, child: Text(i18n.tr("light"))),
            DropdownMenuItem(value: ThemeMode.dark, child: Text(i18n.tr("dark"))),
            DropdownMenuItem(value: ThemeMode.system, child: Text(i18n.tr("system"))),
          ],
          onChanged: (v){ if(v!=null) onThemeChanged(v); },
        ),
      )),
      const SizedBox(height: 20),
      Card(child: ListTile(
        leading: const Icon(Icons.cloud_download_outlined),
        title: Text(i18n.tr("load_demo")),
        onTap: () async {
          await PetsStore.save([]);
          await PetsStore.loadDemoIfEmpty(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Demo loaded!")));
        },
      )),
    ]);
  }
}
