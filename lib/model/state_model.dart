class StateModel {
  StateModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  StateModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    name = json['name'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['name'] = name.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    return _data;
  }
}