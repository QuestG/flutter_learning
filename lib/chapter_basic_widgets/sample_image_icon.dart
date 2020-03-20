import 'package:flutter/material.dart';

class SampleImageIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var img = AssetImage("assets/ic_avatar.png");
    return Scaffold(
      appBar: AppBar(
        title: Text("Image and Icon"),
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Image>[
                Image(
                  image: img,
                  height: 50.0,
                  width: 100.0,
                  fit: BoxFit.fill,
                ),
                Image(
                  image: img,
                  height: 50,
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  height: 50.0,
                  fit: BoxFit.fitWidth,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  height: 50.0,
                  fit: BoxFit.fitHeight,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  height: 50.0,
                  fit: BoxFit.scaleDown,
                ),
                Image(
                  image: img,
                  height: 50.0,
                  width: 100.0,
                  fit: BoxFit.none,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  color: Colors.blue,
                  colorBlendMode: BlendMode.difference,
                  fit: BoxFit.fill,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  height: 200.0,
                  repeat: ImageRepeat.repeatY,
                ),
                Image.network(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
                  width: 100.0,
                  fit: BoxFit.none,
                ),
              ].map((e) {
                return Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: SizedBox(
                          child: e,
                          width: 100,
                        ),
                      ),
                      Text(e.fit.toString()),
                      Icon(
                        Icons.accessible,
                        color: Colors.green,
                      ),
                      Icon(
                        CustomIcon.alipay,
                        color: Colors.blue,
                      ),
                      Icon(
                        CustomIcon.wechat,
                        color: Colors.green,
                      )
                    ],
                  ),
                );
              }).toList())),
    );
  }
}

// 自定义图标
class CustomIcon {
  static const IconData alipay = const IconData(0xe610,
      fontFamily: 'customIcon', matchTextDirection: true);

  static const IconData wechat = const IconData(0xe507,
      fontFamily: 'customIcon', matchTextDirection: true);
}
