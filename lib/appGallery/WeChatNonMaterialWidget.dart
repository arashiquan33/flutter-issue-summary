
//抛弃materialApp，使用原生widget一步一步构建微信主页
//通过自行创建widget，逐步了解flutter组件开发的模式和一些基本原理



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



//底部图标+按钮的组合widget
class FooterIconButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  static const double IconSize=16;
  static const double fontSize=(IconSize*3)/4;
  FooterIconButton(this.text,this.iconData);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData,color: Color.fromRGBO(64, 148, 0, 1),size: IconSize),
          Text(text, style: TextStyle(fontSize: fontSize),)
        ],
      ),
    );
  }
}


//底部
class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Color.fromRGBO(197, 191, 0, 1),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child:Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
             FooterIconButton('微信', Icons.chat_bubble),
             FooterIconButton('通讯录', Icons.perm_contact_calendar_outlined),
             FooterIconButton('发现', Icons.speed),
             FooterIconButton('我', Icons.account_circle_outlined),
         ],
      )
    );
  }
}

//顶部bar
class Header extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(249, 43, 52, 1),
      height: 40,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child:GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.keyboard_arrow_left,color: Colors.white,))
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                  '微信',
                  style: TextStyle(fontSize: 16),

              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(

                children: [
                  Icon(Icons.search,color: Color.fromRGBO(255, 255, 255, 1),),
                  Icon(Icons.add,color: Color.fromRGBO(255, 255, 255, 1),)
                ],
              ),
            )
          ],
        ),
      )
    );
  }

}

//主体列表中每项widget
class BodyListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border(bottom: BorderSide(color: Colors.amberAccent,width: 1.0,))
      ),
      height: 60,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 49,
            color: Colors.cyanAccent,
            child: Image(image: AssetImage('assets/img1.png'),),
          ),
          Expanded( //使用Expanded widget 将剩余部分占满
            flex: 1,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  Expanded(
                      flex:1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,//横轴拉伸铺满
                        children: [
                          Text('EBR西安开发组',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                          Text('EBR西安开发1组',style: TextStyle(fontSize: 12,color: Colors.black54),)
                        ],
                  )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('15:30',style: TextStyle(fontSize: 10,color: Colors.black54),),
                      Icon(Icons.notifications_off_outlined,size:12)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


//中间主体内容
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //使用ListView最基础的构造函数，来生成静态的列表，动态列表可以采用ListView.builder
    return ListView(
      shrinkWrap: true,//扩展收缩，让ListView的高度不是无限的
      children: [
        BodyListItem(),
        BodyListItem(),
        BodyListItem(),
        BodyListItem(), BodyListItem(), BodyListItem(), BodyListItem(), BodyListItem(),BodyListItem(),
        BodyListItem(),
        BodyListItem(),
        BodyListItem(), BodyListItem(), BodyListItem(), BodyListItem(), BodyListItem()
      ],
    );
  }
}



//骨架，包含头、主体、底部
class WeChatIndex extends StatelessWidget {

  final Header header;
  final Body body;
  final Footer footer;
  WeChatIndex(this.header,this.body,this.footer);
  @override
  Widget build(BuildContext context) {
    //Directionality 最上层设置文字方向
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin:EdgeInsets.fromLTRB(0, 25, 0, 0),
        decoration: BoxDecoration(color: Color.fromRGBO(138,197,241,1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            header,
            Expanded(child:  body,flex: 1,),//flex:1，设置body widget占满剩余部分
            footer
          ],
        ),
      ),
    );
  }
}



class MyWebChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return WeChatIndex(
        Header(),
        Body(),
      Footer()
    );
  }
}
