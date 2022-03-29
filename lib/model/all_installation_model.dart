class AllInstallationModel {
  AllInstallationModel({
    required this.id,
    required this.virtualSurveyId,
    required this.employeeId,
    required this.teamId,
    required this.remark,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
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

  AllInstallationModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    virtualSurveyId = json['virtual_survey_id'].toString();
    employeeId = json['employee_id'].toString();
    teamId = json['team_id'].toString();
    remark = json['remark'].toString();
    startDate = json['start_date'].toString();
    endDate = json['end_date'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
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
    return _data;
  }
}