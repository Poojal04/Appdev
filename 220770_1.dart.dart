import 'dart:io';

void main() {
  String? sentence = stdin.readLineSync();
  int length = 0, wordCount = 0, sentenceCount = 0, article = 0;
  List<String> words = [];

  if (sentence != null) {
    List<String> sentences = sentence.split(RegExp(r'[.!?]'));
    sentenceCount = sentences.length;

    length = sentence.length;
    words = sentence.split(RegExp(r'\W+')); 

    for (String word in words) {
      String cleanedWord = word.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
      if (cleanedWord == 'a' || cleanedWord == 'an' || cleanedWord == 'the') {
        article++;
      }
    }

    wordCount = words.length;
  }

  print('Characters: $length');
  print('Words: $wordCount');
  print('Sentences: $sentenceCount');
  print('Articles: $article');
}
