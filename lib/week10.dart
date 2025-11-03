import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Showcase',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WidgetShowcase(),
    );
  }
}

class WidgetShowcase extends StatefulWidget {
  @override
  State<WidgetShowcase> createState() => _WidgetShowcaseState();
}

class _WidgetShowcaseState extends State<WidgetShowcase> {
  List<String> items = List.generate(5, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Flutter Widgets Demo'),
              background: Image.network(
                'https://picsum.photos/400',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverSafeArea(
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Stack Example
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 120,
                      color: Colors.blue[100],
                    ),
                    const Text(
                      'This is a Stack',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Card(
                  margin: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 150,
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.star, color: Colors.orange),
                          title: Text('ListTile 1'),
                          subtitle: Text('Subtitle 1'),
                        ),
                        ListTile(
                          leading: Icon(Icons.favorite, color: Colors.red),
                          title: Text('ListTile 2'),
                          subtitle: Text('Subtitle 2'),
                        ),
                      ],
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'GridView.count Example',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                SizedBox(
                  height: 150,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                      6,
                          (index) => Card(
                        color: Colors.blue[(index + 2) * 100],
                        child: Center(child: Text('Count $index')),
                      ),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'GridView.extent Example',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                SizedBox(
                  height: 150,
                  child: GridView.extent(
                    maxCrossAxisExtent: 100,
                    children: List.generate(
                      6,
                          (index) => Card(
                        color: Colors.green[(index + 2) * 100],
                        child: Center(child: Text('Extent $index')),
                      ),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'GridView.builder Example',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                SizedBox(
                  height: 150,
                  child: GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => Card(
                      color: Colors.purple[(index + 2) * 100],
                      child: Center(child: Text('Builder $index')),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Dismissible List Example',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                Column(
                  children: items.map((item) {
                    return Dismissible(
                      key: Key(item),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        setState(() {
                          items.remove(item);
                        });
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(item),
                          subtitle: Text('Swipe to dismiss'),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ]),
            ),
          ),

          SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Card(
                color: Colors.orange[(index + 2) * 100],
                child: Center(child: Text('SliverGrid $index')),
              ),
              childCount: 6,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}