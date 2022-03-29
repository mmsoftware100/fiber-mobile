import 'dart:convert';

import 'package:fiber_oms_flutter/model/one_installation_schedule_model.dart';
import 'package:fiber_oms_flutter/model/one_virtual_survey_model.dart';
import 'package:fiber_oms_flutter/model/team_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditInstallationPage extends StatefulWidget {
  String id;
  EditInstallationPage(this.id);

  @override
  _EditInstallationPageState createState() => _EditInstallationPageState();
}

class _EditInstallationPageState extends State<EditInstallationPage> {


  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  late OneInstallationScheduleModel oneInstallationModel ;
  bool dataReturnStatus = false;

  List<TeamModel> teamListModel = [];
  String _selectedTeamID = '';
  List<String> _teamIDArrayList = [];

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

          _selectedTeamID= oneInstallationModel.teamId;
          _startDate = oneInstallationModel.startDate;
          _endDate = oneInstallationModel.endDate;
          _txtRemarkController.text = oneInstallationModel.remark;
        });

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<TeamModel>> getTeam() async{
    try{
      await APIServices.Get_Teams().then((value) {
        print(value);

        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getTeam data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getTeam of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              teamListModel.add(TeamModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(teamListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(teamListModel.length > 0){
            setState(() {
              teamListModel.forEach((value){
                print("value.teamCode is "+value.id);
                _teamIDArrayList.add(value.id);
              });
              _selectedTeamID = _teamIDArrayList[0];
            });
          }
        });

        print("teamListModel is "+teamListModel.toString());

        return teamListModel;
      });
      return teamListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  void _onSelectedTeamCode(String value){

    setState((){
      _selectedTeamID = value;

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

  EditInstallation()async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    Map mydata ={
      'id': widget.id,
      'remark': _txtRemarkController.text,
      'team_id': _selectedTeamID,
      'start_date': _startDate,
      'end_date': _endDate
    };

    print(mydata);

    try{
      await APIServices.Edit_Installation(mydata).then((response){
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
    getTeam();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Edit Installation Schedulel"),
      ),
      body: dataReturnStatus == false ? Center(
        child: CircularProgressIndicator(),
      ): ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              children: [
                TableRow(
                    children: [
                      Column(
                        children: [
                          Text("ID"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(oneInstallationModel.id),
                        ],
                      )
                    ]
                ),
                TableRow(
                    children: [
                      Column(
                        children: [
                          Text("code"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(oneInstallationModel.virtualsurvey.order.code),
                        ],
                      )
                    ]
                ),
                TableRow(
                    children: [
                      Column(
                        children: [
                          Text("Customer Name"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(oneInstallationModel.virtualsurvey.order.customer.name),
                        ],
                      )
                    ]
                ),
                TableRow(
                    children: [
                      Column(
                        children: [
                          Text("Remark"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(oneInstallationModel.remark),
                        ],
                      )
                    ]
                )
              ],
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
                    child: Text("Team"),
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
                            items: teamListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedTeamCode(value.toString()),
                            value: _selectedTeamID,
                          ),
                        ),
                      ),
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
                  EditInstallation();
                }),
          ),
        ],
      ),
    );
  }
}
