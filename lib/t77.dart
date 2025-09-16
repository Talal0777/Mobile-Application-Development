import 'dart:io';

void main() {
  stdout.write("How many numbers do you want to enter? ");
  int n = int.parse(stdin.readLineSync()!);

  List<int> numbers = [];

  for (int i = 0; i < n; i++) {
    int? num;
    while (num == null) {
      stdout.write("Enter number ${i + 1}: ");
      String? input = stdin.readLineSync();
      try {
        num = int.parse(input!);
      } catch (e) {
        print("Invalid input! Please enter a valid integer.");
      }
    }
    numbers.add(num);
  }

  print("You entered: $numbers");
}
