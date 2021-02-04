

abstract class RenderObject{

  paint();

}

//define widget,widget which is a configuration to Element
abstract class Widget {

  Widget({this.key});

  final String key;

  //define a approach to createElement,subclass should overRide
  Element createElement();

}




abstract class BuildContext{

  Widget get widget;

  //RenderObject get renderObject;

}


//define Element and implements BuildContext
abstract class Element implements BuildContext{

  Element(widget):assert(widget!=null){
    this._widget=widget;
    print('element created,and widget is $_widget');
}

  @override
  // TODO: implement widget
  Widget get widget => _widget;
  Widget _widget;

  void mount(Element parentElement,dynamic slot);

}

//composition element
abstract class ComponentElement extends Element{
  ComponentElement(Widget widget) : super(widget);

  //组合式Element，抽象一个build方法
  Widget build();
  
}

//define a StatelessWidget,developer can extends this class,and overRide build method
abstract class StatelessWidget extends Widget{
  StatelessWidget({key}):super(key: key);

  //create statelessElement;
  @override
  Element createElement() {
    // TODO: implement createElement
    return StatelessElement(this);
  }

  //need to be override by subclass
  Widget build(BuildContext context);

}

class StatelessElement extends ComponentElement{

  StatelessElement(StatelessWidget widget) : super(widget);

  @override
  Widget build() =>( widget as StatelessWidget).build(this);

  @override
  void mount(Element parentElement, slot) {
    // TODO: implement mount
  }

}

//render element
class RenderObjectElement extends Element{

  RenderObjectElement(RenderObjectWidget widget) : super(widget);

  RenderObject get renderObject=>_renderObject;
  RenderObject _renderObject;

  RenderObjectWidget get widget =>( widget as RenderObjectWidget);

  @override
  void mount(Element parentElement, slot) {
    // TODO: implement mount
    _renderObject = widget.createRenderObject();

  }



}


abstract class RenderObjectWidget extends Widget{
  RenderObjectWidget({key}):super(key: key);

  @override
  Element createElement() {
    // TODO: implement createElement
    return RenderObjectElement(this);
  }

  RenderObject createRenderObject();
}


class TextRenderObject extends RenderObject{
  @override
  paint() {
    // TODO: implement paint
    print('2');
  }
}
class Text extends RenderObjectWidget{
  @override
  RenderObject createRenderObject() {
    return TextRenderObject();
  }

}


runApp(Widget widget){
  Element element = widget.createElement();
  if(element is ComponentElement){

  }
  if(element is RenderObjectElement){

  }
  // element.
}

void main() {

}
