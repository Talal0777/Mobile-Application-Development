import 'package:flutter/material.dart';

void main() {
  runApp(const TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  const TravelGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

// ------------------- HOME SCREEN -------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController destinationController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Travel Guide')),
      drawer: AppDrawer(), // Drawer for navigation
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Welcome to the Travel Guide App!\nDiscover amazing destinations and plan your next adventure.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Explore the ",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: [
                    TextSpan(
                      text: "World ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    TextSpan(text: "with "),
                    TextSpan(
                      text: "Us!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: destinationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Destination',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Searching for ${destinationController.text}... 🌍"),
                  ));
                },
                child: const Text("Search Destination"),
              ),
              TextButton(
                onPressed: () {
                  print("TextButton clicked!");
                },
                child: const Text("More Options"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- LIST SCREEN -------------------
class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  final List<Map<String, String>> destinations = const [
    {"name": "Paris", "desc": "City of Love and Lights."},
    {"name": "Tokyo", "desc": "A blend of tradition and technology."},
    {"name": "New York", "desc": "The city that never sleeps."},
    {"name": "Dubai", "desc": "Luxury meets desert adventure."},
    {"name": "London", "desc": "Home of Big Ben and royal history."},
    {"name": "Rome", "desc": "Ancient ruins and Renaissance art."},
    {"name": "Istanbul", "desc": "Where Europe meets Asia."},
    {"name": "Sydney", "desc": "Beautiful beaches and Opera House."},
    {"name": "Cairo", "desc": "Land of the Pyramids."},
    {"name": "Bali", "desc": "Island of gods and beaches."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Travel Destinations")),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.location_on, color: Colors.blue),
            title: Text(destinations[index]['name']!),
            subtitle: Text(destinations[index]['desc']!),
          );
        },
      ),
    );
  }
}

// ------------------- ABOUT SCREEN -------------------
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final List<Map<String, String>> landmarks = const [
    {"image": "https://upload.wikimedia.org/wikipedia/commons/a/a8/Taj-Mahal.jpg", "name": "Taj Mahal"},
    {"image": "https://upload.wikimedia.org/wikipedia/commons/a/af/Eiffel_Tower_Paris.jpg", "name": "Eiffel Tower"},
    {"image": "https://upload.wikimedia.org/wikipedia/commons/a/ab/Great_Wall_of_China.jpg", "name": "Great Wall"},
    {"image": "https://upload.wikimedia.org/wikipedia/commons/6/6e/Statue_of_Liberty_7.jpg", "name": "Statue of Liberty"},
    {"image": "https://upload.wikimedia.org/wikipedia/commons/d/d3/Colosseum_in_Rome%2C_Italy_-_April_2007.jpg", "name": "Colosseum"},
    {"image": "https://upload.wikimedia.org/wikipedia/commons/6/6b/Sydney_Opera_House_Sails.jpg", "name": "Sydney Opera House"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      drawer: AppDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: landmarks.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: Image.network(
                  landmarks[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                landmarks[index]['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ------------------- DRAWER -------------------
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                "Travel Guide Menu",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("Destinations"),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const ListScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
          ),
        ],
      ),
    );
  }
}
