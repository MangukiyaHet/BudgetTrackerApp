class SpendingModel {
  int? id;
  String s_name;
  String s_amount;
  String s_mode;
  String s_type;
  String date;
  String time;

  SpendingModel({
    this.id,
    required this.s_name,
    required this.s_amount,
    required this.s_type,
    required this.s_mode,
    required this.time,
    required this.date,
  });
  factory SpendingModel.fromSQL({required Map data}) {
    return SpendingModel(
      id: data['spending_id'],
      s_name: data['spending_name'],
      s_amount: data['spending_amount'],
      s_type: data['spending_type'],
      s_mode: data['spending_mode'],
      time: data['s_time'],
      date: data['s_date'],
    );
  }
}
