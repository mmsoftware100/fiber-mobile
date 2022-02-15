import 'package:flutter/material.dart';

class NewSericeScheduleAddPage extends StatefulWidget {
  const NewSericeScheduleAddPage({Key? key}) : super(key: key);

  @override
  _NewSericeScheduleAddPageState createState() => _NewSericeScheduleAddPageState();
}

class _NewSericeScheduleAddPageState extends State<NewSericeScheduleAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Service Schedule"),
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
                      child: Text("Service Schedule Detail"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Order Code",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Checking Result",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Shedule Stautus",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Team",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Start Date",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "End Date",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Remark",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Action",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Detail",
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
