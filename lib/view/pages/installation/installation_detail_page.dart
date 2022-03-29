import 'dart:convert';
import 'dart:io';

import 'package:fiber_oms_flutter/model/install_status_model.dart';
import 'package:fiber_oms_flutter/model/one_installation_model.dart';
import 'package:fiber_oms_flutter/model/one_installation_schedule_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class InstallationDetailPage extends StatefulWidget {
String id;
InstallationDetailPage(this.id);

  @override
  _InstallationDetailPageState createState() => _InstallationDetailPageState();
}

class _InstallationDetailPageState extends State<InstallationDetailPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  File? _imageODBphoto,_imageRouterphoto;
  final picker = ImagePicker();

  late OneInstallationScheduleModel oneInstallationModel ;
  bool dataReturnStatus = false;

  List<InstallStatusModel> installStatusListModel = [];
  String _selectedInstallStatusID = '';
  List<String> _installStatusIDArrayList = [];

  TextEditingController _txtonu_idController = TextEditingController();
  TextEditingController _txtonu_snController = TextEditingController();
  TextEditingController _txtonb_nameController = TextEditingController();
  TextEditingController _txtonb_locationController = TextEditingController();
  TextEditingController _txtuser_portController = TextEditingController();
  TextEditingController _txtcableController = TextEditingController();
  TextEditingController _txtoutput_signalController = TextEditingController();
  TextEditingController _txtinput_signalput_signalController = TextEditingController();

  TextEditingController _txtRemarkController = TextEditingController();

  String _startDate = "Not set";
  String _endDate = "Not set";

  getOneInstallation()async{
    //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    print("id is "+widget.id);
    try{
      await APIServices.Get_One_Installation(widget.id).then((value){


        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getOneInstallation data is "+dataResponse.toString());
        setState(() {
          dataReturnStatus = true;
          oneInstallationModel = OneInstallationScheduleModel.fromJson(json.decode(value)['data']);
          print("hello "+oneInstallationModel.toString());
        });

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<InstallStatusModel>> getInstallStatus() async{
    try{
      await APIServices.Get_Install_Status().then((value) {
        print(value);

        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getInstallStatus data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getInstallStatus of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              installStatusListModel.add(InstallStatusModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(installStatusListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(installStatusListModel.length > 0){
            setState(() {
              installStatusListModel.forEach((value){
                print("value.installStatusCode is "+value.id);
                _installStatusIDArrayList.add(value.id);
              });
              _selectedInstallStatusID = _installStatusIDArrayList[0];
            });
          }
        });

        print("installStatusListModel is "+installStatusListModel.toString());

        return installStatusListModel;
      });
      return installStatusListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  void _onSelectedInstallStatusCode(String value){

    setState((){
      _selectedInstallStatusID = value;

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


  void _chooseODBphotoDialog() {
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
                  getODBphotoFromCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getODBphotoFromGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getODBphotoFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageODBphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getODBphotoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageODBphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _chooseRouterphotoDialog() {
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
                  getRouterphotoFromCamera();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Choose from gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  getRouterphotoFromGallery();
                },
              ),
            )
          ],
        );
      },
    );
  }

  Future getRouterphotoFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 25,);

    setState(() {
      if (pickedFile != null) {
        _imageRouterphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getRouterphotoFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 25,);

    setState(() {
      //_image = image;
      if (pickedFile != null) {
        _imageRouterphoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  CreateInstallation()async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    Map mydata ={
      //'installation_id': '',
      'installationschedule_id': widget.id,
      'remark': _txtRemarkController.text,
      'status_id': _selectedInstallStatusID,
      'onu_id': _txtonu_idController.text,
      'onu_sn': _txtonu_snController.text,
      'onb_name': _txtonb_nameController.text,
      'onb_location': _txtonb_locationController.text,
      'user_port': _txtuser_portController.text,
      'cable': _txtcableController.text,
      'output_signal': _txtoutput_signalController.text,
      'input_signal': _txtinput_signalput_signalController.text,
      'start_date': _startDate,
      'end_date': _endDate,
      'odb_image': _imageODBphoto != null ? "true" : "false",
      'odb_file': _imageODBphoto != null ? _imageODBphoto?.path : '',
      'router_image': _imageRouterphoto != null ? "true" : "false",
      'router_file': _imageRouterphoto != null ? _imageRouterphoto?.path : '',
    };

    print(mydata);

    try{
      await APIServices.Create_Installation(mydata).then((response){
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
    getOneInstallation();
    getInstallStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Installation Detail"),
      ),
      body: dataReturnStatus == false ? Center(
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
                      child: Text("Order Detail"),
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
                                  Text("Package Type"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.package.packagetype.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Package"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.package.name),
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
                                  Text(oneInstallationModel.virtualsurvey.order.payment.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Plan"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.planId),
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
                                  Text(oneInstallationModel.virtualsurvey.order.remark),
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
                      child: Text("Address"),
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
                                  Text("State/Division"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.address.state.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Township/Town"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.address.town.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ward"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.address.ward),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Street"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.address.street),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Home"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.address.home),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Floor"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.address.floor),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Room"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.address.room),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Lat"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.address.lat),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Lng"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.address.lng),
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
                      child: Text("Customer Detail"),
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
                                  Text("Name"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("NRC"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.nrc),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.email),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Contact"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.phones[0].phone.toString()),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Alternative Contact"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.customer.phones[1].phone.toString()),
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
                      child: Text("Survey Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: [
                        // TableRow(
                        //     children: [
                        //       Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text("ID"),
                        //         ],
                        //       ),
                        //       Column(
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         children: [
                        //           Text(oneInstallationModel.id),
                        //         ],
                        //       )
                        //     ]
                        // ),

                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order code"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.code),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Survey Status"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.condition.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Port"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.port.name),
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
                                  Text(oneInstallationModel.virtualsurvey.remark),
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
                      child: Text("Installation Schedule Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: [
                        // TableRow(
                        //     children: [
                        //       Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text("ID"),
                        //         ],
                        //       ),
                        //       Column(
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         children: [
                        //           Text(oneInstallationModel.id),
                        //         ],
                        //       )
                        //     ]
                        // ),

                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order code"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.virtualsurvey.order.code),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Team Name"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.team.name),
                                ],
                              )
                            ]
                        ),
                        TableRow(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Start Date"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(oneInstallationModel.startDate),
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
                                  Text(oneInstallationModel.endDate),
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
                                  Text(oneInstallationModel.remark),
                                ],
                              )
                            ]
                        )
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
                      child: Text("Installation Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Install Status"),
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
                            items: installStatusListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedInstallStatusCode(value.toString()),
                            value: _selectedInstallStatusID,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtonu_idController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "onu_id",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtonu_snController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "onu_sn",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtonb_nameController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "onb_name",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtonb_locationController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "onb_location",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtuser_portController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "user_port",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtcableController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "cable",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtoutput_signalController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "output_signal",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtinput_signalput_signalController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "input_signal",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                    child: _imageODBphoto == null
                        ? Text('No ODB photo selected.')
                        : Image.file(_imageODBphoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose ODB photo")),
                        onPressed: (){
                          _chooseODBphotoDialog();
                        },
                      ),
                    ),

                  ),
                  Center(
                    child: _imageRouterphoto == null
                        ? Text('No Routerphoto selected.')
                        : Image.file(_imageRouterphoto!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: RaisedButton(
                        child: Container(
                            height: 20,
                            child: Text("Choose Routerphoto")),
                        onPressed: (){
                          _chooseRouterphotoDialog();
                        },
                      ),
                    ),

                  ),
                ],
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
                color: Color(0xFFF7CA18),
                child: Text("Save"),
                onPressed: (){
                  CreateInstallation();
                }),
          ),
        ],
      ),
    );
  }
}
