import 'package:flutter/material.dart';

//Hero动画就是在路由切换时，有一个共享的widget可以在新旧路由间切换。由于共享的widget在
//新旧路由页面上的位置、外观可能有所差异，所以在路由切换时会从旧路逐渐过渡到新路由中的指定位置，
//这样就会产生一个Hero动画.它就是Android系统中所说的共享元素转换的动画。
///实现Hero动画只需要用Hero组件将要共享的widget包装起来，并提供一个相同的tag即可，
///中间的过渡帧都是Flutter Framework自动完成的。必须要注意， 前后路由页的共享Hero的tag必须是相同的，
///Flutter Framework内部正是通过tag来确定新旧路由页widget的对应关系的。
class HeroAnimationTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HeroAnimation"),
      ),
      body: Container(
        alignment: Alignment.center,
        // A rectangular area of a [Material] that responds to touch.
        //Must have an ancestor [Material] widget in which to cause ink reactions.
        child: InkWell(
          child: Hero(
              //唯一标记，前后两个路由页Hero的tag必须相同
              tag: "avatar",
              child: ClipOval(
                child: Image.asset(
                  "assets/ic_avatar.png",
                  width: 50,
                ),
              )),
          onTap: () {
            Navigator.push(context,
                PageRouteBuilder(pageBuilder: (context, animation, animation2) {
              return FadeTransition(
                opacity: animation,
                child: HeroAnimationTestB(),
              );
            }));
          },
        ),
      ),
    );
  }
}

class HeroAnimationTestB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HeroAnimation"),
        ),
        body: Center(
          child: Hero(
            tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
            child: Image.asset("assets/ic_avatar.png"),
          ),
        ));
  }
}
