import 'dart:convert';

import 'package:fiber_oms_flutter/model/check_result_model.dart';
import 'package:fiber_oms_flutter/model/one_ticket_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTicketCheckAddPage extends StatefulWidget {
  String id;
  NewTicketCheckAddPage(this.id);

  @override
  _NewTicketCheckAddPageState createState() => _NewTicketCheckAddPageState();
}

class _NewTicketCheckAddPageState extends State<NewTicketCheckAddPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  late OneTicketModel oneTicketModel ;
  bool dataReturnStatus = false;

  TextEditingController _txtRemarkController = TextEditingController();

  List<CheckResultModel> checkResultListModel = [];
  String _selectedcheckResultID = '';
  List<String> _checkResultIDArrayList = [];


  getOneTicketCheck()async{
    //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    print("id is "+widget.id);
    try{
      await APIServices.Get_One_Ticket(widget.id).then((value){


        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getOneTicketCheck data is "+dataResponse.toString());
        setState(() {
          print("Ok here");
          dataReturnStatus = true;
          oneTicketModel = OneTicketModel.fromJson(dataResponse['data']);
          print("hello "+oneTicketModel.toString());
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

  insertTicketCheck()async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    Map mydata ={
      'ticket_id': widget.id,
      'checkresult_id': _selectedcheckResultID,
      'remark': _txtRemarkController.text
    };

    print(mydata);

    try{
      await APIServices.Create_Ticket_Check(mydata).then((response){
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
    getOneTicketCheck();
    getCheckResult();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("New Ticket Check"),
      ),
      body: dataReturnStatus == false ? Center(
        child: CircularProgressIndicator(),
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
                                  Text(oneTicketModel.order.code),
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
                                  Text(oneTicketModel.order.package.packagetype.name),
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
                                  Text(oneTicketModel.issue.name),
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
                                  Text(oneTicketModel.remark),
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
                          insertTicketCheck();
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
