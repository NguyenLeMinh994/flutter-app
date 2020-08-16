import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Welcome", home: RandomWord());
  }
}

class RandomWord extends StatefulWidget {
  RandomWordState createState() => new RandomWordState();
}

class RandomWordState extends State<RandomWord> {
  final List<WordPair> _words = <WordPair>[];
  final _biggestFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index.isOdd) {
              return Divider();
            }

            if (index >= _words.length) {
              _words.addAll(generateWordPairs().take(10));
            }

            return _buildRow(_words[index]);
          },
        ),
      ),
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final bool alreadySaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggestFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles =
          _saved.map((WordPair pair) => new ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggestFont,
                ),
              ));
      final List<Widget> divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: Text("Saved list"),
        ),
        body: new ListView(
          children: divided,
        ),
      );
    }));
  }
}
