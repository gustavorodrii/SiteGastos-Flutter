// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserData {
  String mainItemName;
  String monthName;
  final String listName;
  int id;

  UserData({
    required this.mainItemName,
    required this.monthName,
    required this.listName,
    required this.id,
  });

  // Método para criar um objeto UserData a partir de um mapa (JSON)
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      mainItemName: json['mainItemName'],
      monthName: json['monthName'],
      listName: '',
      id: json['id'],
    );
  }

  // Método para converter um objeto UserData em um mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'mainItemName': mainItemName,
      'monthName': monthName,
      'listName': listName,
      'id': id,
    };
  }
}
