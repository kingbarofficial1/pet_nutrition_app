
// Main file created by assistant. See README for details.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});
  @override State<App> createState()=>_AppState();
}

class _AppState extends State<App>{
  ThemeMode _mode = ThemeMode.system;
  Locale _locale = const Locale('en');
  @override Widget build(BuildContext context){
    return MaterialApp(
      title: 'Pet Nutrition',
      theme: ThemeData(useMaterial3:true,colorSchemeSeed: const Color(0xFF2E7D32),brightness: Brightness.light,scaffoldBackgroundColor: const Color(0xFFF7FAF8)),
      darkTheme: ThemeData(useMaterial3:true,colorSchemeSeed: const Color(0xFF2E7D32),brightness: Brightness.dark),
      themeMode: _mode,
      locale: _locale,
      home: Home(onTheme:(m)=>setState(()=>_mode=m), onLang:(l)=>setState(()=>_locale=l), locale:_locale),
      debugShowCheckedModeBanner:false,
    );
  }
}

class I18n{
  final Locale locale; I18n(this.locale);
  static const s={
    "en":{"nutrition":"Nutrition","reminders":"Water","tips":"Tips","settings":"Settings","pet_type":"Pet Type","dog":"Dog","cat":"Cat","breed":"Breed","age":"Age Group","weight":"Weight (kg)","show":"Show Guide","language":"Language","theme":"Theme"},
    "hi":{"nutrition":"डाइट","reminders":"पानी","tips":"टिप्स","settings":"सेटिंग्स","pet_type":"पशु प्रकार","dog":"कुत्ता","cat":"बिल्ली","breed":"नस्ल","age":"उम्र समूह","weight":"वज़न (किलो)","show":"गाइड देखें","language":"भाषा","theme":"थीम"}
  };
  String t(String k)=> s[locale.languageCode]?[k]??s['en']![k]??k;
}

class Home extends StatefulWidget{
  final void Function(ThemeMode) onTheme; final void Function(Locale) onLang; final Locale locale;
  const Home({super.key, required this.onTheme, required this.onLang, required this.locale});
  @override State<Home> createState()=>_HomeState();
}
class _HomeState extends State<Home>{
  int idx=0;
  @override Widget build(BuildContext context){
    final i = I18n(widget.locale);
    final screens=[Nutrition(i18n:i), Reminders(i18n:i), Tips(i18n:i), Settings(i18n:i,onTheme:widget.onTheme,onLang:widget.onLang)];
    return Scaffold(
      appBar: AppBar(title: Row(children: const [CircleAvatar(radius:14,backgroundImage: AssetImage('assets/images/logo.png')), SizedBox(width:8), Text('Pet Nutrition')])),
      body: screens[idx],
      bottomNavigationBar: NavigationBar(
        destinations:[
          NavigationDestination(icon: Icon(Icons.restaurant_outlined), selectedIcon: Icon(Icons.restaurant), label: i.t('nutrition')),
          NavigationDestination(icon: Icon(Icons.opacity_outlined), selectedIcon: Icon(Icons.opacity), label: i.t('reminders')),
          NavigationDestination(icon: Icon(Icons.lightbulb_outline), selectedIcon: Icon(Icons.lightbulb), label: i.t('tips')),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: i.t('settings')),
        ],
        selectedIndex: idx, onDestinationSelected:(v)=>setState(()=>idx=v),
      ),
    );
  }
}

class Nutrition extends StatefulWidget{ final I18n i18n; const Nutrition({super.key, required this.i18n}); @override State<Nutrition> createState()=>_NState();}
class _NState extends State<Nutrition>{
  String petType="Dog"; String breed="Mixed"; String age="Adult"; double weight=10;
  final breeds={"Dog":["Mixed","Labrador","German Shepherd","Pomeranian","Beagle","Golden Retriever"],"Cat":["Mixed","Persian","Siamese","Maine Coon","Bengal","Indian Cat"]};
  final ages={"Dog":["Puppy","Adult","Senior"],"Cat":["Kitten","Adult","Senior"]};
  String dietFor(){ if(petType=="Dog"){ if(age=="Puppy") return "3–4 meals/day • Puppy food"; if(age=="Senior") return "2 small meals/day • Softer food"; return "2 meals/day • Adult kibble"; } else { if(age=="Kitten") return "3–4 meals/day • Kitten food"; if(age=="Senior") return "2 small meals/day • Soft canned"; return "2 meals/day • Adult kibble"; } }
  @override Widget build(BuildContext context){
    final i = widget.i18n;
    return SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children:[
      _card(Column(children:[
        DropdownButtonFormField(value: petType, items:["Dog","Cat"].map((e)=>DropdownMenuItem(value:e, child: Text(e=="Dog"? i.t('dog'): i.t('cat')))).toList(), onChanged:(v){ setState(()=>petType=v!); breed="Mixed"; age="Adult";}, decoration: InputDecoration(labelText: i.t('pet_type'), border: OutlineInputBorder())),
        const SizedBox(height:12),
        DropdownButtonFormField(value: breed, items:breeds[petType]!.map((e)=>DropdownMenuItem(value:e, child: Text(e))).toList(), onChanged:(v)=>setState(()=>breed=v!), decoration: InputDecoration(labelText: i.t('breed'), border: OutlineInputBorder())),
        const SizedBox(height:12),
        DropdownButtonFormField(value: age, items:ages[petType]!.map((e)=>DropdownMenuItem(value:e, child: Text(e))).toList(), onChanged:(v)=>setState(()=>age=v!), decoration: InputDecoration(labelText: i.t('age'), border: OutlineInputBorder())),
        const SizedBox(height:12),
        Align(alignment: Alignment.centerLeft, child: Text(i.t('weight'))),
        Slider(min:0.5, max:60, divisions:119, value: weight, label: "${weight.toStringAsFixed(1)} kg", onChanged:(v)=>setState(()=>weight=v)),
        Text("${weight.toStringAsFixed(1)} kg"),
        const SizedBox(height:12),
        FilledButton.icon(onPressed:(){
          showModalBottomSheet(context: context, showDragHandle: true, builder: (_){ return Padding(padding: const EdgeInsets.all(16), child: Text(dietFor())); });
        }, icon: const Icon(Icons.fastfood), label: Text(i.t('show'))),
      ])),
    ]));
  }
  Widget _card(Widget child)=>Card(elevation:2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), child: Padding(padding: const EdgeInsets.all(16), child: child));
}

