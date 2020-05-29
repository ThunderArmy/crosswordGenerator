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

  test('insert horizontal at x:0 y:2 should work', () {
    var list = <List<String>>[];
    list.insertHorizontal(0, 2, 'Koechin');
    list.insertVertical(1, 6, 'gnudlibsuA');
    expect(list, {
      {'0', '0', 'K', 'o', 'e', 'c', 'h', 'i', 'n' },
      {'0', '0', '0', '0', '0', '0', 'g', '0', '0' },
      {'0', '0', '0', '0', '0', '0', 'n', '0', '0' },
      {'0', '0', '0', '0', '0', '0', 'u', '0', '0' },
      {'0', '0', '0', '0', '0', '0', 'd', '0', '0' },
      {'0', '0', '0', '0', '0', '0', 'l', '0', '0' },
      {'0', '0', '0', '0', '0', '0', 'i', '0', '0' },
      {'0', '0', '0', '0', '0', '0', 'b', '0', '0' },
      {'0', '0', '0', '0', '0', '0', 's', '0', '0' },
      {'0', '0', '0', '0', '0', '0', 'u', '0', '0' },
      {'0', '0', '0', '0', '0', '0', 'A', '0', '0' }
    });
    list.outputWordField();
  });

  test('insert horizontal at x: 3 y: 1 should not crash', () {
    var list = <List<String>>[];
    list.insertHorizontal(1, 3, 'MINT');

  });
}
