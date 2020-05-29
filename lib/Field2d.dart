import 'dart:convert';
import 'dart:io';

extension Field2d on List<List<String>> {
  void outputWordField() {
    for (var list in this) {
      for (var c in list) {
        stdout.write(c.toString() + ' ');
      }
      stdout.writeln();
    }
  }

  bool insertHorizontal(int ypos, int xpos, String word) {
    if (length <= ypos) {
      //höhe nicht ausreichend -> neue listen einfügen
      while (length <= ypos) {
        add(<String>[]);
      }
    }

    if (xpos + word.length <= elementAt(0).length) {
      //länge passt
      for (var i = xpos; i < xpos + word.length; i++) {
        if (elementAt(ypos)[i] != '0') {
          return false;
        }
      }
      for (var i = 0; i < word.length; i++) {
        elementAt(ypos)[xpos + i] = word[i];
      }
      return true; //Erfolgreich eingefügt
    } else {
      //länge passt nicht
      //wenn sowieso besetzt -> return false (no success)

      try {
        for (var i = xpos; i < elementAt(0).length; i++) {
          if (elementAt(ypos)[i] != '0') {
            return false; //Wort besetzt Platz. Neues Wort kann nicht eingefügt werden.
          }
        }
      } catch (e) {
        print('X: ' + xpos.toString());
        print('Y: ' + ypos.toString());
        print('Word: ' + word);
        throw e;
      }
      //nicht besetzt -> länge anpassen
      for (var list in this) {
        while (list.length < xpos + word.length) {
          //Bug Anfällig evt. <= statt <
          list.add('0');
        }
      }
      //Wort einfügen
      for (var i = 0; i < word.length; i++) {
        elementAt(ypos)[xpos + i] = word[i];
      }
      return true; //Wort wurde eingefügt
    }
  }

  bool insertVertical(int ypos, int xpos, String word) {
    if (length < ypos + word.length) {
      //höhe nicht ausreichend -> neue listen einfügen
      var adjustTo;
      if (length > 0) {
        adjustTo =
            elementAt(0).length > xpos + 1 ? elementAt(0).length : xpos + 1;
      } else {
        adjustTo = xpos + 1;
      }
      while (length < ypos + word.length) {
        add(List<String>.filled(adjustTo, '0', growable: true));
      }
    }

    if (xpos < elementAt(0).length) {
      //länge passt
      //check if besetzt
      for (var i = 0; i < word.length; i++) {
        var list = elementAt(i + ypos);
        if (list[xpos] != '0') {
          return false; //bestzt => return false
        }
      }
      //einfügen
      for (var i = 0; i < word.length; i++) {
        elementAt(i + ypos)[xpos] = word[i];
      }
      return true;
    } else {
      //länge passt nicht
      //länge anpassen
      for (var list in this) {
        while (list.length <= xpos) {
          list.add('0');
        }
      }
      //einfügen
      for (var i = 0; i < word.length; i++) {
        elementAt(i + ypos)[xpos] = word[i];
        ;
      }
      return true;
    }
  }
}
