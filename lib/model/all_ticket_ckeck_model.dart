class AllTicketCheckModel {
  AllTicketCheckModel({
    required this.id,
    required this.orderId,
    required this.employeeId,
    required this.issueId,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String orderId;
  late final String employeeId;
  late final String issueId;
  late final String remark;
  late final String createdAt;
  late final String updatedAt;

  AllTicketCheckModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    orderId = json['order_id'].toString();
    employeeId = json['employee_id'].toString();
    issueId = json['issue_id'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
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
    return _data;
  }
}