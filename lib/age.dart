import 'dart:io';


void main() {
  //runApp(const MyApp());

  // Step 1: Take input for name and age
  print("Enter your name: ");
  String name = stdin.readLineSync()!;

  print("Enter your age: ");
  int age = int.parse(stdin.readLineSync()!);

  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return; // stop execution
  }
}