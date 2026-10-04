import 'dart:math' as math;

/// Geodesic helpers. Pure Dart, no Flutter.
///
/// Distances are computed with the haversine formula on a spherical earth.
/// At the scale of a single ride (tens of kilometres) the error against the
/// WGS84 ellipsoid is well under a metre, which is far smaller than the GPS
/// noise we are already filtering out.
abstract final class Geo {
  static const earthRadiusKm = 6371.0088;

  /// Great-circle distance between two points, in kilometres.
  static double haversineKm({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    final dLat = _rad(lat2 - lat1);
    final dLng = _rad(lng2 - lng1);
    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_rad(lat1)) *
            math.cos(_rad(lat2)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    return earthRadiusKm * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }

  /// Initial bearing from one point to another, in degrees clockwise from north.
  ///
  /// Unused by the current UI but needed to draw a direction-of-travel arrow on
  /// the live trip screen, and cheap enough to keep with the rest of the maths.
  static double bearingDeg({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    final p1 = _rad(lat1);
    final p2 = _rad(lat2);
    final dl = _rad(lng2 - lng1);
    final y = math.sin(dl) * math.cos(p2);
    final x =
        math.cos(p1) * math.sin(p2) -
        math.sin(p1) * math.cos(p2) * math.cos(dl);
    return (math.atan2(y, x) * 180 / math.pi + 360) % 360;
  }

  /// Smallest change needed to turn [from] into [to], in degrees, -180..180.
  static double deltaDeg(double from, double to) {
    var d = (to - from) % 360;
    if (d > 180) d -= 360;
    if (d < -180) d += 360;
    return d;
  }

  /// Total distance of a polyline, skipping consecutive duplicates.
  static double polylineKm(List<({double lat, double lng})> points) {
    if (points.length < 2) return 0;
    var total = 0.0;
    for (var i = 1; i < points.length; i++) {
      final a = points[i - 1];
      final b = points[i];
      total += haversineKm(lat1: a.lat, lng1: a.lng, lat2: b.lat, lng2: b.lng);
    }
    return total;
  }

  /// Bounding box of a polyline, or null when there is nothing to bound.
  static ({double minLat, double maxLat, double minLng, double maxLng})? bounds(
    List<({double lat, double lng})> points,
  ) {
    if (points.isEmpty) return null;
    var minLat = points.first.lat;
    var maxLat = points.first.lat;
    var minLng = points.first.lng;
    var maxLng = points.first.lng;
    for (final p in points.skip(1)) {
      if (p.lat < minLat) minLat = p.lat;
      if (p.lat > maxLat) maxLat = p.lat;
      if (p.lng < minLng) minLng = p.lng;
      if (p.lng > maxLng) maxLng = p.lng;
    }
    return (minLat: minLat, maxLat: maxLat, minLng: minLng, maxLng: maxLng);
  }

  static double _rad(double deg) => deg * math.pi / 180;
}
