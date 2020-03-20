import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

//Http协议和WebSocket协议都属于应用层协议，除了它们，应用层协议还有很多如：SMTP、FTP等，
//这些应用层协议的实现都是通过Socket API来实现的。
class SocketRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SocketRouteState();
  }
}

class _SocketRouteState extends State<SocketRoute> {
  String _response = "";

  @override
  void initState() {
    super.initState();
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Socket"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Text(_response),
        ),
      ),
    );
  }

  void _request() async {
    //建立连接
    var socket = await Socket.connect("baidu.com", 80);
    //根据http协议，发送请求头
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln("Connection:close");
    socket.writeln();
    //发送请求
    await socket.flush();
    //读取返回内容
    _response = await socket.transform(Converter.castFrom(utf8.decoder)).join();
    setState(() {});
    await socket.close();
  }
}
