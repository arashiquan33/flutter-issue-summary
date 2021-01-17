import 'dart:math';

abstract class Shape{
  num get area;
  factory Shape(type){
    if (type == 'circle') return Circle(2);
    if (type == 'square') return Square(2);
    throw 'Can\'t create $type.';
  }

}

class Square implements Shape{
  final num sideSize;
  Square(this.sideSize);

  @override
  // TODO: implement area
  num get area => pow(this.sideSize,2);

}

class Circle implements Shape{

  final num radius;

  Circle(this.radius);

  @override
  // TODO: implement area
  num get area{
    return pi * pow(radius, 2);
  }

}

class Rectangle{
  var width;

  var height;

  var origin;

  Rectangle({this.origin=const [0,0],this.width=0,this.height=0});

  @override
  String toString() {
    return 'Rectangle{width: $width, height: $height, origin: $origin}';
  }
}


class Bicycle {
  int cadence;
  int _speed=0;

  int get speed => _speed;
  int gear;
  Bicycle(this.cadence, this.gear);
  @override
  String toString() {
    // TODO: implement toString
    return 'Bicycle:${this._speed} mph';
  }
}

void main() {
  var bike = new Bicycle(2,  1);
  print(bike);
  print(Rectangle(origin: [2,2], width: 100, height: 200));
  print(Rectangle(width: 200));
  print(Rectangle());
}
