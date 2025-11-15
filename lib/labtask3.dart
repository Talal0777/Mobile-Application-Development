import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD LabTask 03',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial'),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ButtonStyle btnStyle = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    textStyle: TextStyle(fontSize: 18),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4e54c8), Color(0xFF8f94fb)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'T777',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => DeviceInfoPage())),
                    child: Text('Device Info'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => GestureDetectorPage())),
                    child: Text('Gesture Detector'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => DraggableDemoPage())),
                    child: Text('Draggables'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => DismissiblePage())),
                    child: Text('Dismissible Widget'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: btnStyle,
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => ChipsPage())),
                    child: Text('Tags / Chips'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Device Information Page
class DeviceInfoPage extends StatefulWidget {
  @override
  _DeviceInfoPageState createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  static const platform = MethodChannel('device/info');
  String battery = "Unknown";
  String model = "Unknown";

  Future<void> getBattery() async {
    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      setState(() => battery = "$result%");
    } catch (e) {
      setState(() => battery = "Error getting battery");
    }
  }
  Future<void> getModel() async {
    try {
      final String result = await platform.invokeMethod("getDeviceModel");
      setState(() => model = result);
    } catch (e) {
      setState(() => model = "Error getting model");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Info'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFddeaff), Color(0xFFbde3e6)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8,
            margin: EdgeInsets.all(28),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Device Information",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade400),
                        onPressed: getBattery,
                        child: Text("Get Battery"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade400),
                        onPressed: getModel,
                        child: Text("Get Model"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Battery: $battery", style: TextStyle(fontSize: 18)),
                  Text("Model: $model", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Gesture Detector Page
class GestureDetectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Detector'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFfc4a1a), Color(0xFFf7b733)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFfcf6ba), Color(0xFFfff6f1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tapped!")));
            },
            onLongPress: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Long Press!")));
            },
            child: Container(
              height: 90,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.orange.shade200, Colors.pink.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Center(
                child: Text(
                  "Tap or Long Press",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Draggable & DragTarget Page
class DraggableDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Draggable & DragTarget'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF43cea2), Color(0xFF185a9d)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFbab9f6), Color(0xFF93ffd8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Draggable<String>(
                  data: "Dropped!",
                  feedback: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue.shade300,
                    child: Icon(Icons.touch_app, size: 30),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue.shade600,
                    child: Icon(Icons.drag_handle),
                  ),
                ),
                DragTarget<String>(
                  builder: (context, candidate, rejected) {
                    return Container(
                      height: 100,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                      ),
                      child: Center(
                        child: Text("Drop Here", style: TextStyle(fontSize: 17)),
                      ),
                    );
                  },
                  onAccept: (value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("You dropped: $value")));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

// Dismissible Widget Page
class DismissiblePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dismissible Widget'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFff512f), Color(0xFFdd2476)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFffe0e3), Color(0xFFffe7ba)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red.shade400,
              child: Icon(Icons.delete, color: Colors.white, size: 40),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Text("Swipe to Dismiss", style: TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }
}

// Chips/Tags Page
class ChipsPage extends StatelessWidget {
  final List<String> tags = ['Flutter', 'Channels', 'Android', 'Kotlin', 'IOS', 'linux'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tags / Chips'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe4ffe7), Color(0xFFfafefa)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Wrap(
            spacing: 10,
            children: tags.map((tag) => Chip(label: Text(tag))).toList(),
          ),
        ),
      ),
    );
  }
}