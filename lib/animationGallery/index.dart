/*
* this section intend to learn and introduce the animation of flutter
* including the concept of animation,the principle of animation ...
* on the blow,i will demonstrates some examples;
* you can find more explained about flutter animation through the blow link
* https://medium.com/flutter/animation-deep-dive-39d3ffea111f
* */



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

TextStyle getTitleStyle(){
  return TextStyle(color: Colors.black,fontSize: 18.0);
}

TextStyle getButtonStyle(){
  return TextStyle(color: Colors.deepPurpleAccent,fontSize: 18.0);
}

Widget getDivider(){
  return Container(
    margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
    decoration: ShapeDecoration(shape:Border(bottom: BorderSide(width: 1.0,color: Colors.black45)) ),
  );
}

typedef PanelContentBuilder=Widget Function(BuildContext context);
//自定义折叠面板
class Panel extends StatefulWidget {
  final String title;
  final PanelContentBuilder buildContent;
  Panel(this.title,this.buildContent);
  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  bool isExpand=true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(widget.title,style: getTitleStyle(),)),
              GestureDetector(
                onTap: (){
                  setState(() {
                    this.isExpand=!isExpand;
                  });
                },
                child: Icon(isExpand? Icons.arrow_upward:Icons.arrow_downward,color: Colors.black,),
              )
            ],
          ),
          isExpand? widget.buildContent(context):Container(),
        ],
      ),
    );
  }
}

//demonstrate Ticker
class TickerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return    Panel('ticker是实现动画的关键，flutter会在每一帧都调用ticker的方法,\r\n new Ticker((elapsed) => print(DateTime.now())),\r\n ticker.start()开始', (context){
      Widget container=Container(

          child:GestureDetector(
            child: Text('点我查看控制台',style: getButtonStyle()),
            onTap: (){
              var ticker = Ticker((elapsed) => print(DateTime.now()));
              ticker.start();
              Future.delayed(Duration(seconds: 3),(){
                ticker.dispose();
              });
            },
          )
      );
      return container;
    });
  }
}

class AnimationControllerPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AnimationControllerWidget animationControllerWidget = AnimationControllerWidget();
    const t='AnimationController类实现动画 \r\n\r\n';
    return Panel(t, (context){
      return Container(

        height: 45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            animationControllerWidget,
            GestureDetector(
              onTap: (){
                _AnimationControllerWidgetState myState= animationControllerWidget.myState;
                myState.start();
              },
              child: Text('点我查看效果',style: getButtonStyle(),),
            ),

          ],
        ),
      );
    });
  }
}


//AnimationController demo,
class AnimationControllerWidget extends StatefulWidget {

  _AnimationControllerWidgetState myState;

  @override
  _AnimationControllerWidgetState createState(){
    myState = _AnimationControllerWidgetState();
    return myState;
  }
}

class _AnimationControllerWidgetState extends State<AnimationControllerWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var i=0;
  int times=0;
  var status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=AnimationController(vsync: this,duration: Duration(seconds: 1));
    _controller.addListener(_update);

  }

  void start(){
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _update(){
    setState(() {
      i = (_controller.value * 299792458).round();
      times++;
      status=_controller.status;
      print(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('times:$times,status:$status',style: TextStyle(color: Colors.black),);
  }
}


//demonstrates built-in implicitly animated widgets,such as AnimatedContainer/AnimatedPositioned....
//implicitly animated widgets is automatically animate changes to their property.
class AnimatedContainerWidgetDemo extends StatefulWidget {
  @override
  _AnimatedContainerWidgetDemoState createState() => _AnimatedContainerWidgetDemoState();
}

class _AnimatedContainerWidgetDemoState extends State<AnimatedContainerWidgetDemo> {
  double width=100.0;
   double height = 100.0;
   Color color = Colors.deepPurpleAccent;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('implicitly AnimatedContainer 演示',style: getTitleStyle()),
        AnimatedContainer(
          width: this.width,
          height: this.height,
          color: this.color,
          duration: Duration(seconds: 2),
          child: Text('啊哈哈哈',style: TextStyle(fontSize: 20.0),),
          curve: Curves.bounceInOut,
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              if(this.width <100){
                this.width=100.0;
                this.height=100.0;
                this.color=Colors.deepPurpleAccent;
              }else{
                this.width=50.0;
                this.height=50.0;
                this.color=Colors.deepOrange;
              }
            });
          },
          child: Text("点我查看效果",style: getButtonStyle()),
        )
      ],
    );
  }
}

//使用内置的隐式动画AnimateDefaultTextStyle改变字体
class AnimatedDefaultTextStyleDemo extends StatefulWidget {
  @override
  _AnimatedDefaultTextStyleDemoState createState() => _AnimatedDefaultTextStyleDemoState();
}

