class AllOrderModel {
  AllOrderModel({
    required this.id,
    required this.customerId,
    required this.employeeId,
    required this.packageId,
    required this.paymentId,
    required this.planId,
    required this.code,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.package,
    required this.payment,
    required this.photos,
    required this.customer,
  });
  late final String id;
  late final String customerId;
  late final String employeeId;
  late final String packageId;
  late final String paymentId;
  late final String planId;
  late final String code;
  late final String remark;
  late final String createdAt;
  late final String updatedAt;
  late final Package package;
  late final Payment payment;
  late final Photos photos;
  late final Customer customer;

  AllOrderModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    customerId = json['customer_id'].toString();
    employeeId = json['employee_id'].toString();
    packageId = json['package_id'].toString();
    paymentId = json['payment_id'].toString();
    planId = json['plan_id'].toString();
    code = json['code'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    package = Package.fromJson(json['package']);
    payment = Payment.fromJson(json['payment']);
    photos = Photos.fromJson(json['photos']);
    customer = Customer.fromJson(json['customer']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['customer_id'] = customerId.toString();
    _data['employee_id'] = employeeId.toString();
    _data['package_id'] = packageId.toString();
    _data['payment_id'] = paymentId.toString();
    _data['plan_id'] = planId.toString();
    _data['code'] = code.toString();
    _data['remark'] = remark.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['package'] = package.toJson();
    _data['payment'] = payment.toJson();
    _data['photos'] = photos.toJson();
    _data['customer'] = customer.toJson();
    return _data;
  }
}

class Package {
  Package({
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

  Package.fromJson(Map<String, dynamic> json){
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

class Payment {
  Payment({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  Payment.fromJson(Map<String, dynamic> json){
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

class Photos {
  Photos({
    required this.contract,
    required this.transcation,
  });
  late final String contract;
  late final String transcation;

  Photos.fromJson(Map<String, dynamic> json){
    contract = json['contract'].toString();
    transcation = json['transcation'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['contract'] = contract.toString();
    _data['transcation'] = transcation.toString();
    return _data;
  }
}

class Customer {
  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.nrc,
    required this.phones,
    required this.photos,
    required this.address,
  });
  late final String id;
  late final String name;
  late final String email;
  late final String nrc;
  late final List<Phones> phones;
  late final Photos photos;
  late final Address address;

  Customer.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    nrc = json['nrc'];
    phones = List.from(json['phones']).map((e)=>Phones.fromJson(e)).toList();
    photos = Photos.fromJson(json['photos']);
    address = Address.fromJson(json['address']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['name'] = name.toString();
    _data['email'] = email.toString();
    _data['nrc'] = nrc.toString();
    _data['phones'] = phones.map((e)=>e.toJson()).toList();
    _data['photos'] = photos.toJson();
    _data['address'] = address.toJson();
    return _data;
  }
}

class Phones {
  Phones({
    required this.id,
    required this.customerId,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String customerId;
  late final String phone;
  late final String createdAt;
  late final String updatedAt;

  Phones.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    customerId = json['customer_id'].toString();
    phone = json['phone'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['customer_id'] = customerId.toString();
    _data['phone'] = phone.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    return _data;
  }
}

class Address {
  Address({
    required this.id,
    required this.town,
    required this.state,
    required this.ward,
    required this.street,
    required this.home,
    required this.floor,
    required this.room,
    required this.lat,
    required this.lng,
  });
  late final String id;
  late final Town town;
  late final MyState state;
  late final String ward;
  late final String street;
  late final String home;
  late final String floor;
  late final String room;
  late final String lat;
  late final String lng;

  Address.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    town = Town.fromJson(json['town']);
    state = MyState.fromJson(json['state']);
    ward = json['ward'].toString();
    street = json['street'].toString();
    home = json['home'].toString();
    floor = json['floor'].toString();
    room = json['room'].toString();
    lat = json['lat'].toString();
    lng = json['lng'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['town'] = town.toJson();
    _data['state'] = state.toJson();
    _data['ward'] = ward.toString();
    _data['street'] = street.toString();
    _data['home'] = home.toString();
    _data['floor'] = floor.toString();
    _data['room'] = room.toString();
    _data['lat'] = lat.toString();
    _data['lng'] = lng.toString();
    return _data;
  }
}

class Town {
  Town({
    required this.id,
    required this.name,
    required this.stateId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String stateId;
  late final String createdAt;
  late final String updatedAt;

  Town.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    name = json['name'].toString();
    stateId = json['state_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['name'] = name.toString();
    _data['state_id'] = stateId.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
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