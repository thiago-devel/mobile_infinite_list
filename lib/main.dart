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
    return MaterialApp(
      title: 'MyInfiniteListApp',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: RandomNames(),
    );
  }
}

class RandomNamesState extends State<RandomNames> {
  final _suggestions = <String>[];
  final Set<String> _saved = Set<String>();
  final _biggerFonts = const TextStyle(fontSize: 18.0);

  Widget _buildRow(String name) {
    final alreadySaved = _saved.contains(name);

    return ListTile(
      title: Text(
        name,
        style: _biggerFonts,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          print('O botao ($name) foi pressionado.');

          if (alreadySaved) {
            _saved.remove(name);
          } else {
            _saved.add(name);
          }
        });
      },
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

  void _pushSaved() {
    print('pressionou o botao List');

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (String name) {
              return ListTile(
                title: Text(
                  name,
                  style: _biggerFonts,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Nomes salvos'),
            ),
            body: ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerador de nomes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomNames extends StatefulWidget {
  @override
  RandomNamesState createState() {
    return RandomNamesState();
  }
}
