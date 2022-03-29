
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:http_parser/http_parser.dart';

  // const String domain = "http://192.168.1.104:8080/FOPM/public/api/v1/";
  // const String domain = "http://192.168.1.103:8080/FOPM/public/api/v1/";
  const String domain = "http://192.168.137.196:8080/FOPM/public/api/v1/";
  // const String domain = "http://103.154.241.143/fiber/public/api/v1/";

 //const String domain = "http://192.168.137.107:8080/FOPM/public/api/v1/";

class URLs{
  static const String get_state_division_URL =domain+"states";
  static const String get_town_URL =domain+"towns";
  static const String get_package_types_URL =domain+"packagetypes";
  static const String get_packages_URL =domain+"packages";
  static const String get_payments_URL =domain+"payments";
  static const String get_plans_URL =domain+"plans";
  static const String get_ports_URL =domain+"ports";
  static const String get_teams_URL =domain+"teams";
  static const String get_virtual_status_URL =domain+"conditions";
  static const String get_install_status_URL =domain+"statuses";
  static const String get_issues_URL =domain+"issues";
  static const String get_check_result_URL =domain+"checkresults";
  static const String get_service_status_URL = domain+"statuses";

  static const String get_all_orders_URL =domain+"orders";
  static const String create_order_URL =domain+"orders";

  static const String get_all_virtual_survey_URL =domain+"virtualsurveys";

  static const String get_all_installationschedules_URL =domain+"installationschedules";

  static const String get_all_installations_URL =domain+"installations";
  static const String create_installations_URL =domain+"installations";

  static const String get_all_services_URL =domain+"services";

  static const String get_all_ticekt_check_URL =domain+"ticketchecks";
  static const String get_all_ticekt_URL =domain+"tickets";
  static const String get_all_Service_Schedule_URL =domain+"serviceschedules";


}

class APIServices{

