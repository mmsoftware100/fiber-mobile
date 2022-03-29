class AllVirtualSurveyModel {
  AllVirtualSurveyModel({
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

  AllVirtualSurveyModel.fromJson(Map<String, dynamic> json){
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
    return _data;
  }
}