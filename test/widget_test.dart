import 'package:backup_of_record/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BackupApp is the root widget', () {
    expect(const BackupApp(), isA<StatelessWidget>());
  });
}
