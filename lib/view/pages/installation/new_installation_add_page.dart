import 'package:flutter/material.dart';

class NewInstallationAddPage extends StatefulWidget {
  const NewInstallationAddPage({Key? key}) : super(key: key);

  @override
  _NewInstallationAddPageState createState() => _NewInstallationAddPageState();
}

class _NewInstallationAddPageState extends State<NewInstallationAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Installation"),
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
                      child: Text("Installation Detail"),
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
                          labelText: "Survey Status",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "ONU ID",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "ONU SN",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "ODB Name",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "ODB Location",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Cable",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "User Port",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Splitter Output Signal(-dBm)",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "ONU Input Signal(-dBm)",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Installatiion Stautus",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "Start",
                          border: OutlineInputBorder(),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _txtSenderNameController,
                        decoration: InputDecoration(
                          labelText: "End",
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
