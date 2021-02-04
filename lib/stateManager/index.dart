/*
* this section includes two part to intend to learn and introduce State Manager
* i will use built-in widget named InheritedWidget to demonstrate how to inherited global state in part 1
* and in part 2,i will use third-party library Provider to demonstrate global state
* */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_startup/commonWidget.dart';

//entry
class StateManagerPage extends CommonSkeleton{

  StateManagerPage():super(title:'state状态管理',bodyBuilder:(BuildContext context){
     return ListView.separated(
         itemBuilder: (BuildContext context,int index){
             if(index == 0){
               return InheritedWidgetDemo();
             }
             if(index == 1){
                return ProviderLibraryDemo();
             }
             return Container();
         },
         separatorBuilder: (BuildContext context,int index)=>Divider(height: 2,color: Colors.black,),
         itemCount: 3
     );
  });
}

//part 1

//define a widget extends InheritedWidget
//
class _MyInheritedWidget extends InheritedWidget{

 _MyInheritedWidget({Key key,@required this.color, Widget child}):assert(color !=null ),super(key: key,child: child);

 final Color color;

 static _MyInheritedWidget of(BuildContext context){
   return context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>();
 }

@override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
   return true;
  }

}

//define a widget,use _MyInheritedWidget's color
class InheritedWidgetDemo extends StatefulWidget {
  @override
  _InheritedWidgetDemoState createState() => _InheritedWidgetDemoState();
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  Color color = Colors.deepPurpleAccent;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(color: color,
      child: CommonCard(title: 'InheritedWidget Demo',contextBuilder: (BuildContext innerContext){
          return Column(
            children: [
              Text(' _MyInheritedWidget.color,value=${_MyInheritedWidget.of(innerContext).color.toString()},count=${count}',style: TextStyle(color: _MyInheritedWidget.of(innerContext).color),),
              CommonButton(backgroundColor: Colors.deepPurpleAccent,textColor: Colors.white,text: '改变颜色',onTap: (){
                setState(() {
                  count++;
                  color = color.withBlue(count);
                  print(color.toString());
                });
              },)
            ],
          );
    },),
    );

  }
}


//part 2
class ProviderLibraryDemo extends StatefulWidget {
  @override
  _ProviderLibraryDemoState createState() => _ProviderLibraryDemoState();
}

class _ProviderLibraryDemoState extends State<ProviderLibraryDemo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget getTitle(String text){
  return Text(text,style: TextStyle(color: Colors.black,fontSize: 16.0),);
}