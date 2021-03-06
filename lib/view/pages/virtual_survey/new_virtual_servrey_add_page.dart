import 'dart:convert';

import 'package:fiber_oms_flutter/model/one_order_model.dart';
import 'package:fiber_oms_flutter/model/one_virtual_survey_model.dart';
import 'package:fiber_oms_flutter/model/port_model.dart';
import 'package:fiber_oms_flutter/model/virtual_status_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewVirtulServeyAddPage extends StatefulWidget {
  String id;
  NewVirtulServeyAddPage(this.id);

  @override
  _NewVirtulServeyAddPageState createState() => _NewVirtulServeyAddPageState();
}

class _NewVirtulServeyAddPageState extends State<NewVirtulServeyAddPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  TextEditingController _txtRemarkController = TextEditingController();
  late OneOrderModel oneOrderModel ;
  bool dataReturnStatus = false;
  bool getResult = false;

  List<PortModel> portListModel = [];
  String _selectedPortID = '';
  List<String> _portIDArrayList = [];

  List<VirtualStatusModel> virtualStatusListModel = [];
  String _selectedVirtualStatusID = '';
  List<String> _virtualStatusIDArrayList = [];

  getOneOrder()async{
    //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    print("id is "+widget.id);
    try{
      await APIServices.Get_One_Virtual_Survey(widget.id).then((value){


        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getOneOrder data is "+dataResponse.toString());
        setState(() {
          dataReturnStatus = true;
          oneOrderModel = OneOrderModel.fromJson(json.decode(value)['data']);
          print("hello "+oneOrderModel.toString());
          getResult = true;
        });

      });
    }
    catch (Exc) {
      print("Exc is +"+Exc.toString());
      setState(() {
        getResult = false;
      });
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


  CreateVirtualSurvey()async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    Map mydata ={
      'order_id': widget.id,
      'condition_id': _selectedVirtualStatusID,
      'port_id': _selectedPortID,
      'remark': _txtRemarkController.text
    };

    print(mydata);

    try{
      await APIServices.Create_Virtual_Survey(mydata).then((response){
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
    getOneOrder();
    getPort();
    getVirtualStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("New Virtual Servey"),
      ),
      body: dataReturnStatus == false ? Center(
        child: CircularProgressIndicator(),
      ): dataReturnStatus == true && getResult == false ? Center(
        child: Text("No Data")
      ):ListView(
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
                                  Text(oneOrderModel.package.packagetype.name),
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
                                  Text(oneOrderModel.package.name),
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
                                  Text(oneOrderModel.payment.name),
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
                                  Text(oneOrderModel.planId),
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
                                  Text(oneOrderModel.remark),
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
                                  Text(oneOrderModel.customer.address.state.name),
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
                                  Text(oneOrderModel.customer.address.town.name),
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
                                  Text(oneOrderModel.customer.address.ward),
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
                                  Text(oneOrderModel.customer.address.street),
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
                                  Text(oneOrderModel.customer.address.home),
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
                                  Text(oneOrderModel.customer.address.floor),
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
                                  Text(oneOrderModel.customer.address.room),
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
                                  Text(oneOrderModel.customer.address.lat),
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
                                  Text(oneOrderModel.customer.address.lng),
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
                                  Text(oneOrderModel.customer.name),
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
                                  Text(oneOrderModel.customer.nrc),
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
                                  Text(oneOrderModel.customer.email),
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
                                  Text(oneOrderModel.customer.phones[0].phone.toString()),
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
                                  Text(oneOrderModel.customer.phones[1].phone.toString()),
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
                      child: Text("Servey Detail"),
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
                child: Text("Save"),
                onPressed: (){
                  CreateVirtualSurvey();
                }),
          ),
        ],
      ),
    );
  }
}
