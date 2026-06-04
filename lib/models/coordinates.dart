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
}
