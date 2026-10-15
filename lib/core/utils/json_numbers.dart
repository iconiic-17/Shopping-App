double asDouble(dynamic value) {
  if (value is num) return value.toDouble();
  if (value is String) {
    return double.tryParse(value.trim()) ?? 0;
  }
  return 0;
}

int asInt(dynamic value) {
  if (value is num) return value.toInt();
  if (value is String) {
    return int.tryParse(value.trim()) ?? double.tryParse(value.trim())?.toInt() ?? 0;
  }
  return 0;
}
