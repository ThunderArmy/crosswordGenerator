import 'package:buchstabenTest/Field2d.dart';
import 'package:test/test.dart';

void main() {
  test('insert at 2 3 should generate 3 rows and insert "Test" in the last one',
      () {
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
}
