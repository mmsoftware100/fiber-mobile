class OneServiceScheduleModel {
  OneServiceScheduleModel({
    required this.id,
    required this.ticketCheckId,
    required this.teamId,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.team,
    required this.ticketcheck,
  });
  late final String id;
  late final String ticketCheckId;
  late final String teamId;
  late final String employeeId;
  late final String startDate;
  late final String endDate;
  late final String remark;
  late final String createdAt;
  late final String updatedAt;
  late final Team team;
  late final Ticketcheck ticketcheck;

  OneServiceScheduleModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    ticketCheckId = json['ticket_check_id'].toString();
    teamId = json['team_id'].toString();
    employeeId = json['employee_id'].toString();
    startDate = json['start_date'].toString();
    endDate = json['end_date'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    team = Team.fromJson(json['team']);
    ticketcheck = Ticketcheck.fromJson(json['ticketcheck']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['ticket_check_id'] = ticketCheckId.toString();
    _data['team_id'] = teamId.toString();
    _data['employee_id'] = employeeId.toString();
    _data['start_date'] = startDate.toString();
    _data['end_date'] = endDate.toString();
    _data['remark'] = remark.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['team'] = team.toJson();
    _data['ticketcheck'] = ticketcheck.toJson();
    return _data;
  }
}

class Team {
  Team({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  Team.fromJson(Map<String, dynamic> json){
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

class Ticketcheck {
  Ticketcheck({
    required this.id,
    required this.ticketId,
    required this.employeeId,
    required this.checkResultId,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.checkresult,
    required this.ticket,
  });
  late final String id;
  late final String ticketId;
  late final String employeeId;
  late final String checkResultId;
  late final String remark;
  late final String createdAt;
  late final String updatedAt;
  late final Checkresult checkresult;
  late final Ticket ticket;

  Ticketcheck.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    ticketId = json['ticket_id'].toString();
    employeeId = json['employee_id'].toString();
    checkResultId = json['check_result_id'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    checkresult = Checkresult.fromJson(json['checkresult']);
    ticket = Ticket.fromJson(json['ticket']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['ticket_id'] = ticketId.toString();
    _data['employee_id'] = employeeId.toString();
    _data['check_result_id'] = checkResultId.toString();
    _data['remark'] = remark.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['checkresult'] = checkresult.toJson();
    _data['ticket'] = ticket.toJson();
    return _data;
  }
}

class Checkresult {
  Checkresult({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  Checkresult.fromJson(Map<String, dynamic> json){
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

class Ticket {
  Ticket({
    required this.id,
    required this.orderId,
    required this.employeeId,
    required this.issueId,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.issue,
    required this.order,
  });
  late final String id;
  late final String orderId;
  late final String employeeId;
  late final String issueId;
  late final String remark;
  late final String createdAt;
  late final String updatedAt;
  late final Issue issue;
  late final Order order;

  Ticket.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    orderId = json['order_id'].toString();
    employeeId = json['employee_id'].toString();
    issueId = json['issue_id'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    issue = Issue.fromJson(json['issue']);
    order = Order.fromJson(json['order']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['order_id'] = orderId.toString();
    _data['employee_id'] = employeeId.toString();
    _data['issue_id'] = issueId.toString();
    _data['remark'] = remark.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['issue'] = issue.toJson();
    _data['order'] = order.toJson();
    return _data;
  }
}

class Issue {
  Issue({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  Issue.fromJson(Map<String, dynamic> json){
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

class Order {
  Order({
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
    //required this.photos,
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
  //late final Photos photos;
  late final Customer customer;

  Order.fromJson(Map<String, dynamic> json){
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
    //photos = Photos.fromJson(json['photos']);
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
    //_data['photos'] = photos.toJson();
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
  late final Contract contract;
  late final Transcation transcation;

  Photos.fromJson(Map<String, dynamic> json){
    contract = Contract.fromJson(json['contract']);
    transcation = Transcation.fromJson(json['transcation']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['contract'] = contract.toJson();
    _data['transcation'] = transcation.toJson();
    return _data;
  }
}

class Contract {
  Contract({
    required this.id,
    required this.orderId,
    required this.name,
    required this.photoTypeId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String orderId;
  late final String name;
  late final String photoTypeId;
  late final String createdAt;
  late final String updatedAt;

  Contract.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    orderId = json['order_id'].toString();
    name = json['name'].toString();
    photoTypeId = json['photo_type_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['order_id'] = orderId.toString();
    _data['name'] = name.toString();
    _data['photo_type_id'] = photoTypeId.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    return _data;
  }
}

class Transcation {
  Transcation({
    required this.id,
    required this.orderId,
    required this.name,
    required this.photoTypeId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String orderId;
  late final String name;
  late final String photoTypeId;
  late final String createdAt;
  late final String updatedAt;

  Transcation.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    orderId = json['order_id'].toString();
    name = json['name'].toString();
    photoTypeId = json['photo_type_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['order_id'] = orderId.toString();
    _data['name'] = name.toString();
    _data['photo_type_id'] = photoTypeId.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    return _data;
  }
}

// class Customer {
//   Customer({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.nrc,
//     required this.phones,
//     required this.photos,
//     required this.address,
//   });
//   late final String id;
//   late final String name;
//   late final String email;
//   late final String nrc;
//   late final List<Phones> phones;
//   late final Photos photos;
//   late final Address address;
//
//   Customer.fromJson(Map<String, dynamic> json){
//     id = json['id'].toString();
//     name = json['name'].toString();
//     email = json['email'].toString();
//     nrc = json['nrc'].toString();
//     phones = List.from(json['phones']).map((e)=>Phones.fromJson(e)).toList();
//     photos = Photos.fromJson(json['photos']);
//     address = Address.fromJson(json['address']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id.toString();
//     _data['name'] = name.toString();
//     _data['email'] = email.toString();
//     _data['nrc'] = nrc.toString();
//     _data['phones'] = phones.map((e)=>e.toJson()).toList();
//     _data['photos'] = photos.toJson();
//     _data['address'] = address.toJson();
//     return _data;
//   }
// }
//
// class Phones {
//   Phones({
//     required this.id,
//     required this.customerId,
//     required this.phone,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//   late final String id;
//   late final String customerId;
//   late final String phone;
//   late final String createdAt;
//   late final String updatedAt;
//
//   Phones.fromJson(Map<String, dynamic> json){
//     id = json['id'].toString();
//     customerId = json['customer_id'].toString();
//     phone = json['phone'].toString();
//     createdAt = json['created_at'].toString();
//     updatedAt = json['updated_at'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id.toString();
//     _data['customer_id'] = customerId.toString();
//     _data['phone'] = phone.toString();
//     _data['created_at'] = createdAt.toString();
//     _data['updated_at'] = updatedAt.toString();
//     return _data;
//   }
// }

class Customer {
  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.nrc,
    required this.phones,
    //required this.photos,
    required this.address,
  });
  late final String id;
  late final String name;
  late final String email;
  late final String nrc;
  late final List<Phones> phones;
  //late final CustPhotos photos;
  late final Address address;

  Customer.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    nrc = json['nrc'].toString();
    phones = List.from(json['phones']).map((e)=>Phones.fromJson(e)).toList();
    //photos = CustPhotos.fromJson(json['photos']);
    address = Address.fromJson(json['address']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['name'] = name.toString();
    _data['email'] = email.toString();
    _data['nrc'] = nrc.toString();
    _data['phones'] = phones.map((e)=>e.toJson()).toList();
    //_data['photos'] = photos.toJson();
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

class CustPhotos {
  CustPhotos({
    required this.nrcFront,
    required this.nrcBack,
  });
  late final NrcFront nrcFront;
  late final NrcBack nrcBack;

  CustPhotos.fromJson(Map<String, dynamic> json){
    nrcFront = NrcFront.fromJson(json['nrc_front']);
    nrcBack = NrcBack.fromJson(json['nrc_back']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nrc_front'] = nrcFront.toJson();
    _data['nrc_back'] = nrcBack.toJson();
    return _data;
  }
}

class NrcFront {
  NrcFront({
    required this.id,
    required this.customerId,
    required this.name,
    required this.photoTypeId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String customerId;
  late final String name;
  late final String photoTypeId;
  late final String createdAt;
  late final String updatedAt;

  NrcFront.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    customerId = json['customer_id'].toString();
    name = json['name'].toString();
    photoTypeId = json['photo_type_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['customer_id'] = customerId.toString();
    _data['name'] = name.toString();
    _data['photo_type_id'] = photoTypeId.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    return _data;
  }
}

class NrcBack {
  NrcBack({
    required this.id,
    required this.customerId,
    required this.name,
    required this.photoTypeId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String customerId;
  late final String name;
  late final String photoTypeId;
  late final String createdAt;
  late final String updatedAt;

  NrcBack.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    customerId = json['customer_id'].toString();
    name = json['name'].toString();
    photoTypeId = json['photo_type_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['customer_id'] = customerId.toString();
    _data['name'] = name.toString();
    _data['photo_type_id'] = photoTypeId.toString();
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