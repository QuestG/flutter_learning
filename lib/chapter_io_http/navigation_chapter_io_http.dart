import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_io_http/sample_download_chunks.dart';
import 'package:flutter_learning/chapter_io_http/sample_file_operation.dart';
import 'package:flutter_learning/chapter_io_http/sample_httpclient.dart';
import 'package:flutter_learning/chapter_io_http/sample_json_serializable.dart';
import 'package:flutter_learning/chapter_io_http/sample_package_dio.dart';
import 'package:flutter_learning/chapter_io_http/sample_socket.dart';
import 'package:flutter_learning/chapter_io_http/sample_webscoket.dart';

// ignore: must_be_immutable
class NaviChapterIOHttp extends StatelessWidget {
  var itemTitles = [
    "10.1 文件操作",
    "10.2 Http请求-HttpClient",
    "10.3 Http请求-Dio package",
    "10.4 实例：Http分块下载",
    "10.5 WebSocket",
    "10.6 使用Socket API",
    "10.7 Json转Dart model类",
  ];

  var itemWidgets = [
    FileOperationTest(),
    HttpTestRoute(),
    DioTest(),
    DownloadChunksTest(),
    WebSocketRoute(),
    SocketRoute(),
    JsonSerializableRoute()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IO and HTTP"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index < itemWidgets.length) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => itemWidgets[index]));
                } else {
                  //arguments为true是因为onGenerateRoute中的逻辑是根据bool值进行判断的
                  Navigator.pushNamed(context, itemTitles[index],
                      arguments: true);
                }
              },
              child: ListTile(
                title: Text(itemTitles[index]),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey);
          },
          itemCount: itemTitles.length),
    );
  }
}
