class Validators {
  static String? validateNoteTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title cannot be empty';
    }
    return null;
  }

  static String? validateNoteContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Content cannot be empty';
    }
    return null;
  }
}