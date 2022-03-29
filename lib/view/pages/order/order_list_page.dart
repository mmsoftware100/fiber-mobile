import 'dart:convert';
import 'dart:io';

import 'package:fiber_oms_flutter/model/all_order_model.dart';
import 'package:fiber_oms_flutter/utils/dialogue.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:fiber_oms_flutter/view/pages/installation/installation_list_page.dart';
import 'package:fiber_oms_flutter/view/pages/installation/installation_schedule_page.dart';
import 'package:fiber_oms_flutter/view/pages/order/edit_order_details_page.dart';
import 'package:fiber_oms_flutter/view/pages/order/new_order_insert_page.dart';
import 'package:fiber_oms_flutter/view/pages/order/order_details_page.dart';
import 'package:fiber_oms_flutter/view/pages/service/service_list_page.dart';
import 'package:fiber_oms_flutter/view/pages/service/services_schedule_page.dart';
import 'package:fiber_oms_flutter/view/pages/tickest/tickest_list_page.dart';
import 'package:fiber_oms_flutter/view/pages/tickest/ticket_check_list_page.dart';
import 'package:fiber_oms_flutter/view/pages/virtual_survey/virtual_servay_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  int currentPage = 1;
  late int lastPage;
  bool dataReturnStatus = false;

  List<AllOrderModel> allOrderList = [];
  bool getResult = false;

  getOrderList()async{
    try{
      await APIServices.Get_All_Orders().then((value){
        print("response.body"+value.toString());
        print(value);

        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("Get_All_Orders data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data'];

        print("Get_All_Orders of aung is "+dataList.toString());

        setState(() {
          getResult = true;
          allOrderList.clear();
          for(int i=0; i<dataList.length; i++){
            try{
              allOrderList.add(AllOrderModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(allOrderList);
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

  getNextPageOrders()async{

    try{
      await APIServices.Get_Next_Orders_Page(currentPage.toString()).then((value){
        Map<String, dynamic> dataResponse = jsonDecode(value);

        print("getNextPageOrders data is "+dataResponse.toString());

        List<dynamic> dataList =  dataResponse['data']['data'];

        print("getNextPageOrders of aung is "+dataList.toString());
        setState(() {
          dataReturnStatus = true;
          for(int i=0; i<dataList.length; i++){
            try{
              allOrderList.add(AllOrderModel.fromJson(dataList[i]));
              print("hello "+i.toString());
              print(allOrderList);
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
    await getOrderList();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    if(currentPage < lastPage){
      setState(() {
        currentPage ++;
      });
      await getNextPageOrders();
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
    getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Order List"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Container(
              color: Colors.red,
              child: Center(child: Text("Myanmar Link",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
            )
            ),
            Card(
              child: ListTile(
                title: Text("Order List"),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrderListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Tickest List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TickestListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Tickest Check List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TickestCheckListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Virtual Servay List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VirtualServayListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Installation Schedule"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>InstallationSchedulePage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Installation List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>InstallationListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Services Schedule"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ServicesSchedulePage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Services List"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceListPage()));
                },
              ),
            ),

          ],
        ),
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
          ): getResult == true && allOrderList.length == 0 ? Center(
            child: Text("No Data "),
          ):
          ListView(
            children: allOrderList.map((e) {
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
                                  Text("code"),
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
                                  Text("အမည်"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(e.customer.name),

                                ],
                              )
                            ]
                        ),


                      ],
                    ),
                  ),
                  // trailing: Row(
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(Icons.edit),
                  //       onPressed: () {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderDetailsPage(e.id)));
                  //
                  //       },
                  //     ),
                  //     IconButton(
                  //       icon: Icon(Icons.edit),
                  //       onPressed: () {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderDetailsPage(e.id)));
                  //
                  //       },
                  //     ),
                  //   ],
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditOrderDetailsPage(e.id)));

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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsPage(e.id)));
                  },
                ),
              );

            }).toList(),
          )
      ),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewOrderInsertPage()));

        },
        icon: new Icon(Icons.add),
        label: const Text("New"),
        backgroundColor: Colors.red,
      ),

    );
  }
}
