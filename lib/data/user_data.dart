class UserData {
  String mainItemName;
  String monthName;

  UserData({required this.mainItemName, required this.monthName});

  // Método para criar um objeto UserData a partir de um mapa (JSON)
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      mainItemName: json['mainItemName'],
      monthName: json['monthName'],
    );
  }

  // Método para converter um objeto UserData em um mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'mainItemName': mainItemName,
      'monthName': monthName,
    };
  }
}
