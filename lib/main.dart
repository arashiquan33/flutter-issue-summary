import 'package:flutter/material.dart';
/**
 * 构建基于flutter的应用，展示使用flutter构建的各种app演示、教程、组件等
 * main.dart 不使用materialApp提供的widget，采用flutter最底层的widget来构建，这样有利于更好的理解flutter的widget
**/


import 'package:flutter/widgets.dart';


/// 头部
class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 40.0,
      child: Container(
        color: Colors.red,
        child: Align(
          child: Text('flutter-startup',style: TextStyle(fontSize: 18.0,),),
        )
      ),
    );
  }
}

class GridViewItem extends StatelessWidget {
   final String displayName;
   final Color  displayColor;
   GridViewItem(this.displayName,this.displayColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: displayColor,
      child: Align(
        alignment: Alignment.center,
        child: Text(displayName),
      ),
    );
  }
}


/// 内容体
class Body extends StatelessWidget {
  final count=3;
  final spacing=10.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.count(
          padding: EdgeInsets.all(spacing),
          crossAxisCount: count,//设置横轴放置几个Grid
          mainAxisSpacing: spacing,//设置纵轴方向每个Grid上下间隔
          crossAxisSpacing: spacing,//设置横轴方向每个Grid上下间隔
          children: [
            GridViewItem('非MaterialApp组件模拟微信', Colors.blue),
            GridViewItem('materialApp组件模拟直播吧', Colors.cyan),
            GridViewItem('materialApp组件构建MI', Colors.amber),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
            GridViewItem('待开发', Colors.black54),
          ],
      )
    );
  }
}


class FooterItem extends StatelessWidget {
  final String displayName;
  final IconData iconData;
  static const color=Colors.white;
  FooterItem(this.displayName,this.iconData);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       Expanded(child: Icon(iconData,color: color,)),
       Expanded(child: Text(displayName,style: TextStyle(color: color),))
      ],
    );
  }
}


/// 底部
class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: Colors.red,
      padding: EdgeInsets.fromLTRB(10,5,10,5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FooterItem('应用展示', Icons.apps),
          FooterItem('widget展示', Icons.widgets_outlined)
        ],
      ),
    );
  }
}


class MyAppSafeArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SafeArea 组件可以让页面处于安全区，所谓安全区指的是应该的初始左上的位置位于手机本身的statusBar下面(statusBar一般包含了电量、wife等图标)
    return  SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black
        ),
        //上中下三栏布局
        child: Column(
          //设置column 纵向轴,使得布局呈现上中下3栏
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //设置子widget
          children: [
            Header(),
            //使用Flexible包装body,使得body占据剩余空间
            Flexible(
              child: Body(),
              flex: 1,
            ),
            Footer()
          ],
        ),
      ),
    );
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //从根节点就指定文字方向，这样,子的widget基本不需要再设置textDirection
    //创建MediaQuery data，因为使用SafeArea组件时，必须先在上下文中创建MediaQuery组件
    final mediaQueryData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data:mediaQueryData,
          child: MyAppSafeArea(),
        ));
  }
}



void main(){
  runApp(new MyApp());
}