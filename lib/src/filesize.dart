/// A method returns a human readable string representing a file _size
String filesize(dynamic size, [int round = 2]) {
  /** 
   * [size] can be passed as number or as string
   *
   * the optional parameter [round] specifies the number 
   * of digits after comma/point (default is 2)
   */
  var divider = 1024;
  int _size;
  try {
    _size = int.parse(size.toString());
  } catch (e) {
    throw ArgumentError('Can not parse the size parameter: $e');
  }

  if (_size < divider) {
    return '$_size B';
  }

  if (_size < divider * divider && _size % divider == 0) {
    return '${(_size / divider).toStringAsFixed(0)} KB';
  }

  if (_size < divider * divider) {
    return '${(_size / divider).toStringAsFixed(round)} KB';
  }

  if (_size < divider * divider * divider && _size % divider == 0) {
    return '${(_size / (divider * divider)).toStringAsFixed(0)} MB';
  }

  if (_size < divider * divider * divider) {
    return '${(_size / divider / divider).toStringAsFixed(round)} MB';
  }

  if (_size < divider * divider * divider * divider && _size % divider == 0) {
    return '${(_size / (divider * divider * divider)).toStringAsFixed(0)} GB';
  }

  if (_size < divider * divider * divider * divider) {
    return '${(_size / divider / divider / divider).toStringAsFixed(round)} GB';
  }

  if (_size < divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    num r = _size / divider / divider / divider / divider;
    return '${r.toStringAsFixed(0)} TB';
  }

  if (_size < divider * divider * divider * divider * divider) {
    num r = _size / divider / divider / divider / divider;
    return '${r.toStringAsFixed(round)} TB';
  }

  if (_size < divider * divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    num r = _size / divider / divider / divider / divider / divider;
    return '${r.toStringAsFixed(0)} PB';
  } else {
    num r = _size / divider / divider / divider / divider / divider;
    return '${r.toStringAsFixed(round)} PB';
  }
}

RegExp regex = RegExp(r'^([\d.]+)\s*([a-zA-Z]+)$');

int parseFilesize(String size) {
  /**
   * [size] must be a string in the format of '1 KB', '1.5 MB', etc.
   * Supported units: B, KB, MB, GB, TB, PB
   */

  // Define multipliers
  const Map<String, int> unitMultipliers = {
    'B': 1,
    'KB': 1024,
    'MB': 1024 * 1024,
    'GB': 1024 * 1024 * 1024,
    'TB': 1024 * 1024 * 1024 * 1024,
    'PB': 1024 * 1024 * 1024 * 1024 * 1024,
  };

  // Regular expression to extract the number and unit

  final match = regex.firstMatch(size);

  if (match == null) {
    throw ArgumentError('Invalid size format: $size');
  }

  // Parse the number and unit
  final numValue = double.tryParse(match.group(1) ?? '');
  final unit = match.group(2)?.toUpperCase();

  if (numValue == null || unit == null || !unitMultipliers.containsKey(unit)) {
    throw ArgumentError('Invalid size format: $size');
  }

  // Convert to bytes
  return (numValue * unitMultipliers[unit]!).round();
}

bool sizeCompare(String a, String b) {
  return parseFilesize(a) > parseFilesize(b);
}
