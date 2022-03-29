class AllInstallationScheduleModel {
  AllInstallationScheduleModel({
    required this.id,
    required this.orderId,
    required this.conditionId,
    required this.employeeId,
    required this.portId,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String orderId;
  late final String conditionId;
  late final String employeeId;
  late final String portId;
  late final String remark;
  late final String createdAt;
  late final String updatedAt;

  AllInstallationScheduleModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    orderId = json['order_id'].toString();
    conditionId = json['condition_id'].toString();
    employeeId = json['employee_id'].toString();
    portId = json['port_id'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
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
    return _data;
  }
}