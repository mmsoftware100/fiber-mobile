class AllServiceModel {
  AllServiceModel({
    required this.id,
    required this.ticketCheckId,
    required this.teamId,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
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

  AllServiceModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    ticketCheckId = json['ticket_check_id'].toString();
    teamId = json['team_id'].toString();
    employeeId = json['employee_id'].toString();
    startDate = json['start_date'].toString();
    endDate = json['end_date'].toString();
    remark = json['remark'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
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
    return _data;
  }
}