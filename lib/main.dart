import 'package:flutter/material.dart';
import 'package:my_infinite_list/models/names.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var names = new Names();
    return MaterialApp(
      title: 'MyFamilyApp',
      debugShowCheckedModeBanner: false,
      /*
      home: Scaffold(
        appBar: AppBar(
          title: Text('Membros da família'),
        ),
        body: Center(
          child: Text(
            //new Names().getRandomName(),
            new Names().getRandomNames(10)[0],
          ),
        ),
      ),
      */
      home: FamilyRandomNames(),
    );
  }
}

class FamilyRandomNamesState extends State<FamilyRandomNames> {
  final _suggestions = <String>[];
  final _biggerFonts = const TextStyle(fontSize: 18.0);

  Widget _buildRow(String name) {
    return ListTile(
      title: Text(
        name,
        style: _biggerFonts,
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /* 1 */ (context, i) {
          if (i.isOdd) return Divider(); /* 2 */

          final index = i ~/ 2; /* 3 */
          if (index >= _suggestions.length) {
            var items = new Names().getRandomNames(10);
            print('Items: ($items)');
            _suggestions.addAll(items); /* 4 */
            print('_suggestions: ($_suggestions)');
          }

          var item = _suggestions[index];
          print('index: ($index) in _suggestions[index] is ($item)');
          return _buildRow(item);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerador de nomes'),
      ),
      body: _buildSuggestions(),
    );
  }
}

class FamilyRandomNames extends StatefulWidget {
  @override
  FamilyRandomNamesState createState() {
    return FamilyRandomNamesState();
  }
}
