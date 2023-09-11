// ignore_for_file: public_member_api_docs, sort_constructors_first
class MetaDataPage {
  String nomeMeta;
  double valueMeta;
  int prazoMeta;
  int id;

  MetaDataPage({
    required this.nomeMeta,
    required this.valueMeta,
    required this.prazoMeta,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'nomeMeta': nomeMeta,
      'valueMeta': valueMeta,
      'prazoMeta': prazoMeta,
      'id': id,
    };
  }

  factory MetaDataPage.fromJson(Map<String, dynamic> json) {
    return MetaDataPage(
      nomeMeta: json['nomeMeta'],
      valueMeta: json['valueMeta'],
      prazoMeta: json['prazoMeta'],
      id: json['id'],
    );
  }
}
