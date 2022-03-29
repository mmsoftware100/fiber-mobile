class PortModel {
  PortModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String lat;
  late final String lng;
  late final String createdAt;
  late final String updatedAt;

  PortModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    name = json['name'].toString();
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['name'] = name.toString();
    _data['lat'] = lat.toString();
    _data['lng'] = lng.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    return _data;
  }
}