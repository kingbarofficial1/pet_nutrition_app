
import 'package:flutter/material.dart';

void main() {
  runApp(const PetNutritionApp());
}

class PetNutritionApp extends StatelessWidget {
  const PetNutritionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Nutrition',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      supportedLocales: const [
        Locale('en', ''),
        Locale('hi', ''),
        Locale('mr', ''),
        Locale('kn', ''),
        Locale('ta', ''),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> pets = [
    {
      'name': 'Dog',
      'age': 2,
      'weight': 12,
      'diet': '2 cups of dry food, twice a day',
    },
    {
      'name': 'Cat',
      'age': 3,
      'weight': 5,
      'diet': '1 cup of wet food, once a day',
    },
    {
      'name': 'Rabbit',
      'age': 1,
      'weight': 2,
      'diet': 'Hay + fresh veggies, free access',
    },
  ];

  void _addPet() {
    setState(() {
      pets.add({
        'name': 'New Pet',
        'age': 1,
        'weight': 1,
        'diet': 'Custom diet',
      });
    });
  }

  void _removePet(int index) {
    setState(() {
      pets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pet Nutrition")),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(pet['name']),
              subtitle: Text(
                  "Age: ${pet['age']} yrs | Weight: ${pet['weight']} kg\nDiet: ${pet['diet']}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removePet(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
