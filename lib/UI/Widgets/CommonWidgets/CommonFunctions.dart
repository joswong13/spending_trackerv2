String upperCaseFirstLetter(String s) {
  String newString;

  try {
    if (s.length > 1) {
      newString = s[0].toUpperCase() + s.substring(1);
    } else if (s.length == 1) {
      newString = s[0].toUpperCase();
    }
  } catch (e) {
    return "Format Error";
  }

  return newString;
}
