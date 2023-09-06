// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserData {
  String mainItemName;
  String monthName;
  final String listName;

  UserData({
    required this.mainItemName,
    required this.monthName,
    required this.listName,
  });

  // Método para criar um objeto UserData a partir de um mapa (JSON)
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      mainItemName: json['mainItemName'],
      monthName: json['monthName'],
      listName: '',
    );
  }

  // Método para converter um objeto UserData em um mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'mainItemName': mainItemName,
      'monthName': monthName,
      'listName': listName,
    };
  }
}
