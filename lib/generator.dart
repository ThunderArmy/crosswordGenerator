import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
    var word = _getRandomWordFromList();

    var xpos = _random.nextInt(4);
    var ypos = _random.nextInt(4);
    //insert into word field
    var reversed = _random.nextBool();
    var horizontal = _random.nextBool();

    _wordfield.add(List.generate(xpos, (index) => '0'));
    /*word.split('').forEach((element) {
      _wordfield[0].add(element);
    });*/
    outputWordField();
    while (_wordlist.isNotEmpty) {
      reversed = _random.nextBool();
      horizontal = _random.nextBool();
      if (reversed) {
        word = word.split('').reversed.join();
      }
      if (horizontal) {
        //region horizontal
        if (_wordfield.length < ypos) {
          for (var i = _wordfield.length; i <= ypos; i++) {
            _wordfield.add(List.generate(xpos + word.length, (index) => '0'));
          }
        }
        if (_wordfield[ypos].length >= word.length + xpos) {
          //region größepasst
          var empty = true;
          for (var i = xpos; i < xpos + word.length; i++) {
            //check if there is place to insert new word
            if (_wordfield[ypos][i] != '0') {
              empty = false;
              break;
            }
          }
          if (empty) {
            //there is place; insert word
            for (var i = 0; i < word.length; i++) {
              _wordfield[ypos][i + xpos] = word[i];
            }
          } else {
            //felder sind besetzt
            continue;
          }
        }
        //endregion größepasst
        else {
          //region passtnicht
          //länge anpassen
          for (var i = 0; i < _wordfield.length; i++) {
            var list = _wordfield[i];
            for (var j = list.length; j < xpos + word.length; j++) {
              list[j] = '0';
            }
          }
          //wort einfügen
          for (var i = 0; i < word.length - 1; i++) {
            _wordfield[ypos][i + xpos] = word[i];
          }

          //endregion passtnicht
        }
        //endregion horizontal
      } else {
        //region vertikal
        if (_wordfield.length >= word.length + ypos) {
          //hoehepasst
          var empty = true;
          for (var i in _wordfield) {
            //check if there is place to insert new word
            if (i[xpos] != '0') {
              empty = false;
              break;
            }
          }
          if (empty) {
            //wort einfügen
            for (var i = 0; i < word.length; i++) {
              _wordfield[i + ypos][xpos] = word[i];
            }
          } else {
            //bereits befüllt
            continue;
          }
        } else {
          //höhe passt nicht
          while (_wordfield.length < ypos + word.length) {
            if (_wordfield.isEmpty) {
              _wordfield.add(List.generate(word.length, (index) => '0'));
            } else {
              _wordfield
                  .add(List.generate(_wordfield[0].length, (index) => '0'));
            }
          }
          //höhe angepasst; wort einfügen
          for (var i = 0; i < word.length; i++) {
            _wordfield[i + ypos][xpos] = word[i];
          }
        }
        //endregion vertikal
      }

      xpos = xpos + _random.nextInt(5);
      ypos = ypos + _random.nextInt(5);
      word = _getRandomWordFromList();
      outputWordField();
    }

    outputWordField();

    return _wordfield;
  }

  void outputWordField() {
    for (var list in _wordfield) {
      for (var c in list) {
        stdout.write(c.toString() + ' ');
      }
      print('');
    }
  }

  String _getRandomWordFromList() {
    final word = _wordlist[_random.nextInt(_wordlist.length)];
    _wordlist.remove(word);
    return word;
  }
}
