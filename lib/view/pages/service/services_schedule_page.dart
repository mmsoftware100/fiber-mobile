import 'dart:convert';

import 'package:fiber_oms_flutter/model/all_service_schedule_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:fiber_oms_flutter/view/pages/service/edit_service_schedule_page.dart';
import 'package:fiber_oms_flutter/view/pages/service/new_service_schedule_add_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ServicesSchedulePage extends StatefulWidget {
  const ServicesSchedulePage({Key? key}) : super(key: key);

  @override
  _ServicesSchedulePageState createState() => _ServicesSchedulePageState();
}

class _ServicesSchedulePageState extends State<ServicesSchedulePage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  int currentPage = 1;
  late int lastPage;
  bool dataReturnStatus = false;

  List<AllServiceScheduleModel> allServiceScheduleList = [];
  bool getResult = false;

  getServiceScheduleList()async{
    try{
      await APIServices.Get_All_Service_Schedule().then((value){
        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getServiceScheduleList data is "+dataResponse.toString());

        setState(() {
          lastPage = dataResponse['data']['last_page'];
          print("lastPage is "+lastPage.toString());
        });

        print("Hello"+dataResponse['data']['data'].toString());

        List<dynamic> dataList =  dataResponse['data']['data'];

        print("getServiceScheduleList of aung is "+dataList.toString());

        setState(() {
          getResult = true;
          allServiceScheduleList.clear();
          for(int i=0; i<dataList.length; i++){
            try{
              allServiceScheduleList.add(AllServiceScheduleModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(allServiceScheduleList);
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

  getNextPageServiceSchedule()async{

    try{
      await APIServices.Get_Next_Service_Schedule_Page(currentPage.toString()).then((value){
        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getNextPageServiceSchedule data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data']['data'];

        print("getNextPageServiceSchedule of aung is "+dataList.toString());
        setState(() {
          dataReturnStatus = true;
          for(int i=0; i<dataList.length; i++){
            try{
              allServiceScheduleList.add(AllServiceScheduleModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(allServiceScheduleList);
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
    await getServiceScheduleList();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    if(currentPage < lastPage){
      setState(() {
        currentPage ++;
      });
      await getNextPageServiceSchedule();
    }



    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  _deleteTicketCheck(String id)async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    await APIServices.Delete_TicketCheck(id).then((value) {
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
          content: new Text("Data ???????????????????????????????????????????????????????????????..?"),
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
                  _deleteTicketCheck(id);
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
          content: new Text("Data ?????????????????????????????????????????????????????????????????????????????????"),
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
          content: new Text("Data ???????????????????????????????????????????????????????????????????????????"),
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
    getServiceScheduleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Services Schedule"),
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
            ): getResult == true && allServiceScheduleList.length == 0 ? Center(
              child: Text("No Data "),
            ):
            ListView(
              children: allServiceScheduleList.map((e) {
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
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>EditServiceSchedulePage(e.id)));
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditServiceSchedulePage(e.id)));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewSericeScheduleAddPage(e.id)));
                    },
                  ),
                );

              }).toList(),
            )
        )

    );
  }
}
