class Coordinates {
  final double lat;
  final double lon;

  const Coordinates({
    required this.lat,
    required this.lon,
  });

  @override
  String toString() => 'Coordinates('
      'lat: $lat,'
      ' lon: $lon,'
      ')';

  @override
  bool operator ==(
    Object other,
  ) =>
      identical(
        this,
        other,
      ) ||
      other is Coordinates && lat == other.lat && lon == other.lon;

  @override
  int get hashCode => Object.hash(
        lat,
        lon,
      );
}
