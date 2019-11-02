import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_10/sample_package_dio.dart';

///分块下载
///Http协议定义了分块传输的响应header字段，但具体是否支持取决于Server的实现，我们可以指定
///请求头的"range"字段来验证服务器是否支持分块传输。
///
///比如在请求头中添加"Range: bytes=0-10"，其作用是告诉服务器本次请求我们只想获取文件0-10
///(包括10，共11字节)这块内容。如果服务器支持分块传输，则响应状态码为206，表示“部分内容”，
///并且同时响应头中包含“Content-Range”字段，如果不支持则不会包含。
///
/// 文件分块下载器，实现的思路是：
///1、先检测是否支持分块传输，如果不支持，则直接下载；若支持，则将剩余内容分块下载。
///2、各个分块下载时保存到各自临时文件，等到所有分块下载完后合并临时文件。
///3、删除临时文件。
class DownloadChunksTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DownloadChunksTestState();
  }
}

class _DownloadChunksTestState extends State<DownloadChunksTest> {
  var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
  var savePath = "./example/HBuilder.9.0.2.macosx_64.dmg";

  int _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分块下载示例"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("下载进度:$_progress%"),
            RaisedButton(
              onPressed: () async {
                await downloadWithChunks(url, savePath,
                    onReceiveProgress: (received, total) {
                  if (total != -1) {
                    setState(() {
                      _progress = (received / total * 100).floor();
                    });
                  }
                });
              },
              child: Text("开始分块下载"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //关闭所有的请求
    DioInstance().dio.close();
    super.dispose();
  }
}

Future downloadWithChunks(url, savePath,
    {ProgressCallback onReceiveProgress}) async {
  const firstChunkSize = 102; //第一个文件块的大小
  const maxChunk = 3; //最多同时下载的文件块数量
  int total = 0; //文件总大小

  var progress = <int>[];

  createCallback(no) {
    return (int received, _) {
      progress[no] = received;
      if (onReceiveProgress != null && total != 0) {
        onReceiveProgress(progress.reduce((a, b) => a + b), total);
      }
    };
  }

  Future<Response> downloadChunk(url, start, end, no) async {
    progress.add(0);
    --end;
    return DioInstance().dio.download(url, savePath + "temp$no",
        onReceiveProgress: createCallback(no),
        options: Options(headers: {"range": "bytes=$start-$end"}));
  }

  Future mergeTempFiles(chunk) async {
    File f = File(savePath + "temp0");
    IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
    for (int i = 1; i < chunk; ++i) {
      File _f = File(savePath + "temp$i");
      await ioSink.addStream(_f.openRead());
      await _f.delete();
    }
    await ioSink.close();
    await f.rename(savePath);
  }

  Response response = await downloadChunk(url, 0, firstChunkSize, 0);
  print("download response $response");
  if (response.statusCode == 206) {
    total = int.parse(
        response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);
    int reserved = total -
        int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
    int chunk = (reserved / firstChunkSize).ceil() + 1;
    if (chunk > 1) {
      int chunkSize = firstChunkSize;
      if (chunk > maxChunk + 1) {
        chunk = maxChunk + 1;
        chunkSize = (reserved / firstChunkSize).ceil();
      }
      var futures = <Future>[];
      for (int i = 0; i < maxChunk; i++) {
        int start = firstChunkSize + chunkSize * i;
        futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
      }
      await Future.wait(futures);
    }
    await mergeTempFiles(chunk);
  }
}
