import 'dart:io';

void main() {
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()!;

  int? age;
  while (age == null) {
    stdout.write("Enter your age: ");
    String? input = stdin.readLineSync();
    try {
      age = int.parse(input!);
    } catch (e) {
      print("Invalid input! Please enter a valid number.");
    }
  }

  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return;
  }

  print("Welcome $name, you are eligible to register.");
}