class _AnimatedDefaultTextStyleDemoState extends State<AnimatedDefaultTextStyleDemo> {
  Color color;
  double fontSize;
  Color backgroundColor;
  FontWeight fontWeight;
  double letterSpacing;
  double height;
  FontStyle fontStyle;
  int clickTimes=0;
  _AnimatedDefaultTextStyleDemoState(){
    this.setInitState();
  }
  setInitState(){
    color=Colors.yellow;
    fontStyle=FontStyle.normal;
    fontSize=16.0;
    fontWeight=FontWeight.normal;
    letterSpacing=15.0;
    height=1.0;
  }
  
  setAnimatedState(){
    color=Colors.redAccent;
    fontStyle=FontStyle.italic;
    fontSize=23.0;
    fontWeight=FontWeight.bold;
    letterSpacing=20.0;
    height=6.0;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('implicitly AnimatedDefaultTextStyle 演示',style: getTitleStyle(),),
        AnimatedDefaultTextStyle(child: Text('我是演示的文字'), style: TextStyle(
          color: color,fontSize: fontSize,fontWeight: fontWeight,backgroundColor: backgroundColor,
          letterSpacing: letterSpacing,height: height,fontStyle: fontStyle
        ), duration: Duration(seconds: 3)),
        GestureDetector(
          onTap: (){
            setState(() {

              if(clickTimes.isEven){
                setAnimatedState();
              }else{
                setInitState();
              }
              clickTimes++;

            });
          },
          child: Text('点我查看效果',style: getButtonStyle(),),
        )
      ],
    );
  }
}

class AnimatedAlignDemo extends StatefulWidget {
  @override
  _AnimatedAlignDemoState createState() => _AnimatedAlignDemoState();
}

class _AnimatedAlignDemoState extends State<AnimatedAlignDemo> {

  Alignment _alignment = Alignment.topLeft;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    timer= Timer(Duration(seconds: 5), (){
       setState(() {
         _alignment = Alignment.bottomRight;
       });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('implicitly animationAlign',style: getTitleStyle(),),
        AnimatedAlign(
          curve: Curves.easeInCirc,
            alignment: _alignment,
            duration:Duration(seconds: 5),
            child:Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue
              ),
            )
        )
      ],
    );
  }
}


//使用TweenAnimationBuilder自定义隐式动画
class TweenAnimationBuilderDemo extends StatefulWidget {
  @override
  _TweenAnimationBuilderDemoState createState() => _TweenAnimationBuilderDemoState();
}

class _TweenAnimationBuilderDemoState extends State<TweenAnimationBuilderDemo> {

  double endRotateDegree=2.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('custom implicitly TweenAnimationBuilder',style: getTitleStyle(),),
        TweenAnimationBuilder(
            tween: Tween<double>(begin: 0,end: endRotateDegree),
            duration: Duration(seconds: 4),
            child: Text('121212'),
            builder: (BuildContext context,double currentDegree,Widget child){
            //  print(currentDegree);
              return Container(
                height: 120,
                width: 120,
                color: Colors.deepOrange,
                transform: Matrix4.rotationZ(currentDegree),
                child: child,
              );
            }),
        GestureDetector(
          onTap: (){
            setState(() {
              endRotateDegree=endRotateDegree*2;
            });
          },
          child: Text('点我查看效果',style: getButtonStyle(),),
        )
      ],
    );
  }
}

// all built-in explicit animation widget
// here is a example of  built-in explicit animation widget RotationTransition
class RotationTransitionDemo extends StatefulWidget {
  @override
  _RotationTransitionDemoState createState() => _RotationTransitionDemoState();
}



class _RotationTransitionDemoState extends State<RotationTransitionDemo> with SingleTickerProviderStateMixin{
  AnimationController animationController;

  String buttonText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buttonText = animationController.isAnimating? '停止动画':'开始动画';
    return Column(
      children: [
        Text('explicit animation widget RotationTransition',style: getTitleStyle(),),
        RotationTransition(
          turns:animationController ,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                shape: BoxShape.circle,
                image: DecorationImage(fit:BoxFit.cover,image:NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=36820115,2771778167&fm=26&gp=0.jpg')),
                border: Border.all(color: Colors.deepOrange,width: 3.0)),
          ),
        ),
        GestureDetector(
          onTap: (){
            setState(() {
               if(animationController.isAnimating){
                  animationController.stop();
               }else{
                 animationController.forward();
               }
            });
          },
          child: Text(buttonText,style: getButtonStyle(),),
        )
      ],
    );
  }
}


