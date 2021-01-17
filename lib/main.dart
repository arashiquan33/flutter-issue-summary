
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = [new WordPair.random()];
  final _biggerFont  = TextStyle(fontSize: 18.0);
  final Set<WordPair> _liked = Set<WordPair>();

  Widget _buildSuggestions(){
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context,i){
            if(i.isOdd) return Divider(color:Colors.red);
            if(i<this._suggestions.length){
              final alreadyGeneratedWordPair = this._suggestions[i];
              return this._buildRow(alreadyGeneratedWordPair);
            }else{
              final newWordPair = WordPair.random();
              this._suggestions.add(newWordPair);
              return this._buildRow(newWordPair);
            }


        }
    );
  }

  Widget _buildRow(WordPair pair){
    var alreadyLiked = this._liked.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: this._biggerFont,
      ),
      trailing: Icon(
        alreadyLiked? Icons.favorite:Icons.favorite_border_rounded,
        color: alreadyLiked? Colors.red:null,
      ),
      onTap: (){
        this.setState(() {
             if(alreadyLiked){
                this._liked.remove(pair);
             } else{
                this._liked.add(pair);
             }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("welcome to flutter"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: (){
            Navigator.of(context).push(
                new MaterialPageRoute<void>(builder: (BuildContext context){
                  return new Scaffold(         // 新增 6 行代码开始 ...
                      appBar: new AppBar(
                        title: const Text('Saved Suggestions'),
                      ),
                      body: new Text("22")
                  );
                })
            );
          })
        ],
      ),
      body: this._buildSuggestions()
    );
  }
}


class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "first demo",
      home: new RandomWords()
    );
  }
}

void main()=>{
  runApp(MyApp())
};