  static Future<dynamic> Get_States()async{

    final response = await http.get(Uri.parse(URLs.get_state_division_URL));
    print("Get_State response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_Towns()async{

    final response = await http.get(Uri.parse(URLs.get_town_URL));
    print("Get_Towns response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_PackageTypes()async{

    final response = await http.get(Uri.parse(URLs.get_package_types_URL));
    print("Get_PackageTypes response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_Packages()async{

    final response = await http.get(Uri.parse(URLs.get_packages_URL));
    print("Get_Packages response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_Payments()async{

    final response = await http.get(Uri.parse(URLs.get_payments_URL));
    print("Get_Payments response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_Plans()async{

    final response = await http.get(Uri.parse(URLs.get_plans_URL));
    print("Get_Plans response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_Ports()async{

    final response = await http.get(Uri.parse(URLs.get_ports_URL));
    print("Get_Ports response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_Teams()async{

    final response = await http.get(Uri.parse(URLs.get_teams_URL));
    print("Get_Teams response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_Virtual_Status()async{

    final response = await http.get(Uri.parse(URLs.get_virtual_status_URL));
    print("Get_Virtual_Status response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_Install_Status()async{

    final response = await http.get(Uri.parse(URLs.get_install_status_URL));
    print("Get_Install_Status response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_Issues()async{

    final response = await http.get(Uri.parse(URLs.get_issues_URL));
    print("Get_Issues response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_CheckResult()async{

    final response = await http.get(Uri.parse(URLs.get_check_result_URL));
    print("Get_CheckResult response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_Service_Status()async{

    final response = await http.get(Uri.parse(URLs.get_service_status_URL));
    print("Get_Service_Status response.statusCode ==200 is "+response.body);
    return response.body;
  }

  static Future<dynamic> Get_All_Orders()async{

    print("hello my love");

    final response = await http.get(Uri.parse(URLs.get_all_orders_URL));
    print("Get_All_Orders response.statusCode ==200 is "+response.body);
    return response.body;
    // if(response.statusCode ==200){
    //
    //   print("Get_State response.statusCode ==200 is "+response.body);
    //   return response.body;
    // }
    // else{
    //   print("Get_State else response.statusCode !=200 is "+response.body);
    //   response.body;
    // }
  }
  static Future<dynamic> Get_Next_Orders_Page(String page)async{

    print("hello my Get_Next_Parcels_Page");

    final response = await http.get(Uri.parse(URLs.get_all_orders_URL+"/"+page),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_Next_Orders_Page response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_One_Order(String id)async{

    final response = await http.get(Uri.parse(URLs.get_all_orders_URL+"/"+id));
    print("Get_One_Order response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Create_Order(body,var _imgNRCfrontphoto,var _imgNRCBackphoto,var _imgContractphoto,var _imgTranscationphoto)async{

    var request = http.MultipartRequest('POST', Uri.parse(URLs.create_order_URL));
    request.fields.addAll({
      'customer_id': body['customer_id'],
      'name': body['name'],
      'nrc': body['nrc'],
      'email': body['email'],
      'phones[0][id]': body['phones[0][id]'],
      'phones[0][phone]': body['phones[0][phone]'],
      'phones[1][id]': body['phones[1][id]'],
      'phones[1][phone]': body['phones[1][phone]'],
      'town': body['town'],
      'ward': body['ward'],
      'street': body['street'],
      'home': body['home'],
      'floor': body['floor'],
      'room': body['room'],
      'lat': body['lat'],
      'lng': body['lng'],
      'package': body['package'],
      'payment': body['payment'],
      'plan': body['plan'],
      'remark': body['remark'],
      'code': body['code'],
      'nrc_front_image_id': body['nrc_front_image_id'],
      'nrc_front_image': body['nrc_front_image'],
      'nrc_back_image_id': body['nrc_back_image_id'],
      'nrc_back_image': body['nrc_back_image'],
      'contract_image_id': body['contract_image_id'],
      'contract_image': body['contract_image'],
      'transcation_image_id': body['transcation_image_id'],
      'transcation_image': body['transcation_image']
    });
    request.files.add(await http.MultipartFile.fromPath('nrc_front_file', body['nrc_front_file']));
    request.files.add(await http.MultipartFile.fromPath('nrc_back_file', body['nrc_back_file']));
    request.files.add(await http.MultipartFile.fromPath('contract_file', body['contract_file']));
    request.files.add(await http.MultipartFile.fromPath('transcation_file', body['transcation_file']));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print(res.body);
    return res.body;
  }
  static Future<dynamic> Edit_Order(body,var _imgNRCfrontphoto,var _imgNRCBackphoto,var _imgContractphoto,var _imgTranscationphoto,String orderID)async{

    var request = http.MultipartRequest('POST', Uri.parse(URLs.create_order_URL+"/"+orderID));
    request.fields.addAll({
      'customer_id': body['customer_id'].toString(),
      'name': body['name'].toString(),
      'nrc': body['nrc'].toString(),
      'email': body['email'].toString(),
      'phones[0][id]': body['phones[0][id]'].toString(),
      'phones[0][phone]': body['phones[0][phone]'].toString(),
      'phones[1][id]': body['phones[1][id]'].toString(),
      'phones[1][phone]': body['phones[1][phone]'].toString(),
      'town': body['town'].toString(),
      'ward': body['ward'].toString(),
      'street': body['street'].toString(),
      'home': body['home'].toString(),
      'floor': body['floor'].toString(),
      'room': body['room'].toString(),
      'lat': body['lat'].toString(),
      'lng': body['lng'].toString(),
      'package': body['package'].toString(),
      'payment': body['payment'].toString(),
      'plan': body['plan'].toString(),
      'remark': body['remark'].toString(),
      'code': body['code'].toString(),
      'nrc_front_image_id': body['nrc_front_image_id'].toString(),
      'nrc_front_image': body['nrc_front_image'].toString(),
      'nrc_back_image_id': body['nrc_back_image_id'].toString(),
      'nrc_back_image': body['nrc_back_image'].toString(),
      'contract_image_id': body['contract_image_id'].toString(),
      'contract_image': body['contract_image'].toString(),
      'transcation_image_id': body['transcation_image_id'].toString(),
      'transcation_image': body['transcation_image'].toString(),
      'customeraddress_id': body['customeraddress_id'].toString(),
      '_method': 'put'
    });
    // request.files.add(await http.MultipartFile.fromPath('nrc_front_file', body['nrc_front_file']));
    // request.files.add(await http.MultipartFile.fromPath('nrc_back_file', body['nrc_back_file']));
    // request.files.add(await http.MultipartFile.fromPath('contract_file', body['contract_file']));
    // request.files.add(await http.MultipartFile.fromPath('transcation_file', body['transcation_file']));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print("ediet is "+res.body);
    return res.body;
  }
  static Future<dynamic> Delete_Order(String id)async{

    var request = http.Request('DELETE', Uri.parse(URLs.get_all_orders_URL+'/$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    return res.body;
  }


  static Future<dynamic> Get_All_Virtual_Surveys()async{

    final response = await http.get(Uri.parse(URLs.get_all_virtual_survey_URL));
    print("Get_All_Virtual_Surveys response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_Next_Virtual_Surveys_Page(String page)async{

    print("hello my Get_Next_Virtual_Surveys_Page");

    final response = await http.get(Uri.parse(URLs.get_all_virtual_survey_URL+"/"+page),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_Next_Virtual_Surveys_Page response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_One_Virtual_Survey(String id)async{

    print("hello my Get_One_Virtual_Surveys");

    final response = await http.get(Uri.parse(URLs.get_all_orders_URL+"/"+id),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_One_Virtual_Surveys response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Create_Virtual_Survey(body)async{

    print("hello my Update_Virtual_Survey");

    var request = http.MultipartRequest('POST', Uri.parse(URLs.get_all_virtual_survey_URL));
    request.fields.addAll({
      'order_id': body['order_id'],
      'remark': body['remark'],
      'condition_id': body['condition_id'],
      'port_id': body['port_id']
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    return response.stream.bytesToString();
  }
  static Future<dynamic> Delete_Virtual_Survey(String id)async{

    var request = http.Request('DELETE', Uri.parse(URLs.get_all_virtual_survey_URL+'/$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    return res.body;
  }


  static Future<dynamic> Get_All_Installation_Schedule()async{

    final response = await http.get(Uri.parse(URLs.get_all_installationschedules_URL));
    print("Get_All_Installation_Schedule response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_Next_Installation_Schedule_Page(String page)async{

    print("hello my Get_Next_Installation_Schedule_Page");

    final response = await http.get(Uri.parse(URLs.get_all_installationschedules_URL+"/"+page),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_Next_Installation_Schedule_Page response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_One_Installation_Schdeule(String id)async{

    final response = await http.get(Uri.parse(URLs.get_all_virtual_survey_URL+"/"+id));
    print("Get_One_Installation_Schdeule response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Create_Installation_Schedule(body)async{

    print("hello my Create_Installation_Schedule");

    var request = http.MultipartRequest('POST', Uri.parse(URLs.get_all_installationschedules_URL));
    request.fields.addAll({
      'virtualsurvey_id': body['virtualsurvey_id'],
      'remark': body['remark'],
      'team_id': body['team_id'],
      'start_date': body['start_date'],
      'end_date': body['end_date']
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    return response.stream.bytesToString();
  }
  static Future<dynamic> Edit_Installation_Schedule(body)async{
    String id = body['id'];
    String order_id = body['order_id'];
    String remark = body['remark'];
    String condition_id = body['condition_id'];
    String port_id = body['port_id'];
    var request = http.Request('PUT', Uri.parse(URLs.get_all_virtual_survey_URL+'/$id?order_id=$order_id&remark=$remark&condition_id=$condition_id&port_id=$port_id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print("edit i s is "+res.body);
    return res.body;
  }
  static Future<dynamic> Delete_Installation_Schedule(String id)async{

    var request = http.Request('DELETE', Uri.parse(URLs.get_all_installationschedules_URL+'/$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    return res.body;
  }




  static Future<dynamic> Get_All_Installation()async{

    final response = await http.get(Uri.parse(URLs.get_all_installations_URL));
    print("Get_All_Installation response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_Next_Installation_Page(String page)async{

    print("hello my Get_Next_Installation_Page");

    final response = await http.get(Uri.parse(URLs.get_all_installations_URL+"/"+page),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_Next_Installation_Page response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_One_Installation(String id)async{

    final response = await http.get(Uri.parse(URLs.get_all_installationschedules_URL+"/"+id));
    print("Get_One_Installation response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Create_Installation(body)async{

    print("This is Create_Installation");

    var request = http.MultipartRequest('POST', Uri.parse(URLs.create_installations_URL));
    request.fields.addAll({
      //'installation_id': body['installation_id'],
      'installationschedule_id': body['installationschedule_id'].toString(),
      'remark': body['remark'].toString(),
      'status_id': body['status_id'].toString(),
      'onu_id': body['onu_id'].toString(),
      'onu_sn': body['onu_sn'].toString(),
      'onb_name': body['onb_name'].toString(),
      'onb_location': body['onb_location'].toString(),
      'user_port': body['user_port'].toString(),
      'cable': body['cable'].toString(),
      'output_signal': body['output_signal'].toString(),
      'input_signal': body['input_signal'].toString(),
      'start_date': body['start_date'].toString(),
      'end_date': body['end_date'].toString(),
      'odb_image': body['odb_image'].toString(),
      'odb_file': body['odb_file'].toString(),
      'router_image': body['router_image'].toString(),
      'router_file': body['router_file'].toString(),
    });
    request.files.add(await http.MultipartFile.fromPath('odb_file', body['odb_file'].toString(),));
    request.files.add(await http.MultipartFile.fromPath('router_file', body['router_file'].toString(),));

    http.StreamedResponse response = await request.send();

    print("okey send");

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("Ok babay");
    }
    else {
      print("this is error "+response.reasonPhrase.toString());
    }
    final res = await http.Response.fromStream(response);
    print(res.body);
    return res.body;
  }
  static Future<dynamic> Edit_Installation(body)async{
    String id = body['id'];
    String team_id = body['team_id'];
    String remark = body['remark'];
    String start_date = body['start_date'];
    String end_date = body['end_date'];
    var request = http.Request('PUT', Uri.parse(URLs.get_all_installationschedules_URL+'/$id?remark=$remark&team_id=$team_id&start_date=$start_date&end_date=$end_date'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print("edit i is "+res.body);
    return res.body;
  }
  static Future<dynamic> Delete_Installation(String id)async{

    var request = http.Request('DELETE', Uri.parse(URLs.get_all_installations_URL+'/$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    return res.body;
  }



  static Future<dynamic> Get_All_Services()async{

    final response = await http.get(Uri.parse(URLs.get_all_services_URL));
    print("Get_All_Services response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_Next_Services_Page(String page)async{

    print("hello my Get_Next_Services_Page");

    final response = await http.get(Uri.parse(URLs.get_all_services_URL+"?page="+page),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_Next_Services_Page response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_One_Service(String sID)async{

    print("hello my Get_One_Service");

    final response = await http.get(Uri.parse(URLs.get_all_Service_Schedule_URL+"/"+sID),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_One_Service response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Create_Service(body)async{

    print("This is Create_Service");

    var request = http.MultipartRequest('POST', Uri.parse(URLs.get_all_services_URL));
    request.fields.addAll({
      'serviceschedule_id': body['serviceschedule_id'],
      'issue_id': body['issue_id'],
      'status_id': body['status_id'],
      'start_date': body['start_date'],
      'end_date': body['end_date'],
      'output_dbm_image': body['output_dbm_image'],
      'output_dbm_file': body['output_dbm_file'],
      'onu_sn_image': body['onu_sn_image'],
      'onu_sn_file': body['onu_sn_file'],
      'onu_overall_image': body['onu_overall_image'],
      'onu_overall_file': body['onu_overall_file'],
      'home_dbm_image': body['home_dbm_image'],
      'home_dbm_file': body['home_dbm_file'],
    });
    request.files.add(await http.MultipartFile.fromPath('output_dbm_file', body['output_dbm_file'].toString(),));
    request.files.add(await http.MultipartFile.fromPath('onu_sn_file', body['onu_sn_file'].toString(),));
    request.files.add(await http.MultipartFile.fromPath('onu_overall_file', body['onu_overall_file'].toString(),));
    request.files.add(await http.MultipartFile.fromPath('home_dbm_file', body['home_dbm_file'].toString(),));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print("this is error "+response.reasonPhrase.toString());
    }
    final res = await http.Response.fromStream(response);
    print(res.body);
    return res.body;
  }


  static Future<dynamic> Get_All_TicketCheck()async{

    final response = await http.get(Uri.parse(URLs.get_all_ticekt_check_URL));
    print("Get_All_TicketCheck response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_Next_Ticket_Check_Page(String page)async{

    print("hello my Get_Next_Ticket_Check_Page");

    final response = await http.get(Uri.parse(URLs.get_all_ticekt_check_URL+"/"+page),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_Next_Ticket_Check_Page response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Create_Ticket_Check(body)async{

    var request = http.MultipartRequest('POST', Uri.parse(URLs.get_all_ticekt_check_URL));
    request.fields.addAll({
      'ticket_id': body['ticket_id'],
      'checkresult_id': body['checkresult_id'],
      'remark': body['remark']
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print(res.body);
    return res.body;
  }
  static Future<dynamic> Get_One_TicketCheck(String id)async{

    print("hello my Get_One_TicketCheck");

    final response = await http.get(Uri.parse(URLs.get_all_ticekt_check_URL+"/$id"),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_One_TicketCheck response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Edit_TicketCheck(body)async{

    String id = body['id'];
    String checkresult_id = body['checkresult_id'];
    String remark = body['remark'];

    var request = http.Request('PUT', Uri.parse(URLs.get_all_ticekt_check_URL+'/$id?checkresult_id=$checkresult_id&remark=$remark'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print(res.body);
    return res.body;
  }
  static Future<dynamic> Delete_TicketCheck(String id)async{

    var request = http.Request('DELETE', Uri.parse(URLs.get_all_ticekt_check_URL+'/$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    return res.body;
  }



  static Future<dynamic> Get_All_Ticket()async{

    final response = await http.get(Uri.parse(URLs.get_all_ticekt_URL));
    print("Get_All_Ticket response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_Next_Ticket_Page(String page)async{

    print("hello my Get_Next_Ticket_Page");

    final response = await http.get(Uri.parse(URLs.get_all_ticekt_URL+"/"+page),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_Next_Ticket_Page response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_One_Ticket(String id)async{

    print("hello my Get_One_Ticket");

    final response = await http.get(Uri.parse(URLs.get_all_ticekt_URL+"/$id"),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_One_Ticket response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Create_Ticket(body)async{

    var request = http.MultipartRequest('POST', Uri.parse(URLs.get_all_ticekt_URL));
    request.fields.addAll({
      'order_code': body['order_code'],
      'issue_id': body['issue_id'],
      'remark': body['remark']
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print(res.body);
    return res.body;
  }
  static Future<dynamic> Edit_Ticket(body)async{
    String id = body['id'];
    String order_code = body['order_code'];
    String issue_id = body['issue_id'];
    String remark = body['remark'];

    var request = http.MultipartRequest('PUT', Uri.parse(URLs.get_all_ticekt_URL+'/$id?order_code=$order_code&issue_id=$issue_id&remark=$remark'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print("edit "+res.body);
    return res.body;
  }
  static Future<dynamic> Delete_Ticket(String id)async{

    var request = http.Request('DELETE', Uri.parse(URLs.get_all_ticekt_URL+'/$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    return res.body;
  }


  static Future<dynamic> Get_All_Service_Schedule()async{

    final response = await http.get(Uri.parse(URLs.get_all_Service_Schedule_URL));
    print("Get_All_Service_Schedule response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_Next_Service_Schedule_Page(String page)async{

    print("hello my Get_Next_Service_Schedule_Page");

    final response = await http.get(Uri.parse(URLs.get_all_Service_Schedule_URL+"/"+page),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_Next_Service_Schedule_Page response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Get_One_Service_Schedule(String sID)async{

    print("hello my Get_One_Service_Schedule");

    final response = await http.get(Uri.parse(URLs.get_all_ticekt_check_URL+"/"+sID),
      // headers: {
      //   'Authorization' : 'Bearer $token'
      // },
    );
    print("Get_One_Service_Schedule response.statusCode ==200 is "+response.body);
    return response.body;
  }
  static Future<dynamic> Create_Service_Schedule(body)async{

    var request = http.MultipartRequest('POST', Uri.parse(URLs.get_all_Service_Schedule_URL));
    request.fields.addAll({
      'ticketcheck_id': body['ticketcheck_id'],
      'team_id': body['team_id'],
      'start_date': body['start_date'],
      'end_date': body['end_date'],
      'remark': body['remark']
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print(res.body);
    return res.body;
  }
  static Future<dynamic> Edit_Service_Schedule(body)async{

    String id = body['id'];
    String team_id = body['team_id'];
    String start_date = body['start_date'];
    String end_date = body['end_date'];
    String remark = body['remark'];

    var request = http.Request('PUT', Uri.parse(URLs.get_all_Service_Schedule_URL+'/$id?team_id=$team_id&start_date=$start_date&end_date=$end_date&remark=$remark'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    print(res.body);
    return res.body;
  }
  static Future<dynamic> Delete_Service_Schedule(String id)async{

    var request = http.Request('DELETE', Uri.parse(URLs.get_all_Service_Schedule_URL+'/$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    final res = await http.Response.fromStream(response);
    return res.body;
  }



}