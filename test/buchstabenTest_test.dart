import 'package:buchstabenTest/Field2d.dart';
import 'package:test/test.dart';

void main() {
  test('insert horizontal', () {
    var list = <List<String>>[];
    list.insertHorizontal(2, 3, 'Test');
    expect(list, {
      {
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
      },
      {
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
      },
      {'0', '0', '0', 'T', 'e', 's', 't'}
    });
    list.outputWordField();
  });

  test('insert vertical', () {
    var list = <List<String>>[];
    list.insertVertical(1, 2, 'Vert');
    expect(list, {
      {'0', '0', '0'},
      {'0', '0', 'V'},
      {'0', '0', 'e'},
      {'0', '0', 'r'},
      {'0', '0', 't'}
    });
    list.outputWordField();
  });
  test('vertically overwriting existing list should fail', () {
    var list = <List<String>>[];
    list.insertVertical(1, 2, 'Vert');
    var success = list.insertVertical(1, 2, 'Help');
    expect(success, false);
    expect(list, {
      {'0', '0', '0'},
      {'0', '0', 'V'},
      {'0', '0', 'e'},
      {'0', '0', 'r'},
      {'0', '0', 't'}
    });
    list.outputWordField();
  });
}
