import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const PetNutritionApp());
}

class PetNutritionApp extends StatefulWidget {
  const PetNutritionApp({super.key});

  @override
  State<PetNutritionApp> createState() => _PetNutritionAppState();
}

class _PetNutritionAppState extends State<PetNutritionApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Nutrition',
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: PetListScreen(
        onToggleTheme: () {
          setState(() {
            _themeMode = _themeMode == ThemeMode.dark
                ? ThemeMode.light
                : ThemeMode.dark;
          });
        },
      ),
    );
  }
}

class Pet {
  final String name;
  final String type;
  final String nutrition;

  Pet({required this.name, required this.type, required this.nutrition});

  Map<String, dynamic> toJson() =>
      {"name": name, "type": type, "nutrition": nutrition};

  static Pet fromJson(Map<String, dynamic> json) => Pet(
        name: json["name"],
        type: json["type"],
        nutrition: json["nutrition"],
      );
}

class PetListScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const PetListScreen({super.key, required this.onToggleTheme});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("pets");
    if (data != null) {
      final List decoded = jsonDecode(data);
      setState(() {
        pets = decoded.map((e) => Pet.fromJson(e)).toList();
      });
    } else {
      // Demo pets
      pets = [
        Pet(
            name: "Tommy",
            type: "Dog",
            nutrition: "High protein, calcium, omega-3"),
        Pet(
            name: "Kitty",
            type: "Cat",
            nutrition: "Taurine-rich, protein, vitamin A"),
        Pet(
            name: "Snowball",
            type: "Rabbit",
            nutrition: "Fresh hay, leafy greens, fiber"),
      ];
      _savePets();
    }
  }

  Future<void> _savePets() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("pets", jsonEncode(pets.map((e) => e.toJson()).toList()));
  }

  void _addPet() async {
    final pet = await Navigator.push<Pet>(
      context,
      MaterialPageRoute(builder: (_) => const AddPetScreen()),
    );
    if (pet != null) {
      setState(() => pets.add(pet));
      _savePets();
    }
  }

  void _deletePet(int index) {
    setState(() => pets.removeAt(index));
    _savePets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Nutrition"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(pet.name),
              subtitle: Text("${pet.type} • ${pet.nutrition}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deletePet(index),
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

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _nutritionController = TextEditingController();

  void _save() {
    if (_nameController.text.isNotEmpty &&
        _typeController.text.isNotEmpty &&
        _nutritionController.text.isNotEmpty) {
      Navigator.pop(
        context,
        Pet(
          name: _nameController.text,
          type: _typeController.text,
          nutrition: _nutritionController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Pet")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Pet Name")),
            TextField(controller: _typeController, decoration: const InputDecoration(labelText: "Pet Type")),
            TextField(controller: _nutritionController, decoration: const InputDecoration(labelText: "Nutrition")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _save, child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
