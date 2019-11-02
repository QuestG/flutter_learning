import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

///Flutter也提供了专门的包(web_socket_channel)来支持WebSocket协议。
///
/// WebSocket协议本质上是一个基于tcp的协议，它是先通过HTTP协议发起一条特殊的http请求进行握手后，
/// 如果服务端支持WebSocket协议，则会进行协议升级。WebSocket会使用http协议握手后创建的tcp链接，
/// 和http协议不同的是，WebSocket的tcp链接是个长链接（不会断开），所以服务端与客户端就可以通过此TCP连接进行实时通信。
///
///WebSocket使用步骤：
///1、连接到WebSocket服务器：创建一个WebSocketChannel连接到一台服务器。
///2、监听来自服务器的消息：使用一个StreamBuilder 来监听新消息
///WebSocketChannel提供了一个来自服务器的消息Stream 。该Stream类是dart:async包中的一个基础类。
///它提供了一种方法来监听来自数据源的异步事件。与Future返回单个异步响应不同，Stream类可以随着
///时间推移传递很多事件。该StreamBuilder 组件将连接到一个Stream， 并在每次收到消息时通知Flutter重新构建界面。
///3、将数据发送到服务器：调用WebSocketChannel提供的sink的add方法
///4、关闭WebSocket连接：调用WebSocketChannel.sink.close()
///
///
/// WebSocket中所有发送的数据使用帧的形式发送，而帧是有固定格式，每一个帧的数据类型都可以通过Opcode字段指定，
/// 它可以指定当前帧是文本类型还是二进制类型（还有其它类型），所以客户端在收到帧时就已经知道了其数据类型，
/// 所以flutter完全可以在收到数据后解析出正确的类型，所以就无需开发者去关心，当服务器传输的数据是指定为二进制时，
/// StreamBuilder的snapshot.data的类型就是List<int>，是文本时，则为String。
class WebSocketRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebSocketRouteState();
  }
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    super.initState();
    //创建WebSocket连接
    channel = IOWebSocketChannel.connect("ws://echo.websocket.org");
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebScoket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
                child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Send a messsage"),
            )),
            StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    _text = "网络不通...";
                  } else if (snapshot.hasData) {
                    _text = "echo: ${snapshot.data}";
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(_text),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: "Send Message",
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }
}
