extension NullOrEmpty on String? {
  bool nullOrEmpty() {
    if (this == null || this!.isEmpty) return true;
    return false;
  }
}
