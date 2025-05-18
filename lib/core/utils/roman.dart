extension ToRoman on int {
  String get roman => _toRoman(this);
}

String _toRoman(int number) {
  if (number <= 0 || number > 3999) {
    return number.toString();
  }

  final List<String> romanNumerals = ['I', 'IV', 'V', 'IX', 'X', 'XL', 'L', 'XC', 'C', 'CD', 'D', 'CM', 'M'];
  final List<int> values = [1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000];

  String result = '';
  int i = values.length - 1;

  while (number > 0) {
    while (values[i] <= number) {
      number -= values[i];
      result += romanNumerals[i];
    }
    i--;
  }

  return result;
}
