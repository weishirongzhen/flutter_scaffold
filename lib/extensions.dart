import 'package:intl/intl.dart';

extension ParseTime on int {
  String toMinSecCountdownTime() {
    int min = this ~/ 60;
    String minStr = min < 10 ? "0$min" : min.toString();
    int sec = this % 60;
    String secStr = sec < 10 ? "0$sec" : sec.toString();
    return "$minStr:$secStr";
  }
}

extension HideInfo on String {
  String toHidBankcardNumber() {
    String last4 = this.substring(this.length - 4);
    String left = this.substring(0, this.length - 4);
    StringBuffer newLeft = StringBuffer();
    for (int i = 0; i < left.length; i++) {
      newLeft.write("*");
    }
    return newLeft.toString() + last4;
  }
}

extension TimeFormat on int {
  String toFormattedTime({String format = "yyyy/MM/dd HH:mm:ss"}) {
    var dateFormat = DateFormat(format);
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(this));
  }

  String toHourMinSecond() {
    int seconds = this ~/ 1000;
    int h = seconds ~/ 3600;
    int m = (seconds - h * 3600) ~/ 60;
    int s = seconds - h * 3600 - m * 60;
    String hStr = h < 10 ? "0$h" : h.toString();
    String mStr = m < 10 ? "0$m" : m.toString();
    String sStr = s < 10 ? "0$s" : s.toString();
    return "$hStr:$mStr:$sStr";
  }
}

extension TimeParser on String {
  DateTime toDateTime({String format = "yyyy-MM-dd HH:mm:ss"}) {
    var dateFormat = DateFormat(format);
    return dateFormat.parse(this);
  }
}
