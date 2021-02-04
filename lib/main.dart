import 'dart:async';

import 'package:flutter/material.dart';
/**
 * 构建基于flutter的应用，展示使用flutter构建的各种app演示、教程、组件等
 * main.dart 不使用materialApp提供的widget，采用flutter最底层的widget来构建，这样有利于更好的理解flutter的widget
**/


import 'package:flutter/widgets.dart';
import 'package:flutter_startup/animationGallery/index.dart';
import 'package:flutter_startup/appGallery/WeChatNonMaterialWidget.dart';
import 'package:flutter_startup/stateManager/index.dart';

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
   final Map<String,Widget> routeMap;
   GridViewItem(this.displayName,this.displayColor,{ this.routeMap=const {} } );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //如果配置了路由，跳转到路由对应的组件
        if(routeMap.isNotEmpty){
          Navigator.push(context,PageRouteBuilder(
              pageBuilder: (BuildContext context,Animation<double> animation, Animation<double> secondaryAnimation){
                return routeMap.values.first;
              }
          ));
        }else{
          //否则弹出窗口，这里使用overlay组件，学习overlay的用法
        OverlayEntry alert=  OverlayEntry(builder: (BuildContext context){
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 13.0,color: Colors.black45,spreadRadius: 16.0,offset: Offset(3.0,3.0))],
                  borderRadius: BorderRadius.all(Radius.circular(4.0))
                ),
                  width: 160,
                  height: 100,
                  child: Align(
                      child: Text('还未开发,敬请期待...',style: TextStyle(color: Colors.black),))),
            );
          });
         Overlay.of(context).insert(alert);

         //2s后自动消失,使用上下文对象的findAncestorStateOfType找到已经存在的overlay状态组件overlayState
         OverlayState state= context.findAncestorStateOfType<OverlayState>();

         Future.delayed(Duration(seconds: 1),(){
           alert.remove();
         });



        }

      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: ShapeDecoration(
          color: displayColor,
          shape:CircleBorder(),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(displayName),
        ),
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
    const a = 'animation动画';
    const b = 'state状态管理';
    return Container(
      color: Colors.white,
      child: GridView.count(
          padding: EdgeInsets.all(spacing),
          crossAxisCount: count,//设置横轴放置几个Grid
          mainAxisSpacing: spacing,//设置纵轴方向每个Grid上下间隔
          crossAxisSpacing: spacing,//设置横轴方向每个Grid上下间隔
          children: [
            GridViewItem(a, Colors.blue, routeMap:{'/animation':AnimationPage(a)}),
            GridViewItem(b, Colors.deepOrangeAccent, routeMap:{'/stateManager':StateManagerPage()}),
            GridViewItem('route路由', Colors.cyan),
            GridViewItem('overlay浮层', Colors.amber),
            GridViewItem('网络与http', Colors.black54),
            GridViewItem('待开发', Colors.black54),
          ],
      )
    );
  }
}

class FooterItemStateWidget extends StatefulWidget {
  final String displayName;
  final IconData iconData;
  bool initIsActive=false;
  Function tapCallback=()=>{};
  FooterItemStateWidget(this.displayName,this.iconData,this.initIsActive,{this.tapCallback});
  @override
  _FooterItemStateWidgetState createState() => _FooterItemStateWidgetState();
}

class _FooterItemStateWidgetState extends State<FooterItemStateWidget> {
  bool isActive;
  @override
  void initState() {
    super.initState();
    this.isActive=widget.initIsActive;
  }


  @override
  Widget build(BuildContext context) {
    Color unActiveColor=Colors.black12;
    Color activeColor=Colors.white;
    Color displayColor=isActive? activeColor:unActiveColor;
    return GestureDetector(
      onTap: (){
        setState(() {
          this.isActive=!this.isActive;
        });
        widget.tapCallback();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Icon(widget.iconData,color:displayColor ,)),
          Expanded(child: Text(widget.displayName,style: TextStyle(color:displayColor),))
        ],
      ),
    );;
  }
}







/*
* 自定义路由管理器，实例化一个Navigator
* */
class MyAppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings){
           //PageRouterBuilder是PageRoute抽象类的一个实现类，与MaterialPageRoute一样，返回Route类型
          //pageBuilder方法返回widget
           return PageRouteBuilder(
               transitionDuration: Duration(milliseconds: 800),
               pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
                return MyAppSafeArea();
           });
      },

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
    // MaterialApp();
    //从根节点就指定文字方向，这样,子的widget基本不需要再设置textDirection
    //创建MediaQuery data，因为使用SafeArea组件时，必须先在上下文中创建MediaQuery组件
    final mediaQueryData = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data:mediaQueryData,
          child: MyAppNavigator(),
        ));
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FooterItemStateWidget('核心概念', Icons.apps,true,tapCallback:(){
            print('22');
          }),
          FooterItemStateWidget('应用展示', Icons.apps,true,tapCallback:(){
            print('22');
          }),
        ],
      ),
    );
  }
}



void main(){
  runApp(new MyApp());
}