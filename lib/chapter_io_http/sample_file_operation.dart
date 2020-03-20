import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

///path_provider插件提供了一种平台透明的方式来访问设备文件系统上的常用位置。
///
/// 该类当前支持访问两个文件系统位置：
///
///1、临时目录: 可以使用 getTemporaryDirectory() 来获取临时目录； 系统可随时清除的临时目录（缓存）。
///
///2、文档目录: 可以使用getApplicationDocumentsDirectory()来获取应用程序的文档目录，该目录
///用于存储只有自己可以访问的文件。只有当应用程序被卸载时，系统才会清除该目录。
///
///3、外部存储目录：可以使用getExternalStorageDirectory()来获取外部存储目录，如SD卡；
///由于iOS不支持外部目录，所以在iOS下调用该方法会抛出UnsupportedError异常，而在Android下
///结果是android SDK中getExternalStorageDirectory的返回值。
class FileOperationTest extends StatefulWidget {
  FileOperationTest({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FileOperationTestState();
  }
}

class _FileOperationTestState extends State<FileOperationTest> {
  int _counter;

  Future<File> _getLocalFile() async {
    var dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    //将点击次数以字符串形式写入文件
    await (await _getLocalFile()).writeAsString("$_counter");
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IO操作"),
      ),
      body: Center(
        child: Text("点击了$_counter次"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "Increment",
        child: Icon(Icons.add),
      ),
    );
  }
}
