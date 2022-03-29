class OneInstallationModel {
  OneInstallationModel({
    required this.id,
    required this.installationScheduleId,
    required this.employeeId,
    required this.statusId,
    required this.onuId,
    required this.onuSn,
    required this.onbName,
    required this.onbLocation,
    required this.userPort,
    required this.cable,
    required this.outputSignal,
    required this.inputSignal,
    required this.startDate,
    required this.endDate,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.photos,
    required this.installationschedule,
  });
  late final String id;
  late final String installationScheduleId;
  late final String employeeId;
  late final String statusId;
  late final String onuId;
  late final String onuSn;
  late final String onbName;
  late final String onbLocation;
  late final String userPort;
  late final String cable;
  late final String outputSignal;
  late final String inputSignal;
  late final String startDate;
  late final String endDate;
  late final String remark;
  late final String createdAt;
  late final String updatedAt;
  late final Status status;
  late final Photos photos;
  late final Installationschedule installationschedule;

  OneInstallationModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    installationScheduleId = json['installation_schedule_id'].toString();
    employeeId = json['employee_id'].toString();
    statusId = json['status_id'].toString();
    onuId = json['onu_id'].toString();
    onuSn = json['onu_sn'].toString();
    onbName = json['onb_name'].toString();
    onbLocation = json['onb_location'].toString();
    userPort = json['user_port'].toString();
    cable = json['cable'].toString();
    outputSignal = json['output_signal'].toString();
    inputSignal = json['input_signal'].toString();
    startDate = json['start_date'].toString();
    endDate = json['end_date'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    status = Status.fromJson(json['status']);
    photos = Photos.fromJson(json['photos']);
    installationschedule = Installationschedule.fromJson(json['installationschedule']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['installation_schedule_id'] = installationScheduleId.toString();
    _data['employee_id'] = employeeId.toString();
    _data['status_id'] = statusId.toString();
    _data['onu_id'] = onuId.toString();
    _data['onu_sn'] = onuSn.toString();
    _data['onb_name'] = onbName.toString();
    _data['onb_location'] = onbLocation.toString();
    _data['user_port'] = userPort.toString();
    _data['cable'] = cable.toString();
    _data['output_signal'] = outputSignal.toString();
    _data['input_signal'] = inputSignal.toString();
    _data['start_date'] = startDate.toString();
    _data['end_date'] = endDate.toString();
    _data['remark'] = remark.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['status'] = status.toJson();
    _data['photos'] = photos.toJson();
    _data['installationschedule'] = installationschedule.toJson();
    return _data;
  }
}

class Status {
  Status({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  Status.fromJson(Map<String, dynamic> json){
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
    required this.odb,
    required this.router,
  });
  late final Odb odb;
  late final Router router;

  Photos.fromJson(Map<String, dynamic> json){
    odb = Odb.fromJson(json['odb']);
    router = Router.fromJson(json['router']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['odb'] = odb.toJson();
    _data['router'] = router.toJson();
    return _data;
  }
}

class Odb {
  Odb({
    required this.id,
    required this.installationId,
    required this.name,
    required this.photoTypeId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String installationId;
  late final String name;
  late final String photoTypeId;
  late final String createdAt;
  late final String updatedAt;

  Odb.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    installationId = json['installation_id'].toString();
    name = json['name'].toString();
    photoTypeId = json['photo_type_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['installation_id'] = installationId.toString();
    _data['name'] = name.toString();
    _data['photo_type_id'] = photoTypeId.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    return _data;
  }
}

class Router {
  Router({
    required this.id,
    required this.installationId,
    required this.name,
    required this.photoTypeId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String installationId;
  late final String name;
  late final String photoTypeId;
  late final String createdAt;
  late final String updatedAt;

  Router.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    installationId = json['installation_id'].toString();
    name = json['name'].toString();
    photoTypeId = json['photo_type_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['installation_id'] = installationId.toString();
    _data['name'] = name.toString();
    _data['photo_type_id'] = photoTypeId.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    return _data;
  }
}

class Installationschedule {
  Installationschedule({
    required this.id,
    required this.virtualSurveyId,
    required this.employeeId,
    required this.teamId,
    required this.remark,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.team,
    required this.virtualsurvey,
  });
  late final String id;
  late final String virtualSurveyId;
  late final String employeeId;
  late final String teamId;
  late final String remark;
  late final String startDate;
  late final String endDate;
  late final String createdAt;
  late final String updatedAt;
  late final Team team;
  late final Virtualsurvey virtualsurvey;

  Installationschedule.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    virtualSurveyId = json['virtual_survey_id'].toString();
    employeeId = json['employee_id'].toString();
    teamId = json['team_id'].toString();
    remark = json['remark'].toString();
    startDate = json['start_date'].toString();
    endDate = json['end_date'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    team = Team.fromJson(json['team']);
    virtualsurvey = Virtualsurvey.fromJson(json['virtualsurvey']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['virtual_survey_id'] = virtualSurveyId.toString();
    _data['employee_id'] = employeeId.toString();
    _data['team_id'] = teamId.toString();
    _data['remark'] = remark.toString();
    _data['start_date'] = startDate.toString();
    _data['end_date'] = endDate.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['team'] = team.toJson();
    _data['virtualsurvey'] = virtualsurvey.toJson();
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

class Virtualsurvey {
  Virtualsurvey({
    required this.id,
    required this.orderId,
    required this.conditionId,
    required this.employeeId,
    required this.portId,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.order,
    required this.port,
    required this.condition,
  });
  late final String id;
  late final String orderId;
  late final String conditionId;
  late final String employeeId;
  late final String portId;
  late final String remark;
  late final String createdAt;
  late final String updatedAt;
  late final Order order;
  late final Port port;
  late final Condition condition;

  Virtualsurvey.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    orderId = json['order_id'].toString();
    conditionId = json['condition_id'].toString();
    employeeId = json['employee_id'].toString();
    portId = json['port_id'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    order = Order.fromJson(json['order']);
    port = Port.fromJson(json['port']);
    condition = Condition.fromJson(json['condition']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id.toString();
    _data['order_id'] = orderId.toString();
    _data['condition_id'] = conditionId.toString();
    _data['employee_id'] = employeeId.toString();
    _data['port_id'] = portId.toString();
    _data['remark'] = remark.toString();
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['order'] = order.toJson();
    _data['port'] = port.toJson();
    _data['condition'] = condition.toJson();
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
    nrc = json['nrc'].toString();
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

class Port {
  Port({
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

  Port.fromJson(Map<String, dynamic> json){
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

class Condition {
  Condition({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String createdAt;
  late final String updatedAt;

  Condition.fromJson(Map<String, dynamic> json){
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