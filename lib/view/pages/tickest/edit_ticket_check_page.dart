import 'dart:convert';

import 'package:fiber_oms_flutter/model/issue_model.dart';
import 'package:fiber_oms_flutter/model/one_ticket_model.dart';
import 'package:fiber_oms_flutter/model/package_type_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditTicketCheckPage extends StatefulWidget {
  String id;
  EditTicketCheckPage(this.id);

  @override
  _EditTicketCheckPageState createState() => _EditTicketCheckPageState();
}

class _EditTicketCheckPageState extends State<EditTicketCheckPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  late OneTicketModel oneTicketModel ;
  bool dataReturnStatus = false;

  TextEditingController _txtOrderCodeController = TextEditingController();
  TextEditingController _txtRemarkController = TextEditingController();


  List<PackageTypeModel> packageTypeListModel = [];
  String _selectedpackageTypeID = '';
  List<String> _packageTypeIDArrayList = [];

  List<IssueModel>issueListModel = [];
  String _selectedIssueCode = '';
  List<String> _issueCodeArrayList = [];


  getOneTicket()async{
    //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
    print("id is "+widget.id);
    try{
      await APIServices.Get_One_Ticket(widget.id).then((value){


        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getoneTicketModel  data is "+dataResponse.toString());
        setState(() {
          dataReturnStatus = true;
          oneTicketModel = OneTicketModel.fromJson(json.decode(value)['data']);
          print("hello "+oneTicketModel.toString());

          _txtOrderCodeController.text = oneTicketModel.order.code;
          _selectedIssueCode= oneTicketModel.issueId;
          _txtRemarkController.text = oneTicketModel.remark;
        });

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }


  Future<List<PackageTypeModel>> getPackageTypeModel() async{
    try{
      await APIServices.Get_PackageTypes().then((value) {
        print(value);

        //Navigator.of(context,rootNavigator: true).pop();//close the dialoge

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getPackageTypeModel data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("getPackageTypeModel of aung is "+dataList.toString());

        print("Hi data "+dataList.length.toString());
        setState(() {
          for(int i=0; i<dataList.length; i++){
            try{
              packageTypeListModel.add(PackageTypeModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(packageTypeListModel);
            }
            catch(exp){
              print("intername exp");
            }
          }

          if(packageTypeListModel.length > 0){
            setState(() {
              packageTypeListModel.forEach((value){
                print("value.packageTypeCode is "+value.id);
                _packageTypeIDArrayList.add(value.id);
              });
              _selectedpackageTypeID = _packageTypeIDArrayList[0];
            });
          }
        });

        print("packageTypeListModel is "+packageTypeListModel.toString());

        return packageTypeListModel;
      });
      return packageTypeListModel ;
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }

  Future<List<IssueModel>> getIssue() async{
    try{
      await APIServices.Get_Issues().then((value) {
        print("response.body"+value.toString());
        print(value);

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("Get_Issues data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("Get_Issues of aung is "+dataList.toString());

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
                _issueCodeArrayList.add(value.id);

              });
              _selectedIssueCode = _issueCodeArrayList[0];
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

  void _onSelectedPackageTypeCode(String value){

    setState((){
      _selectedpackageTypeID = value;

    });
  }

  void _onSelectedIssueCode(String value){

    setState((){
      _selectedIssueCode = value;

    });
  }

  EditTicket()async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    Map mydata ={
      'id':widget.id,
      'order_code': _txtOrderCodeController.text,
      'issue_id': _selectedIssueCode,
      'remark': _txtRemarkController.text
    };

    print(mydata);

    try{
      await APIServices.Edit_Ticket(mydata).then((response){
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

    getOneTicket();

    super.initState();
    getPackageTypeModel();
    getIssue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Edit Ticket Check"),
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
                      child: Text("Tickest Detial"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _txtOrderCodeController,
                        decoration: InputDecoration(
                          labelText: "Order Code",
                          border: OutlineInputBorder(),
                        )
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
                            items: packageTypeListModel.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.name),
                              );
                            }).toList(),
                            //onChanged: (value) => print("hello value "+value.),
                            onChanged: (value) => _onSelectedPackageTypeCode(value.toString()),
                            value: _selectedpackageTypeID,
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
                            value: _selectedIssueCode,
                          ),
                        ),
                      ),
                    ),
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
                  EditTicket();
                }),
          ),

        ],
      ),
    );
  }
}
