

// extension method for validation
extension Validation on String {
  isRequired({required String errorText}) {
    if (this == "") {
      return errorText;
    }
    return null;
  }
}