import 'dart:io';
import 'dart:math';
import 'package:buchstabenTest/Field2d.dart';

class Generator {
  List<String> _wordlist = <String>[];
  final _random = Random();
  final List<List<String>> _wordfield = <List<String>>[];
  static const DIRECTIONS = 2;
  var length;

  Generator(String path) {
    final file = File(path);
    _wordlist = file.readAsLinesSync().toList();

    print('count: ' + _wordlist.length.toString());
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
      */if (horizontal) {
        success = _wordfield.insertHorizontal(ypos, xpos, word);
      } else {
        success = _wordfield.insertVertical(ypos, xpos, word);
      }
      xpos = xpos + _random.nextInt(5);
      ypos = ypos + _random.nextInt(5);
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
