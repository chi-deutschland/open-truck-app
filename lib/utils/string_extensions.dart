extension PouchRecognitionStrExt on String {
  ///getters
  bool get isValidUrl {
    final RegExp regexUrl = RegExp(
      r'([\d]{3})[\-]{0,1}([\d]{8})',
      caseSensitive: false,
      multiLine: false,
    );

    if (regexUrl.hasMatch(this)) {
      return true;
    }
    return false;
  }
}
