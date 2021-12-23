import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/models/validator/field_validator.dart';

void main() {
  test('empty title field from input to create a task', () {
    var result = FieldValidator.titleValidator('');
    expect(result, 'Please enter a title');
  });
  test('non-empty title field input to create a task', () {
    var result = FieldValidator.titleValidator('Title');
    expect(result, null);
  });

  test('empty description field from input to create a task', () {
    var result = FieldValidator.descriptionValidator('');
    expect(result, 'Please enter a description');
  });
  test('Over 100 characters in description field', () {
    String description = '';
    while (description.length < 100) {
      description += 'test';
    }
    var result = FieldValidator.descriptionValidator(description);
    expect(result, null);
  });

  test('non-empty description field input to create a task', () {
    var result = FieldValidator.descriptionValidator('Description');
    expect(result, null);
  });
}
