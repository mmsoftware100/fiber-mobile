import 'package:fiber_oms_flutter/view/pages/virtual_survey/new_virtual_servrey_add_page.dart';
import 'package:flutter/material.dart';

class VirtualServayListPage extends StatefulWidget {
  const VirtualServayListPage({Key? key}) : super(key: key);

  @override
  _VirtualServayListPageState createState() => _VirtualServayListPageState();
}

class _VirtualServayListPageState extends State<VirtualServayListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtual Servay List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No Data"),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: MaterialButton(
            //       height: 58,
            //       minWidth: 340,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: new BorderRadius.circular(12)),
            //       color: Colors.blue,
            //       child: Text("New Virtual Servey",style: TextStyle(color: Colors.white),),
            //       onPressed: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>NewVirtulServeyAddPage()));
            //       }),
            // ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewVirtulServeyAddPage()));

        },
        icon: new Icon(Icons.add),
        label: const Text("New"),
      ),

    );
  }
}
