enum TrainStatus { reached, running, scheduled, cancelled, shortTerminate, shortOrigin }

class Train {
  final String trainNo;
  final String trainName;
  final String direction;
  final String depTime; // 24h format "HH:MM"
  final String arrTime; // 24h format "HH:MM"
  final TrainStatus status;
  final String? detail;

  const Train({
    required this.trainNo,
    required this.trainName,
    required this.direction,
    required this.depTime,
    required this.arrTime,
    required this.status,
    this.detail,
  });

  String get depTime12 => _to12h(depTime);
  String get arrTime12 => _to12h(arrTime);

  static String _to12h(String time24) {
    final parts = time24.split(':');
    int hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  /// Returns minutes since midnight
  int get depMinutes {
    final parts = depTime.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  int get arrMinutes {
    final parts = arrTime.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}

class SpecialNotice {
  final String date; // "9 May 2026"
  final Train train;
  final TrainStatus noticeType;
  final String? detail;

  const SpecialNotice({
    required this.date,
    required this.train,
    required this.noticeType,
    this.detail,
  });
}
