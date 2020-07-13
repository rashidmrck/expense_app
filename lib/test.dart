main() {
  print(weekDay);
}

var weekDay;
List<Map<String, Object>> get groupedTransaction {
  return List.generate(7, (index) {
    weekDay = DateTime.now().subtract(
      Duration(days: index),
    );
  return {'day': weekDay};
  });
}
