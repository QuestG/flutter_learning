import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

//使用HttpClient发起请求分为五步：
//1、创建一个HttpClient
//2、打开Http连接，设置请求头。可以使用任意Http Method，如httpClient.post(...)等。
//如果包含Query参数，可以在构建uri时添加
//3、等待连接服务器：request.close()
//4、读取响应内容 String responseBody = await response.transform(utf8.decoder).join();
//5、请求结束，关闭HttpClient，通过该client发起的所有请求都会中止

//Http协议的认证（Authentication）机制可以用于保护非公开资源。Http的方式除了Basic认证之外还有：Digest认证、Client认证、Form Based认证等
//目前Flutter的HttpClient只支持Basic和Digest两种认证方式，这两种认证方式最大的区别是
//发送用户凭据时，对于用户凭据的内容，前者只是简单的通过Base64编码（可逆），而后者会进行哈希运算，
//相对来说安全一点点，但是为了安全起见，无论是采用Basic认证还是Digest认证，都应该在Https协议下，
//这样可以防止抓包和中间人攻击。

//HttpClient关于Http认证的方法和属性：
//1、addCredentials(Uri url, String realm, HttpClientCredentials credentials)
//2、authenticate(Future<bool> f(Uri url, String scheme, String realm))
//如果所有请求都需要认证，那么应该在HttpClient初始化时就调用addCredentials()来添加全局凭证，而不是去动态添加。

//HttpClient可以通过findProxy来设置代理策略.
//
//HttpClient对证书校验的逻辑如下：
//1、如果请求的Https证书是可信CA颁发的，并且访问host包含在证书的domain列表中(或者符合通配规则)并且证书未过期，则验证通过。
//2、如果第一步验证失败，但在创建HttpClient时，已经通过SecurityContext将证书添加到证书信任链中，那么当服务器返回的证书在信任链中的话，则验证通过。
//3、如果1、2验证都失败了，如果用户提供了badCertificateCallback回调，则会调用它，如果回调返回true，则允许继续链接，如果返回false，则终止链接。
//
//String PEM="XXXXX";//可以从文件读取
//...
//httpClient.badCertificateCallback=(X509Certificate cert, String host, int port){
//  if(cert.pem==PEM){
//    return true; //证书一致，则允许发送数据
//  }
//  return false;
//};

//对于自签名的证书，我们也可以将其添加到本地证书信任链中，这样证书验证时就会自动通过，而不会再走到badCertificateCallback回调中。
//SecurityContext sc=new SecurityContext();
//file为证书路径
//sc.setTrustedCertificates(file);
//创建一个HttpClient
//HttpClient httpClient = new HttpClient(context: sc);

//通过setTrustedCertificates()设置的证书格式必须为PEM或PKCS12，如果证书格式为PKCS12，
//则需将证书密码传入，这样则会在代码中暴露证书密码，所以客户端证书校验不建议使用PKCS12格式的证书。
class HttpTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HttpTestRouteState();
  }
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HttpClient"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("获取百度首页"),
                onPressed: _loading
                    ? null
                    : () async {
                        await _requestContent();
                      },
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(_text.replaceAll(RegExp(r"\s"), "")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _requestContent() async {
    setState(() {
      _loading = true;
      _text = "正在请求...";
    });

    try {
      var httpClient = HttpClient();
      var request = await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
      //使用iPhone的user-agent
      request.headers.add("user-agent",
          "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
      //等待连接服务器（会将请求信息发送给服务器）
      var response = await request.close();
      _text = await response.transform(utf8.decoder).join();
      //输出响应头
      print(response.headers);
      //关闭httpclient后，所有的请求都终止。
      httpClient.close();
    } catch (e) {
      _text = "请求失败：$e";
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
