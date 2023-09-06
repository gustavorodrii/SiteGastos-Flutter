class ExpenseData {
  final String name;
  final double value;
  bool isChecked;

  ExpenseData({
    required this.name,
    required this.value,
    required this.isChecked,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) {
    return ExpenseData(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      isChecked: json['isChecked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'isChecked': isChecked,
    };
  }
}
