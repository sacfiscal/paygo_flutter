bool isValidEan(String code) {
  if (code == "SEM GTIN") {
    return true;
  }

  if (code.length != 8 && code.length != 13) {
    return false;
  }

  var sum = 0;
  var multiplier = 3;
  var digits = code.split("").map(int.parse).toList();

  for (var i = digits.length - 2; i >= 0; i--) {
    sum += digits[i] * multiplier;
    multiplier = 4 - multiplier; // alternates between 3 and 1
  }

  var checkDigit = (10 - (sum % 10)) % 10;

  return checkDigit == digits.last;
}
