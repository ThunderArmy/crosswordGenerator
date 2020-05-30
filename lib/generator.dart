import 'dart:io';
import 'dart:math';
import 'package:buchstabenTest/Field2d.dart';

class Generator {
  List<String> _wordlist = <String>[];
  static final _random = Random();
  final List<List<String>> _wordfield = <List<String>>[];
  static const DIRECTIONS = 2;
  var length;
  static const LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  Generator(String path) {
    final file = File(path);
    _wordlist = file.readAsLinesSync().map((e) => e.toUpperCase()).toList();
    print('count: ' + _wordlist.length.toString());
  }

  String _getRandomLetter() {
    return LETTERS[_random.nextInt(LETTERS.length)];
  }

  void replaceZeros() {
    for (var i = 0; i < _wordfield.length; i++) {
      var list = _wordfield[i];
      for (var j = 0; j < list.length; j++) {
        if (list[j] == '0') {
          list[j] = _getRandomLetter();
        }
      }
    }
  }

  List<List<String>> generate() {
    if (_wordlist.isEmpty) {
      return null;
    }

    var xpos = _random.nextInt(4);
    var ypos = _random.nextInt(4);
    //insert into word field
    var reversed = _random.nextBool();
    var horizontal = _random.nextBool();

    _wordfield.add(List.generate(xpos + 1, (index) => '0'));
    /*word.split('').forEach((element) {
      _wordfield[0].add(element);
    });*/
    //outputWordField();
    var success = true;
    var word;
    while (_wordlist.isNotEmpty) {
      if (success) {
        word = _getRandomWordFromList();
      }
      reversed = _random.nextBool();
      horizontal = _random.nextBool();
      if (reversed) {
        word = word.split('').reversed.join();
      }
      /*stdout.write('xpos: ' +
          xpos.toString() +
          ', ypos: ' +
          ypos.toString() +
          ', horizontal: ' +
          horizontal.toString() +
          ', word: ' +
          word);
      */
      if (horizontal) {
        success = _wordfield.insertHorizontal(ypos, xpos, word);
      } else {
        success = _wordfield.insertVertical(ypos, xpos, word);
      }
      xpos = xpos + _random.nextInt(5) * (_random.nextBool() ? 1 : -1);
      xpos = xpos.abs();
      ypos = ypos + _random.nextInt(5) * (_random.nextBool() ? 1 : -1);
      ypos = ypos.abs();
      /*if (success) {
        word = _getRandomWordFromList();
      }*/
      //stdout.writeln(', success: ' + success.toString());
      //outputWordField();
    }

    outputWordField();

    return _wordfield;
  }

  void outputWordField() {
    for (var list in _wordfield) {
      for (var c in list) {
        stdout.write(c.toString() + ' ');
      }
      stdout.writeln();
    }
    stdout.writeln();
  }

  String _getRandomWordFromList() {
    final word = _wordlist[_random.nextInt(_wordlist.length)];
    _wordlist.remove(word);
    print(word);
    return word;
  }
}
