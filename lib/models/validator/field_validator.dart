class FieldValidator {
  static String? titleValidator(String? title) {
    if (title!.isEmpty) {
      return 'Please enter a title';
    } else {
      return null;
    }
  }

  static String? descriptionValidator(String? description) {
    if (description!.isEmpty) {
      return 'Please enter a description';
    } else if (description.length > 100) {
      return 'Max length is 100 characters';
    }
    return null;
  }
}
