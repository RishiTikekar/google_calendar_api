class UtilFunctions {
  static bool isValidString(var str) {
    return str != null && str is String && str.isNotEmpty;
  }

  static bool isValidMap(var map) {
    return map != null && map is Map && map.isNotEmpty;
  }

  static bool isValidList(var list) {
    return list != null && list is List && list.isNotEmpty;
  }

  static String formatReadableDate(DateTime time) {
    return '${time.day}/${time.month}/${time.year}, ${time.hour < 10 ? '0${time.hour}' : time.hour}:${time.minute < 10 ? '0${time.minute}' : time.minute}';
  }
}
