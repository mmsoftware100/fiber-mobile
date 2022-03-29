class PackageModel {
  PackageModel({
    required this.id,
    required this.name,
    required this.price,
    required this.packagetypeId,
    required this.createdAt,
    required this.updatedAt,
    required this.packagetype,
  });
  late final String id;
  late final String name;
  late final String price;
  late final String packagetypeId;
  late final String createdAt;
  late final String updatedAt;
  late final Packagetype packagetype;

  PackageModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    name = json['name'].toString();
    price = json['price'].toString();
    packagetypeId = json['packagetype_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    packagetype = Packagetype.fromJson(json['packagetype']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['name'] = name.toString();
    _data['price'] = price.toString();
    _data['packagetype_id'] = packagetypeId.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['packagetype'] = packagetype.toJson();
    return _data;
  }
}

class Packagetype {
  Packagetype({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  Packagetype.fromJson(Map<String, dynamic> json){
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