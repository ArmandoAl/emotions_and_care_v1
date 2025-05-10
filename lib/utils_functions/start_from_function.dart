String startFrom(String text, String start) {
  //start from the index, id the text is hola (mundo) and the start is (, it will return (mundo)
  final startIndex = text.indexOf(start);
  return text.substring(startIndex);
}
