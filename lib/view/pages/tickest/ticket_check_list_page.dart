import 'dart:convert';

import 'package:fiber_oms_flutter/model/all_ticket_ckeck_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:fiber_oms_flutter/view/pages/tickest/edit_ticket_check_page.dart';
import 'package:fiber_oms_flutter/view/pages/tickest/new_ticket_check_add_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TickestCheckListPage extends StatefulWidget {
  const TickestCheckListPage({Key? key}) : super(key: key);

  @override
  _TickestCheckListPageState createState() => _TickestCheckListPageState();
}

class _TickestCheckListPageState extends State<TickestCheckListPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  int currentPage = 1;
  late int lastPage;
  bool dataReturnStatus = false;

  List<AllTicketCheckModel> allTicketCheckList = [];
  bool getResult = false;

  getTicketCheckList()async{
    try{
      await APIServices.Get_All_TicketCheck().then((value){
        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getTicketCheckList data is "+dataResponse.toString());

        setState(() {
          lastPage = dataResponse['data']['last_page'];
          print("lastPage is "+lastPage.toString());
        });

        print("Hello"+dataResponse['data']['data'].toString());

        List<dynamic> dataList =  dataResponse['data']['data'];

        print("getTicketCheckList of aung is "+dataList.toString());

        setState(() {
          getResult = true;
          allTicketCheckList.clear();
          for(int i=0; i<dataList.length; i++){
            try{
              allTicketCheckList.add(AllTicketCheckModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(allTicketCheckList);
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

  getNextPageTicketCheck()async{

    try{
      await APIServices.Get_Next_Ticket_Check_Page(currentPage.toString()).then((value){
        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getNextPageTicketCheck data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data']['data'];

        print("getNextPageTicketCheck of aung is "+dataList.toString());
        setState(() {
          dataReturnStatus = true;
          for(int i=0; i<dataList.length; i++){
            try{
              allTicketCheckList.add(AllTicketCheckModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(allTicketCheckList);
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
    await getTicketCheckList();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    if(currentPage < lastPage){
      setState(() {
        currentPage ++;
      });
      await getNextPageTicketCheck();
    }



    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  _deleteTicket(String id)async{

    Dialogs.showLoadingDialog(context, _keyLoader);//invoking login

    await APIServices.Delete_Ticket(id).then((value) {
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
                  _deleteTicket(id);
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
    getTicketCheckList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Ticket Check List"),
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
            ): getResult == true && allTicketCheckList.length == 0 ? Center(
              child: Text("No Data "),
            ):
            ListView(
              children: allTicketCheckList.map((e) {
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
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTicketCheckPage(e.id)));
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTicketCheckPage(e.id)));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTicketCheckAddPage(e.id)));
                    },
                  ),
                );

              }).toList(),
            )
        )

    );
  }
}
