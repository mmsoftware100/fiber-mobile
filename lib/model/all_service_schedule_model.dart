class AllServiceScheduleModel {
  AllServiceScheduleModel({
    required this.id,
    required this.ticketId,
    required this.employeeId,
    required this.checkResultId,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String ticketId;
  late final String employeeId;
  late final String checkResultId;
  late final String remark;
  late final String createdAt;
  late final String updatedAt;

  AllServiceScheduleModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    ticketId = json['ticket_id'].toString();
    employeeId = json['employee_id'].toString();
    checkResultId = json['check_result_id'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
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
    return _data;
  }
}