import 'dart:io';

extension Field2d on List<List<String>> {
  void outputWordField() {
    for (var list in this) {
      for (var c in list) {
        stdout.write(c.toString() + ' ');
      }
      print('');
    }
  }

  bool insertHorizontal(int ypos, int xpos, String word) {
    if (length <= ypos) {
      //höhe nicht ausreichend -> neue listen einfügen
      while (length <= ypos) {
        add(<String>[]);
      }
    }

    //länge passt
    if (xpos + word.length <= elementAt(0).length) {
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
      //wenn sowieso besetzt -> return false
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
}
