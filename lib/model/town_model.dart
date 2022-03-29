class TownModel {
  TownModel({
    required this.id,
    required this.name,
    required this.stateId,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
  });
  late final String id;
  late final String name;
  late final String stateId;
  late final String createdAt;
  late final String updatedAt;
  late final MyState state;

  TownModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    name = json['name'].toString();
    stateId = json['state_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    state = MyState.fromJson(json['state']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['name'] = name.toString();
    _data['state_id'] = stateId.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['state'] = state.toJson();
    return _data;
  }
}

class MyState {
  MyState({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  MyState.fromJson(Map<String, dynamic> json){
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