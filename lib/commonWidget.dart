
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class CommonButton extends StatelessWidget{

  Color backgroundColor = Color.fromRGBO(255, 255, 255, 1);
  Color textColor =Color.fromARGB(0, 0, 0, 0);
  String text;
  GestureTapCallback onTap;

  CommonButton({this.backgroundColor,this.textColor,this.text,this.onTap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Builder(builder: (BuildContext context){
       return ConstrainedBox(
         constraints: BoxConstraints(),
         child:GestureDetector(
               onTap: onTap,
               child: Container(
                 padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                 color: backgroundColor,
                 child: Text(text,style: TextStyle(color: textColor),),
               ),
         ));
    });
  }

}

class CommonCard extends StatelessWidget {
  final String title;
  final Widget Function(BuildContext context) contextBuilder;
  CommonCard({this.title,this.contextBuilder});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius:5.0,color: Colors.black45,offset: Offset(0.0,5.0))],
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(color: Colors.black45),
      ),
      child: Column(
        children: [
          ConstrainedBox(constraints:BoxConstraints(minHeight: 30.0),child: Text(title,style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold),)),
          Padding(padding: EdgeInsets.all(10.0),child: contextBuilder(context),)
        ],
      ),
    );
  }
}


class CommonSkeleton extends StatelessWidget {
  final String title;
  final WidgetBuilder bodyBuilder;
  CommonSkeleton({this.title,this.bodyBuilder});
  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return MediaQuery(
      data: data,
      child: SafeArea(
          child:Container(
            child: Column(
              children: [
                _Header(title),
                Expanded(child: _Body(bodyBuilder))
              ],
            )
          )

      )
    );
  }
}

typedef WidgetBuilder =  Widget Function(BuildContext context);

class _Body extends StatelessWidget {
  final WidgetBuilder builder;
  _Body(this.builder);
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: builder(context),
    );
  }
}

class _Header extends StatefulWidget {
  final String title;
  _Header(this.title);
  @override
  __HeaderState createState() => __HeaderState();
}

class __HeaderState extends State<_Header> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    );
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

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
              child: ScaleTransition(
                scale: animationController,
                child: Text(widget.title),
              )
            ),
          ],
        )
    );
  }
}