//slideTransition demo
class SlideTransitionDemo extends StatefulWidget {
  @override
  _SlideTransitionDemoState createState() => _SlideTransitionDemoState();
}

class _SlideTransitionDemoState extends State<SlideTransitionDemo> with SingleTickerProviderStateMixin {

  AnimationController animationController;

  Animation<Offset> animationOffset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this
    );
    animationOffset = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1, 0.0),
    ).animate(animationController);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double value=animationController.value;
    return Column(
      children: [
        Text('explicit animation widget SlideTransition',style: getTitleStyle(),),
        Row(
          children: [
            Container(
              width:150,
              height: 150,
              child: SlideTransition(
                position: animationOffset,
                child:Image(image: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=36820115,2771778167&fm=26&gp=0.jpg')) ,
              ),
            ),
            Text('not affect surrounding widget',style: getTitleStyle(),)
          ],
        ),
        GestureDetector(
          onTap: (){
            print(animationController.status);
            if(animationController.isAnimating){
               animationController.stop();
            }else{
              if(animationController.isCompleted){
                 animationController.repeat();
              }else{
                animationController.forward();
              }
            }
          },
          child: Text('停止或开始',style: getButtonStyle(),),
        )
      ],
    );
  }
}


//AnimatedBuilder demo

class AnimatedBuilderDemo extends StatefulWidget {
  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo> with SingleTickerProviderStateMixin{

  AnimationController animationController;

  GlobalKey key;
   Image background;
   Image ufo;

  double left=0;
  double top=0;
  double maxLeft;
  double maxTop;
  double minLeft=0;
  double minTop=0;

  _AnimatedBuilderDemoState(){

     key = GlobalKey();

      background = Image.network("https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1392743188,3286909636&fm=26&gp=0.jpg",key: key,);

      ufo = Image.network("https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3568298155,2885610828&fm=26&gp=0.jpg",width: 80.0,height: 80.0,);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          background,
          AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context,Widget child){
                 final backgroundRenderObject = key.currentContext.findRenderObject() as RenderBox;
                 if(backgroundRenderObject.hasSize){
                   final constraints=backgroundRenderObject.constraints;
                   var constraintsToString=constraints.toString();
                   final paintBounds=backgroundRenderObject.paintBounds;
                   var paintBoundsToString=paintBounds.toString();
                   final size = backgroundRenderObject.size;
                   var sizeToString=size.toString();
                  // print('constraints:$constraintsToString,paintBounds:$paintBoundsToString,size:$sizeToString');
                   maxLeft = size.width - 80.0;
                   maxTop = size.height - 80.0;
                   if(left == minLeft && top == minTop){
                //      print('准备右移');
                      left++;
                   }
                   if(left<maxLeft && top ==minTop){
                //      print('正在右移');
                      left++;
                   }
                   if(left==maxLeft && top ==minTop){
                 //    print('准备下移');
                     top++;
                   }
                   if(left==maxLeft && top < maxTop){
                //     print('正在下移');
                     top++;
                   }
                   if(left==maxLeft && top == maxTop){
                //     print('准备左移');
                     left--;
                   }
                   if(left<maxLeft && top == maxTop){
                 //    print('正在左移');
                     left--;
                   }
                   if(left==minLeft && top == maxTop){
                 //    print('准备上移');
                     top--;
                   }
                   if(left==minLeft && top < maxTop){
                 //    print('正在上移');
                     top--;
                   }
                 }
                 return Positioned(
                     left: left,
                     top:top,
                     child: ufo
                 );
          })
        ],
      ),
    );
  }
}


class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: Image.asset("assets/animation-widget-from-easy-hard.png"),
          ),
          getDivider(),
          TickerPanel(),
          getDivider(),
          AnimationControllerPanel(),
          getDivider(),
          AnimatedContainerWidgetDemo(),
          getDivider(),
          AnimatedDefaultTextStyleDemo(),
          getDivider(),
          AnimatedAlignDemo(),
          getDivider(),
          TweenAnimationBuilderDemo(),
          getDivider(),
          RotationTransitionDemo(),
          getDivider(),
          SlideTransitionDemo(),
          getDivider(),
          AnimatedBuilderDemo(),
          getDivider(),

        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  _Header(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        color:Colors.deepPurpleAccent,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.keyboard_arrow_left,color: Colors.white,size: 24.0,),
              ),
            ),
            Center(
              child: Text(title),
            ),
          ],
        )
    );
  }
}

//create a page widget
class AnimationPage extends StatelessWidget {
  final String title;
  AnimationPage(this.title);
  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return MediaQuery(data: data, child:
          SafeArea(
              child: Container(
                child: Column(
                  children: [
                    _Header(title),
                    Expanded(child: _Body())
                  ],
                ),
              )
          )
    );
  }
}
