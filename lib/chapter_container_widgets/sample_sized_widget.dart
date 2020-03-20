import 'package:flutter/material.dart';

class SizeWidgetTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ContrainedBox SizedBox"),
        actions: <Widget>[
          /// 在定义一个通用的组件时，如果要对子组件指定限制，
          /// 那么一定要注意，因为一旦指定限制条件，子组件如果要进行相关自定义大小时将可能非常困难，
          /// 因为子组件在不更改父组件的代码的情况下无法彻底去除其限制条件。
          /// 在实际开发中，当我们发现已经使用SizedBox或ConstrainedBox给子元素指定了宽高，
          /// 但是仍然没有效果时，几乎可以断定：已经有父元素已经设置了限制！
          ///
          /// UnconstrainedBox不会对子组件产生任何限制，它允许其子组件按照其本身大小绘制。
          /// 一般情况下，我们会很少直接使用此组件，但在"去除"多重限制的时候也许会有帮助。
          /// 比如AppBar中已经指定了actions按钮的限制条件，所以我们要自定义loading按钮大小，
          /// 就必须通过UnconstrainedBox来“去除”父元素的限制
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          /// 对child添加额外约束，通过设置constraints属性。
          /// 关于BoxConstraints的使用，可以参考源码。
          ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: double.infinity, minHeight: 50),
            child: Container(
              child:
                  DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
              height: 8,
              width: 6,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),

            /// 查看SizedBox源码，会发现SizedBox的实现是RenderConstrainedBox。
            child: SizedBox(
              width: 50,
              height: 50,
              child:
                  DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),

            /// 有多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。
            /// 有多重限制时，对于maxWidth和maxHeight来说，是取父子中相应数值较小的。
            /// 这样才能保证父限制与子限制不冲突。
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 50, minHeight: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 30, minHeight: 50),
                child:
                    DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
