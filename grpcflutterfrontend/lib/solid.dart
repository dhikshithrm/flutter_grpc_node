class Vehicle {
  
  final String color;
  final String definition = 'Vehicle';
  
  void horon(){
    print("i am vehicle");
  }

  Vehicle(this.color);
}

class Car implements Vehicle {
  Car(this.carColor);

  final String carColor;

  @override
  String get color => carColor;

  @override
  String get definition => '$carColor car';

  @override
  void horon() {
     throw UnimplementedError();
  }
}

main() {
  final car = Car('red');
  print('Result: definition: ${car.definition}');
  // Output -> Result: definition: red car
  print('Result: is Vehicle type: ${car is Vehicle}');
  // Output -> is Vehicle type: true
}
class Hatch extends Car {
  Hatch(String color) : super(color);
}