class Reminders extends StatefulWidget{ final I18n i18n; const Reminders({super.key, required this.i18n}); @override State<Reminders> createState()=>_RState();}
class _RState extends State<Reminders>{
  final _plugin = FlutterLocalNotificationsPlugin();
  List<String> times=[];
  @override void initState(){ super.initState(); _init(); }
  Future<void> _init() async{
    const initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const init = InitializationSettings(android: initAndroid);
    await _plugin.initialize(init);
    final prefs = await SharedPreferences.getInstance();
    times = prefs.getStringList('times') ?? [];
    setState((){});
  }
  Future<void> _save() async{ final p = await SharedPreferences.getInstance(); await p.setStringList('times', times); }
  Future<void> _schedule(String hhmm) async{
    final parts = hhmm.split(':');
    final h = int.parse(parts[0]); final m = int.parse(parts[1]);
    const androidDetails = AndroidNotificationDetails('water_channel', 'Water Reminders', channelDescription: 'Daily reminders', importance: Importance.high, priority: Priority.high);
    const n = NotificationDetails(android: androidDetails);
    final now = tz.TZDateTime.now(tz.local);
    var sched = tz.TZDateTime(tz.local, now.year, now.month, now.day, h, m);
    if (sched.isBefore(now)) sched = sched.add(const Duration(days:1));
    await _plugin.zonedSchedule(hhmm.hashCode, 'Stay Hydrated!', 'Time to offer fresh water.', sched, n, androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, matchDateTimeComponents: DateTimeComponents.time);
  }
  Future<void> _add() async{
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(t==null) return;
    final hh = t.hour.toString().padLeft(2,'0'); final mm = t.minute.toString().padLeft(2,'0');
    final s = f"{'{'}hh{'}'}:{'{'}mm{'}'}";
    if(!times.contains(s)){ setState(()=>times.add(s)); times.sort(); await _save(); await _schedule(s); }
  }
  Future<void> _remove(String s) async{ setState(()=>times.remove(s)); await _save(); await _plugin.cancel(s.hashCode); }
  @override Widget build(BuildContext context){
    final i = widget.i18n;
    return Padding(padding: const EdgeInsets.all(16), child: Column(children:[
      Expanded(child: times.isEmpty? Center(child: Text('No reminders yet')): ListView.builder(itemCount: times.length, itemBuilder: (_,idx){
        final t = times[idx];
        return Card(child: ListTile(leading: const Icon(Icons.opacity), title: Text(t), trailing: IconButton(icon: const Icon(Icons.delete), onPressed: ()=>_remove(t))));
      })),
      FloatingActionButton.extended(onPressed: _add, icon: const Icon(Icons.add), label: Text(i.t('show'))),
    ]));
  }
}

class Tips extends StatelessWidget{ final I18n i18n; const Tips({super.key, required this.i18n});
  @override Widget build(BuildContext context){
    final tips = i18n.locale.languageCode=='hi'? {json.dumps(tips_hi)} : {json.dumps(tips_en)};
    tips.shuffle();
    final tip = tips.first;
    return Padding(padding: const EdgeInsets.all(16), child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(tip))));
  }
}

class Settings extends StatelessWidget{
  final I18n i18n; final void Function(ThemeMode) onTheme; final void Function(Locale) onLang;
  const Settings({super.key, required this.i18n, required this.onTheme, required this.onLang});
  @override Widget build(BuildContext context){
    return ListView(padding: const EdgeInsets.all(16), children:[
      Card(child: ListTile(leading: const Icon(Icons.language), title: Text(i18n.t('language')), trailing: DropdownButton<Locale>(value: i18n.locale, items: const [DropdownMenuItem(value: Locale('en'), child: Text('English')), DropdownMenuItem(value: Locale('hi'), child: Text('हिंदी'))], onChanged:(v){ if(v!=null) onLang(v);} ))),
      const SizedBox(height:12),
      Card(child: ListTile(leading: const Icon(Icons.color_lens_outlined), title: Text(i18n.t('theme')), trailing: DropdownButton<ThemeMode>(value: ThemeMode.system, items: const [DropdownMenuItem(value: ThemeMode.light, child: Text('Light')), DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')), DropdownMenuItem(value: ThemeMode.system, child: Text('System'))], onChanged:(v){ if(v!=null) onTheme(v);} ))),
    ]);
  }
}
