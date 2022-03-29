import 'dart:convert';

import 'package:fiber_oms_flutter/model/one_order_model.dart';
import 'package:fiber_oms_flutter/model/one_virtual_survey_model.dart';
import 'package:fiber_oms_flutter/model/port_model.dart';
import 'package:fiber_oms_flutter/model/virtual_status_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditInstallationSchedulePage extends StatefulWidget {
  String id;
  EditInstallationSchedulePage(this.id);

  @override
  _EditInstallationSchedulePageState createState() => _EditInstallationSchedulePageState();
}

class _EditInstallationSchedulePageState extends State<EditInstallationSchedulePage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  TextEditingController _txtRemarkController = TextEditingController();
  late OneVirtualSurveyModel oneInstallationSchdeuleModel ;
  bool dataReturnStatus = false;
  bool getResult = false;

  String order_id = "";

  List<PortModel> portListModel = [];
  String _selectedPortID = '';
  List<String> _portIDArrayList = [];

  List<VirtualStatusModel> virtualStatusListModel = [];
  String _selectedVirtualStatusID = '';
  List<String> _virtualStatusIDArrayList = [];


  getOneInstallationSchdeule()async{
    //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    print("id is "+widget.id);
    try{
      await APIServices.Get_One_Installation_Schdeule(widget.id).then((value){


        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getOneInstallationSchdeule data is "+dataResponse.toString());
        setState(() {
          dataReturnStatus = true;
          oneInstallationSchdeuleModel = OneVirtualSurveyModel.fromJson(json.decode(value)['data']);
          print("hello "+oneInstallationSchdeuleModel.toString());

          order_id = oneInstallationSchdeuleModel.orderId;
          _selectedVirtualStatusID = oneInstallationSchdeuleModel.conditionId;
          _selectedPortID = oneInstallationSchdeuleModel.portId;
          _txtRemarkController.text = oneInstallationSchdeuleModel.remark;
        });

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<PortModel>> getPort() async{
    try{
      await APIServices.Get_Ports().then((value) {
        print(value);

        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getPort data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getPort of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              portListModel.add(PortModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(portListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(portListModel.length > 0){
            setState(() {
              portListModel.forEach((value){
                print("value.portCode is "+value.id);
                _portIDArrayList.add(value.id);
              });
              _selectedPortID = _portIDArrayList[0];
            });
          }
        });

        print("portListModel is "+portListModel.toString());

        return portListModel;
      });
      return portListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<VirtualStatusModel>> getVirtualStatus() async{
    try{
      await APIServices.Get_Virtual_Status().then((value) {
        print(value);

        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getVirtualStatus data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getVirtualStatus of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              virtualStatusListModel.add(VirtualStatusModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(virtualStatusListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(virtualStatusListModel.length > 0){
            setState(() {
              virtualStatusListModel.forEach((value){
                print("value.virtualStatusCode is "+value.id);
                _virtualStatusIDArrayList.add(value.id);
              });
              _selectedVirtualStatusID = _virtualStatusIDArrayList[0];
            });
          }
        });

        print("virtualStatusListModel is "+virtualStatusListModel.toString());

        return virtualStatusListModel;
      });
      return virtualStatusListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  void _onSelectedPortCode(String value){

    setState((){
      _selectedPortID = value;

    });
  }

  void _onSelectedVirtualStatusCode(String value){

    setState((){
      _selectedVirtualStatusID = value;

    });
  }


  EditVirtualSurvey()async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    Map mydata ={
      'id':widget.id,
      'order_id': order_id,
      'condition_id': _selectedVirtualStatusID,
      'port_id': _selectedPortID,
      'remark': _txtRemarkController.text
    };

    print(mydata);

    try{
      await APIServices.Edit_Installation_Schedule(mydata).then((response){
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
    getOneInstallationSchdeule();
    super.initState();

    getPort();
    getVirtualStatus();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Edit Installatioin Schedule"),
      ),
      body: dataReturnStatus == false ? Center(
        child: CircularProgressIndicator()):ListView(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         //color: Colors.blueAccent
          //       ),
          //       borderRadius: BorderRadius.all(
          //           Radius.circular(5.0)), // Set rounded corner radius
          //     ),
          //     child: ListView(
          //       shrinkWrap: true,
          //       physics: ScrollPhysics(),
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Center(
          //             child: Text("Virtual Servey Detail"),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: TextField(
          //             //controller: _txtSenderNameController,
          //               decoration: InputDecoration(
          //                 labelText: "Order Code",
          //                 border: OutlineInputBorder(),
          //               )
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: TextField(
          //             //controller: _txtSenderNameController,
          //               decoration: InputDecoration(
          //                 labelText: "Survey Status",
          //                 border: OutlineInputBorder(),
          //               )
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: TextField(
          //             //controller: _txtSenderNameController,
          //               decoration: InputDecoration(
          //                 labelText: "Port",
          //                 border: OutlineInputBorder(),
          //               )
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: TextField(
          //             //controller: _txtSenderNameController,
          //               decoration: InputDecoration(
          //                 labelText: "Remark",
          //                 border: OutlineInputBorder(),
          //               )
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: TextField(
          //             //controller: _txtSenderNameController,
          //               decoration: InputDecoration(
          //                 labelText: "Process",
          //                 border: OutlineInputBorder(),
          //               )
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: TextField(
          //             //controller: _txtSenderNameController,
          //               decoration: InputDecoration(
          //                 labelText: "Action",
          //                 border: OutlineInputBorder(),
          //               )
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: TextField(
          //             //controller: _txtSenderNameController,
          //               decoration: InputDecoration(
          //                 labelText: "Detail",
          //                 border: OutlineInputBorder(),
          //               )
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: MaterialButton(
          //               height: 58,
          //               minWidth: 340,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: new BorderRadius.circular(12)),
          //               color: Colors.blue,
          //               child: Text("Save",style: TextStyle(color: Colors.white),),
          //               onPressed: (){
          //               }),
          //         ),
          //
          //       ],
          //     ),
          //   ),
          // ),

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
                      child: Text("Servey Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              Text("Order Code"),
                              Text(oneInstallationSchdeuleModel.order.code)
                            ]
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Survey Status"),
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
                            items: virtualStatusListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedVirtualStatusCode(value.toString()),
                            value: _selectedVirtualStatusID,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Port"),
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
                            items: portListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedPortCode(value.toString()),
                            value: _selectedPortID,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
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
                child: Text("Submit"),
                onPressed: (){
                  EditVirtualSurvey();
                }),
          ),
        ],
      ),
    );
  }
}
