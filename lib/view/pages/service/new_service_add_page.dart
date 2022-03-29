import 'dart:convert';
import 'dart:io';

import 'package:fiber_oms_flutter/model/issue_model.dart';
import 'package:fiber_oms_flutter/model/one_service_model.dart';
import 'package:fiber_oms_flutter/model/one_service_schedule_model.dart';
import 'package:fiber_oms_flutter/model/service_status_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class NewServiceAddpage extends StatefulWidget {
  String id;
  NewServiceAddpage(this.id);

  @override
  _NewServiceAddpageState createState() => _NewServiceAddpageState();
}

class _NewServiceAddpageState extends State<NewServiceAddpage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  File? _imageODB_Output_dBmPhoto,_imageONU_SNPhoto,_imageONU_OverallPhoto,_imageCustomerHomedbmPhoto;
  final picker = ImagePicker();

  String _startDate = "Not set";
  String _endDate = "Not set";
  TextEditingController _txtRemarkController = TextEditingController();

  late OneServiceScheduleModel oneServiceModel ;
  bool dataReturnStatus = false;

  List<ServiceStatusModel> serviceStatusListModel = [];
  String _selectedServiceStatusID = '';
  List<String> _serviceStatusIDArrayList = [];

  List<IssueModel> issueListModel = [];
  String _selectedIssueID = '';
  List<String> _issueIDArrayList = [];

  getOneService()async{
    //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    print("id is "+widget.id);
    try{
      await APIServices.Get_One_Service(widget.id).then((value){


        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getOneService data is "+dataResponse.toString());
        setState(() {
          print("Ok here");
          dataReturnStatus = true;
          oneServiceModel = OneServiceScheduleModel.fromJson(dataResponse['data']);
          print("hello "+oneServiceModel.toString());
        });

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<ServiceStatusModel>> getServiceStatus() async{
    try{
      await APIServices.Get_Service_Status().then((value) {
        print(value);

        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getServiceStatus data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getServiceStatus of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              serviceStatusListModel.add(ServiceStatusModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(serviceStatusListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(serviceStatusListModel.length > 0){
            setState(() {
              serviceStatusListModel.forEach((value){
                print("value.serviceStatusCode is "+value.id);
                _serviceStatusIDArrayList.add(value.id);
              });
              _selectedServiceStatusID = _serviceStatusIDArrayList[0];
            });
          }
        });

        print("serviceStatusListModel is "+serviceStatusListModel.toString());

        return serviceStatusListModel;
      });
      return serviceStatusListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<IssueModel>> getIssue() async{
    try{
      await APIServices.Get_Issues().then((value) {
        print(value);

        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getIssue data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getIssue of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              issueListModel.add(IssueModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(issueListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(issueListModel.length > 0){
            setState(() {
              issueListModel.forEach((value){
                print("value.issueCode is "+value.id);
                _issueIDArrayList.add(value.id);
              });
              _selectedIssueID = _issueIDArrayList[0];
            });
          }
        });

        print("issueListModel is "+issueListModel.toString());

        return issueListModel;
      });
      return issueListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  void _onSelectedServiceStatusCode(String value){

    setState((){
      _selectedServiceStatusID = value;

    });
  }

  void _onSelectedIssueCode(String value){

    setState((){
      _selectedIssueID = value;

    });
  }

  _getStartDate(){
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        minTime: DateTime(2000, 1, 1),
        maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
          print('confirm $date');
          _startDate = '${date.year}-${date.month}-${date.day}';
          setState(() {});
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  _getEndDate(){
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        minTime: DateTime(2000, 1, 1),
        maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
          print('confirm $date');
          _endDate = '${date.year}-${date.month}-${date.day}';
          setState(() {});
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void _chooseODB_Output_dBmPhotoDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Take Camera"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getODB_Output_dBmPhotoFromCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getODB_Output_dBmPhotoFromGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getODB_Output_dBmPhotoFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageODB_Output_dBmPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getODB_Output_dBmPhotoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageODB_Output_dBmPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _chooseONU_SNPhotoDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Take Camera"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getONU_SNPhotoFromCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getONU_SNPhotoFromGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getONU_SNPhotoFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageONU_SNPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getONU_SNPhotoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageONU_SNPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _chooseONU_OverallPhotoDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Take Camera"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getONU_OverallPhotoCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getONU_OverallPhotoGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getONU_OverallPhotoCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageONU_OverallPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getONU_OverallPhotoGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageONU_OverallPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _chooseCustomerHomedbmPhotoDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Take Camera"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getCustomerHomedbmPhotoFromCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getCustomerHomedbmPhotoFromGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getCustomerHomedbmPhotoFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageCustomerHomedbmPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getCustomerHomedbmPhotoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageCustomerHomedbmPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  CreateService()async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    Map mydata ={
      'serviceschedule_id': widget.id,
      'issue_id': _selectedIssueID,
      'status_id': _selectedServiceStatusID,
      'start_date': _startDate,
      'end_date': _endDate,
      'output_dbm_image': _imageODB_Output_dBmPhoto != null ? "true" : "false",
      'output_dbm_file': _imageODB_Output_dBmPhoto != null ? _imageODB_Output_dBmPhoto?.path : '',
      'onu_sn_image': _imageONU_SNPhoto != null ? "true" : "false",
      'onu_sn_file': _imageONU_SNPhoto != null ? _imageONU_SNPhoto?.path : '',
      'onu_overall_image': _imageONU_OverallPhoto != null ? "true" : "false",
      'onu_overall_file': _imageONU_OverallPhoto != null ? _imageONU_OverallPhoto?.path : '',
      'home_dbm_image': _imageCustomerHomedbmPhoto != null ? "true" : "false",
      'home_dbm_file': _imageCustomerHomedbmPhoto != null ? _imageCustomerHomedbmPhoto?.path : '',
    };

    print(mydata);

    try{
      await APIServices.Create_Service(mydata).then((response){
        Navigator.of(context,rootNavigator: true).pop();//close the dialoge
        Map<String, dynamic> dataResponse = jsonDecode(response);
        //List<dynamic> dataList =  dataResponse['data'];


        print("dataResponse is "+dataResponse.toString());

        if(dataResponse['status'].toString() == "true"){


          print("hello baby");
          Map<String, dynamic> dlist = json.decode(response);

          print(dlist);
          // NewParcelModel newParcelModel = NewParcelModel.fromJson(json.decode(response));
          _succefllyInserted();


        }
        else{
          _faildInsert();
        }

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  void _succefllyInserted() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text("Success"),
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _faildInsert() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text("Sorry"),
          title: Text("Faild"),
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOneService();
    getServiceStatus();
    getIssue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("New Service"),
      ),
      body:dataReturnStatus == false ? Center(
        child: CircularProgressIndicator(),
      ): ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  //color: Colors.blueAccent
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0)), // Set rounded corner radius
              ),
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Ticket Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order Code"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.ticketcheck.ticket.order.code),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Package Type"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.ticketcheck.ticket.order.package.packagetype.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Issue"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.ticketcheck.ticket.issue.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Remark"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.ticketcheck.ticket.remark),
                                ],
                              )
                            ]
                        ),

                      ],
                    ),
                  )
                ],
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  //color: Colors.blueAccent
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0)), // Set rounded corner radius
              ),
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Ticket Check Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order Code"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.ticketcheck.ticket.order.code),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Checking Result"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.ticketcheck.checkresult.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Remark"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.ticketcheck.remark),
                                ],
                              )
                            ]
                        ),

                      ],
                    ),
                  )
                ],
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  //color: Colors.blueAccent
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0)), // Set rounded corner radius
              ),
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Schedule Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order Code"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.ticketcheck.ticket.order.code),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Team"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.team.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Payment"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.startDate),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("End Date"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.endDate),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Remark"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneServiceModel.remark),
                                ],
                              )
                            ]
                        ),

                      ],
                    ),
                  )
                ],
              ),

            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  //color: Colors.blueAccent
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0)), // Set rounded corner radius
              ),
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Service Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Status"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          //color: Colors.blueAccent
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)), // Set rounded corner radius
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: serviceStatusListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedServiceStatusCode(value.toString()),
                            value: _selectedServiceStatusID,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Issue"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          //color: Colors.blueAccent
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)), // Set rounded corner radius
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: issueListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedIssueCode(value.toString()),
                            value: _selectedIssueID,
                          ),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () {
                      _getStartDate();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Colors.teal,
                                    ),
                                    Text(
                                      " $_startDate",
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "  Change",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () {
                      _getEndDate();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Colors.teal,
                                    ),
                                    Text(
                                      " $_endDate",
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "  Change",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtRemarkController,
                        decoration: InputDecoration(
                          labelText: "Remark",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Center(
                    child: _imageODB_Output_dBmPhoto == null
                        ? Text('No ODB Output dBmPhoto selected.')
                        : Image.file(_imageODB_Output_dBmPhoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose ODB Output dBmPhoto")),
                        onPressed: (){
                          _chooseODB_Output_dBmPhotoDialog();
                        },
                      ),
                    ),

                  ),
                  Center(
                    child: _imageONU_SNPhoto == null
                        ? Text('No ONU SN Photo selected.')
                        : Image.file(_imageONU_SNPhoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose ONU SN Photo")),
                        onPressed: (){
                          _chooseONU_SNPhotoDialog();
                        },
                      ),
                    ),

                  ),
                  Center(
                    child: _imageONU_OverallPhoto == null
                        ? Text('No ONU Overall Photo selected.')
                        : Image.file(_imageONU_OverallPhoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose ONU Overall Photo")),
                        onPressed: (){
                          _chooseONU_OverallPhotoDialog();
                        },
                      ),
                    ),

                  ),
                  Center(
                    child: _imageCustomerHomedbmPhoto == null
                        ? Text('No Customer Homedbm Photo selected.')
                        : Image.file(_imageCustomerHomedbmPhoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose Customer Homedbm Photo")),
                        onPressed: (){
                          _chooseCustomerHomedbmPhotoDialog();
                        },
                      ),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        height: 58,
                        minWidth: 340,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(12)),
                        color: Colors.blue,
                        child: Text("Save",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          CreateService();
                        }),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
