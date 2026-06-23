extension IntDateTimeUtils on int? {
  DateTime? toDateTimeFromUnixSeconds() {
    final self = this;
    if (self != null) {
      return DateTime.fromMillisecondsSinceEpoch(
        self * 1000,
        isUtc: true,
      ).toLocal();
    }
    return null;
  }
}
