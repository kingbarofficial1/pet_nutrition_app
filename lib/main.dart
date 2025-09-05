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
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.pets, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "Pet Nutrition",
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DisclaimerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String petName = "";
  String petType = "Dog";
  String ageGroup = "Puppy (2–6m)";
  double weight = 5.0;

  final Map<String, List<String>> ageOptions = {
    "Dog": ["Puppy (2–6m)", "Adult (1–7y)", "Senior (7+)"],
    "Cat": ["Kitten (2–6m)", "Adult (1–7y)", "Senior (7+)"]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pet Nutrition App")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: "Pet Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.pets)),
              onChanged: (value) => setState(() => petName = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: petType,
              items: ["Dog", "Cat"].map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  petType = value!;
                  ageGroup = ageOptions[petType]!.first;
                });
              },
              decoration: const InputDecoration(
                labelText: "Pet Type",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: ageGroup,
              items: ageOptions[petType]!
                  .map((age) => DropdownMenuItem(value: age, child: Text(age)))
                  .toList(),
              onChanged: (value) => setState(() => ageGroup = value!),
              decoration: const InputDecoration(
                labelText: "Age Group",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Weight (kg):",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Slider(
                  min: 0.5,
                  max: 50,
                  divisions: 100,
                  label: "${weight.toStringAsFixed(1)} kg",
                  value: weight,
                  onChanged: (value) => setState(() => weight = value),
                ),
                Text("${weight.toStringAsFixed(1)} kg",
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NutritionScreen(
                      petName: petName,
                      petType: petType,
                      ageGroup: ageGroup,
                      weight: weight,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.fastfood),
              label: const Text("Show Nutrition Guide"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionScreen extends StatelessWidget {
  final String petName;
  final String petType;
  final String ageGroup;
  final double weight;

  const NutritionScreen({
    super.key,
    required this.petName,
    required this.petType,
    required this.ageGroup,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    String recommendation = "";

    if (petType == "Dog") {
      if (ageGroup.contains("Puppy")) {
        recommendation =
            "3–4 meals/day → Puppy kibble, rice + chicken, curd, boiled eggs";
      } else if (ageGroup.contains("Adult")) {
        recommendation =
            "2 meals/day → Adult kibble, rice + chicken/veg, eggs, occasional bones";
      } else {
        recommendation =
            "2 small meals/day → Senior kibble, boiled chicken + rice, soft food";
      }
    } else {
      if (ageGroup.contains("Kitten")) {
        recommendation =
            "3–4 meals/day → Kitten kibble, boiled fish/chicken, lactose-free milk";
      } else if (ageGroup.contains("Adult")) {
        recommendation =
            "2 meals/day → Adult kibble, fish/chicken + rice, curd, taurine-rich foods";
      } else {
        recommendation =
            "2 small meals/day → Senior kibble, soft canned food, boiled fish";
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Nutrition Guide")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.pets, color: Colors.teal, size: 40),
                title: Text(
                  "${petName.isNotEmpty ? petName : "Your Pet"}'s Nutrition",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("$petType • $ageGroup"),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("⚖️ Weight",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("${weight.toStringAsFixed(1)} kg",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("🥗 Recommended Diet",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      recommendation,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Disclaimer & Info")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "Disclaimer:\n\n"
              "This app provides general pet nutrition guidelines only. "
              "Every pet is unique. Please consult a veterinarian before "
              "making significant changes to your pet’s diet.\n\n"
              "App by: Your Name / Brand\n"
              "Version: 1.0.0",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
