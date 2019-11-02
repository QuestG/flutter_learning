import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ListViewTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListViewTestState();
  }
}

class _ListViewTestState extends State<ListViewTest> {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("单词列表"),
          ),
          Expanded(
              //ListView的父Widget要有明确的边界，否则ListView会报高度边界无法确定的异常。
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (_words[index] == loadingTag) {
                      if (_words.length - 1 < 40) {
                        _retrieveData();
                        return Container(
                          padding: EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "没有更多了",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }
                    }
                    return ListTile(title: Text(_words[index]));
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[300],
                      ),
                  itemCount: _words.length)),
        ],
      ),
    );
  }
}
