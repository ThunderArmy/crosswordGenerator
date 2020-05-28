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
      var empty = true;
      for (var i = xpos; i < xpos + word.length; i++) {
        if (elementAt(ypos)[i] != '0') {
          empty = false;
        }
      }
      if (empty) {
        for (var i = 0; i < word.length; i++) {
          elementAt(ypos)[xpos + i] = word[i];
        }
      }
      return empty;
    } else {
      //länge passt nicht
      //wenn sowieso besetzt -> return false (no success)
      var empty = true;
      if (xpos < elementAt(0).length) {
        for (var i = xpos; i < xpos + word.length; i++) {
          if (elementAt(ypos)[i] != '0') {
            empty = false;
          }
        }
      }
      if (!empty) {
        return false;
      }
      //nicht besetzt -> länge anpassen
      for (var list in this) {
        while (list.length < xpos + word.length) {
          list.add('0');
        }
      }
      for (var i = 0; i < word.length; i++) {
        elementAt(ypos)[xpos + i] = word[i];
      }
      return true;
    }
  }

  bool insertVertical(int ypos, int xpos, String word) {
    if (length < ypos + word.length) {
      //höhe nicht ausreichend -> neue listen einfügen
      while (length < ypos + word.length) {
        add(List<String>.filled(xpos + 1, '0'));
      }
    }

    if (xpos <= elementAt(0).length) {
      //länge passt
      //check if besetzt
      var empty = true;
      for (var i = 0; i < word.length; i++) {
        var list = elementAt(i + ypos);
        if (list[xpos] != '0') {
          empty = false;
        }
      }
      //wenn besetzt -> return false (no success)
      if (!empty) {
        return false;
      }
      //einfügen
      for (var i = 0; i < word.length; i++) {
        elementAt(i + ypos)[xpos] = word[i];
        ;
      }
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
    }
  }
}
