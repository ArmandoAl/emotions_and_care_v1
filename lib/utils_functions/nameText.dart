// ignore_for_file: file_names

String textToUpperCateFirstLetter(String text) {
  if (text.isEmpty) return '';
  return text[0].toUpperCase() + text.substring(1);
}
