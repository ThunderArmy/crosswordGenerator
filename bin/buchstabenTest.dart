import 'package:buchstabenTest/generator.dart';

void main(List<String> arguments) {
  var gen = Generator('input.txt');
  gen.generate();
  gen.replaceZeros();
  gen.outputWordField();
}
