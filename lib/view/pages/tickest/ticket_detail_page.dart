import 'dart:convert';

import 'package:fiber_oms_flutter/model/one_ticket_model.dart';
import 'package:fiber_oms_flutter/utils/rest_api.dart';
import 'package:flutter/material.dart';

class TicketDetailPage extends StatefulWidget {
  String id;
  TicketDetailPage(this.id);

  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {


  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  late OneTicketModel oneTicketModel ;
  bool dataReturnStatus = false;

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOneTicketCheck();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Ticket Detail"),
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
        ],
      ),
    );

  }
}
