import 'package:flutter/material.dart';

bool _isToday(DateTime date, DateTime now) {
  return date.day == now.day;
}

bool _isTomorrow(DateTime date, DateTime now) {
  return date.difference(now).inDays <= 1;
}

bool _isThisWeek(DateTime date, DateTime now) {
  return date.difference(now).inDays <= 7;
}

bool _isThisMonth4mNow(DateTime date, DateTime now) {
  return date.month == now.month && date.isAfter(now);
}

bool _isLaterThisMonth(DateTime date, DateTime now) {
  return date.isAfter(now);
}

enum TimingSections {
  today("Today", _isToday),
  tomorrow("Tomorrow", _isTomorrow),
  nextWeek("Next week", _isThisWeek),
  thisMonth4mToday("This month", _isThisMonth4mNow),
  later("Later", _isLaterThisMonth);

  final String displayName;

  final bool Function(DateTime, DateTime) timingFunction;

  const TimingSections(this.displayName, this.timingFunction);
}

mixin MapTimingMixin on ChangeNotifier {
  late DateTime _now;
  Map<String, List>? _dataByTimings;
  int headerIndex = 0;
  late List<String> _headers;
  late List<bool Function(DateTime date, DateTime now)> _headersFunctions;

  final List<TimingSections> timingSections = [
    TimingSections.today,
    TimingSections.tomorrow,
    TimingSections.nextWeek,
    TimingSections.thisMonth4mToday,
    TimingSections.later,
  ];

  Map<String, List>? get dataByTimings => _dataByTimings;

  DateTime date4mListItem(listItem);

  void initTimingSections(DateTime now) {
    _now = now;
    _headers = <String>[];
    _headersFunctions = <bool Function(DateTime date, DateTime now)>[];
    for (var element in timingSections) {
      _headers.add(element.displayName);
      _headersFunctions.add(element.timingFunction);
    }
  }

  void mapTimings(List data) {
    _dataByTimings ??= {};
    _dataByTimings![_headers[headerIndex]] ??= [];
    for (int j = 0; j < data.length;) {
      final date = date4mListItem(data[j]);
      if (_headersFunctions[headerIndex](date, _now)) {
        _dataByTimings![_headers[headerIndex]]!.add(data[j]);
        j++;
      } else {
        headerIndex++;
        _dataByTimings![_headers[headerIndex]] ??= [];
      }
    }
  }
}
