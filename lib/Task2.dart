import 'dart:io';

void main() {

  stdout.write('Please enter your name: ');
  String name = stdin.readLineSync()!;

  stdout.write('Please enter your age: ');
  int age = int.parse(stdin.readLineSync()!);


  if (age < 18) {
    print('Sorry $name, you are not eligible to register.');
  } else {

    stdout.write('How many numbers would you like to enter? ');
    int count = int.parse(stdin.readLineSync()!);


    List<int> numbers = [];
    for (int i = 0; i < count; i++) {
      stdout.write('Enter number ${i + 1}: ');
      int number = int.parse(stdin.readLineSync()!);
      numbers.add(number);
    }


    int sumOfEvens = 0;
    int sumOfOdds = 0;
    int largestNumber = numbers[0];
    int smallestNumber = numbers[0];

    for (int number in numbers) {
      if (number % 2 == 0) {
        sumOfEvens += number;
      } else {
        sumOfOdds += number;
      }
      if (number > largestNumber) {
        largestNumber = number;
      }
      if (number < smallestNumber) {
        smallestNumber = number;
      }
    }


    print('\n--- Results ---');
    print('Numbers entered: $numbers');
    print('Sum of even numbers: $sumOfEvens');
    print('Sum of odd numbers: $sumOfOdds');
    print('Largest number: $largestNumber');
    print('Smallest number: $smallestNumber');
    print('---------------');
  }
}