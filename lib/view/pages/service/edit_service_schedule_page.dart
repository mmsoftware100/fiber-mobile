import 'dart:convert';

import 'package:fiber_oms_flutter/model/check_result_model.dart';
import 'package:fiber_oms_flutter/model/one_ticket_check_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditServiceSchedulePage extends StatefulWidget {
  String id;
  EditServiceSchedulePage(this.id);

  @override
  _EditServiceSchedulePageState createState() => _EditServiceSchedulePageState();
}

class _EditServiceSchedulePageState extends State<EditServiceSchedulePage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  late OneTicketCheckModel oneTicketCheckModel ;
  bool dataReturnStatus = false;

  TextEditingController _txtRemarkController = TextEditingController();

  List<CheckResultModel> checkResultListModel = [];
  String _selectedcheckResultID = '';
  List<String> _checkResultIDArrayList = [];

  getOneTicketChek()async{
    //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    print("id is "+widget.id);
    try{
      await APIServices.Get_One_TicketCheck(widget.id).then((value){


        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getOneTicketChek  data is "+dataResponse.toString());
        setState(() {
          dataReturnStatus = true;
          oneTicketCheckModel = OneTicketCheckModel.fromJson(json.decode(value)['data']);
          print("hello "+oneTicketCheckModel.toString());

          _selectedcheckResultID= oneTicketCheckModel.checkResultId;
          _txtRemarkController.text = oneTicketCheckModel.remark;
        });

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<CheckResultModel>> getCheckResult() async{
    try{
      await APIServices.Get_CheckResult().then((value) {
        print("response.body"+value.toString());
        print(value);

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getCheckResult data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getCheckResult of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              checkResultListModel.add(CheckResultModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(checkResultListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(checkResultListModel.length > 0){
            setState(() {
              checkResultListModel.forEach((value){
                print("value.checkResultCode is "+value.id);
                _checkResultIDArrayList.add(value.id);

              });
              _selectedcheckResultID = _checkResultIDArrayList[0];
            });
          }
        });

        print("checkResultListModel is "+checkResultListModel.toString());

        return checkResultListModel;
      });
      return checkResultListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  void _onSelectedCheckResultCode(String value){

    setState((){
      _selectedcheckResultID = value;

    });
  }

  EditServiceSchedule()async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    Map mydata ={
      'id': widget.id,
      'checkresult_id': _selectedcheckResultID,
      'remark': _txtRemarkController.text
    };

    print(mydata);

    try{
      await APIServices.Edit_TicketCheck(mydata).then((response){
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

    getOneTicketChek();

    super.initState();
    getCheckResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Edit Service Schedule"),
      ),
      body: ListView(
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
                      child: Text("Tickest Check Detail"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Package Type"),
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
                            items: checkResultListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedCheckResultCode(value.toString()),
                            value: _selectedcheckResultID,
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
                          EditServiceSchedule();
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
