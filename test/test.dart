import '../lib/api/api.dart';

void main(List<String> args) async {
  List a = [
    {"date": "20200129", "value": 1},
    {"date": "20200128", "value": 5},
    {"date": "20200210", "value": 3}
  ];
  a.sort((b, c) =>
      DateTime.parse(b["date"]).isBefore(DateTime.parse(c["date"])) ? 1 : 0);
  print(a);
}
