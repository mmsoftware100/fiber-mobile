import 'dart:convert';

import 'package:fiber_oms_flutter/model/all_virtual_survey_modle.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:fiber_oms_flutter/view/pages/virtual_survey/edit_virtual_survey_page.dart';
import 'package:fiber_oms_flutter/view/pages/virtual_survey/new_virtual_servrey_add_page.dart';
import 'package:fiber_oms_flutter/view/pages/virtual_survey/virtual_survey_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VirtualServayListPage extends StatefulWidget {
  const VirtualServayListPage({Key? key}) : super(key: key);

  @override
  _VirtualServayListPageState createState() => _VirtualServayListPageState();
}

class _VirtualServayListPageState extends State<VirtualServayListPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  int currentPage = 1;
  late int lastPage;
  bool dataReturnStatus = false;

  List<AllVirtualSurveyModel> allVirtualSurveyList = [];
  bool getResult = false;

  getVirtualSurveyList()async{
    try{
      await APIServices.Get_All_Virtual_Surveys().then((value){
        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getVirtualSurveyList data is "+dataResponse.toString());

        setState(() {
          lastPage = dataResponse['data']['last_page'];
          print("lastPage is "+lastPage.toString());
        });

        print("Hello"+dataResponse['data']['data'].toString());

        List<dynamic> dataList =  dataResponse['data']['data'];

        print("getVirtualSurveyList of aung is "+dataList.toString());

        setState(() {
          getResult = true;
          allVirtualSurveyList.clear();
          for(int i=0; i<dataList.length; i++){
            try{
              allVirtualSurveyList.add(AllVirtualSurveyModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(allVirtualSurveyList);
            }
            catch(exp){
              print("intername exp");
            }
          }
        });
      });
    }
    catch(Exc){
      print(Exc);
      rethrow;
    }
  }

  getNextPageVirtualSurvey()async{

    try{
      await APIServices.Get_Next_Virtual_Surveys_Page(currentPage.toString()).then((value){
        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getNextPageVirtualSurvey data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data']['data'];

        print("getNextPageVirtualSurvey of aung is "+dataList.toString());
        setState(() {
          dataReturnStatus = true;
          for(int i=0; i<dataList.length; i++){
            try{
              allVirtualSurveyList.add(AllVirtualSurveyModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(allVirtualSurveyList);
            }
            catch(exp){
              print("intername exp");
            }
          }
        });

      });
    }
    catch (Exc) {
      print(Exc);
      rethrow;
    }
  }


  void _onRefresh() async{
    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      //allParcelModelList.clear();
      currentPage = 1;
    });
    await getVirtualSurveyList();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    if(currentPage < lastPage){
      setState(() {
        currentPage ++;
      });
      await getNextPageVirtualSurvey();
    }



    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  _deleteOrder(String id)async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    await APIServices.Delete_Order(id).then((value) {
      print("value is "+value);
      Navigator.of(context,rootNavigator: true).pop();//close the dialoge
      Map<String, dynamic> dataResponse = jsonDecode(value);
      //List<dynamic> dataList =  dataResponse['data'];

      print("dataResponse is "+dataResponse.toString());

      if(dataResponse['status'].toString() == "true"){
        _deletedRecordSuccessDialog();
      }
      else{
        _deletedRecordFaildDialog();
      }
    });
  }

  void _confirmToDeleteItemDialog(String id) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("Alert"),
          content: new Text("Data ဖျက်မည်မှာသေချာပါသလား..?"),
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteOrder(id);
                },
              ),
            )
          ],
        );
      },
    );
  }

  void _deletedRecordSuccessDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("Success"),
          content: new Text("Data ဖျက်သိမ်းမှုအောင်မြင်ပါသည်။"),
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        );
      },
    );
  }

  void _deletedRecordFaildDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: new Text("Faild"),
          content: new Text("Data ဖျက်သိမ်းမှုမအောင်မြင်ပါ။"),
          actions: <Widget>[
            CupertinoDialogAction(
              child:
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVirtualSurveyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Virtual Servay List"),
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context,LoadStatus? mode){
              Widget body ;
              if(mode==LoadStatus.idle){
                body =  Text("pull up load");
              }
              else if(mode==LoadStatus.loading){
                body =  CupertinoActivityIndicator();
              }
              else if(mode == LoadStatus.failed){
                body = Text("Load Failed!Click retry!");
              }
              else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
              }
              else{
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child:body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child:getResult == false ? Center(
            child: CircularProgressIndicator(),
          ): getResult == true && allVirtualSurveyList.length == 0 ? Center(
            child: Text("No Data "),
          ):
          ListView(
            children: allVirtualSurveyList.map((e) {
              return Card(
                child: ListTile(
                  title: Padding(
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
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(e.code),

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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.remark),

                                ],
                              )
                            ]
                        ),

                      ],
                    ),
                  ),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.edit),
                  //   onPressed: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>EditVirtualSurveyPage(e.id)));
                  //
                  //   },
                  // ),
                  trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Text("Edit"),
                              IconButton(
                                icon: Icon(Icons.edit,color: Colors.blue,),
                                onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditVirtualSurveyPage(e.id)));

                                },
                              ),
                            ],
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Text("Delete"),
                              IconButton(
                                icon: Icon(Icons.delete,color: Colors.red,),
                                onPressed: () {
                                  _confirmToDeleteItemDialog(e.id);
                                },
                              ),
                            ],
                          ),
                          value: 2,
                        )
                      ]
                  ),

                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewVirtulServeyAddPage(e.id)));
                  },
                ),
              );

            }).toList(),
          )
      )


    );
  }
}
